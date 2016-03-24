import iup, os, marshal
#тестовое соообщение
proc select_file(parent_dlg: PIhandle; is_open: cint): cint =
  var config: PIhandle = cast[PIhandle](iup.getAttribute(parent_dlg, "CONFIG"))
  var canvas: PIhandle = iup.getDialogChild(parent_dlg, "CANVAS")
  var dir: cstring = iup.configGetVariableStr(config, "MainWindow", "LastDirectory")
  var filedlg: PIhandle = iup.fileDlg()
  if is_open == 1:
    iup.setAttribute(filedlg, "DIALOGTYPE", "OPEN")
  else:
    iup.setAttribute(filedlg, "DIALOGTYPE", "SAVE")
    iup.setStrAttribute(filedlg, "FILE", iup.getAttribute(canvas, "FILENAME"))
  iup.setAttribute(filedlg, "EXTFILTER",
                  "Image Files|*.bmp;*.jpg;*.png;*.tif;*.tga|All Files|*.*|")
  iup.setStrAttribute(filedlg, "DIRECTORY", dir)
  iup.setAttributeHandle(filedlg, "PARENTDIALOG", parent_dlg)
  iup.popup(filedlg, IUP_CENTERPARENT, IUP_CENTERPARENT)
  if iup.getInt(filedlg, "STATUS") != - 1:
    var filename: cstring = iup.getAttribute(filedlg, "VALUE")
    #  if is_open == 1: open_file(parent_dlg, filename)
    #  else: saveas_file(canvas, filename)
    dir = iup.getAttribute(filedlg, "DIRECTORY")
    iup.configSetVariableStr(config, "MainWindow", "LastDirectory", dir)
  iup.destroy(filedlg)
  return IUP_DEFAULT

proc save_file*(canvas: PIhandle) =
  var filename: cstring = iup.getAttribute(canvas, "FILENAME")
#  var image: ptr imImage = cast[ptr imImage](IupGetAttribute(canvas, "IMAGE"))
#  if write_file(filename, image): IupSetAttribute(canvas, "DIRTY", "NO")
#-------------------------------------------------------------------------------------------------------------------------------------------
proc save_check(ih: PIhandle): cint =                                                 #int save_check(Ihandle* ih)                                                            
  var canvas: PIhandle = iup.getDialogChild(ih, "CANVAS")                             #{                                                                                      
  #STUB iup.setAttribute(canvas, "DIRTY", "YES");
  echo iup.getInt(canvas, "DIRTY")
  if (iup.getInt(canvas, "DIRTY") == 1):                                              #  Ihandle* canvas = IupGetDialogChild(ih, "CANVAS");                                   
    case iup.alarm("Warning", "File not saved! Save it now?", "Yes", "No", "Cancel")  #  if (IupGetInt(canvas, "DIRTY"))                                                      
    of 1:                      ## # save the changes and continue                     #  {                                                                                    
      save_file(canvas)                                                               #    switch (IupAlarm("Warning", "File not saved! Save it now?", "Yes", "No", "Cancel"))
    #of 2:                      ## # ignore the changes and continue                  #    {                                                                                  
    #  discard                                                                             #    case 1:  /* save the changes and continue */                                       
    of 3:                      ## # cancel                                            #      save_file(canvas);                                                               
      return 0                                                                        #      break;                                                                           
    else:                                                                             #    case 2:  /* ignore the changes and continue */
      discard                                                                         #      break;                                      
  return 1                                                                            #    case 3:  /* cancel */                                                              
                                                                                      #      return 0;                                                                        
                                                                                      #    }                                                                                  
                                                                                      #  }                                                                                    
                                                                                      #  return 1;                                                                            
                                                                                      #}                                                                                      
#-------------------------------------------------------------------------------------------------------------------------------------------

proc item_open_action_cb(item_open: PIhandle): cint {.cdecl.} =       #int item_open_action_cb(Ihandle* item_open)
  if save_check(item_open) != 1: return IUP_DEFAULT                   #{                                                
  return select_file(iup.getDialog(item_open), 1)                     #  if (!save_check(item_open))                    
                                                                      #    return IUP_DEFAULT;                          
                                                                      #                                                 
                                                                      #  return select_file(IupGetDialog(item_open), 1);
                                                                      #}                                                

proc check_new_file*(dlg: PIhandle) =
  echo "check_new_file"

proc open_file*(ih: PIhandle; filename: cstring) =
  echo "open_file"

proc config_recent_cb*(ih: PIhandle): cint =
  if save_check(ih) == 1:
    var filename: cstring = iup.getAttribute(ih, "TITLE")
# todo    open_file(ih, filename)
  return IUP_DEFAULT

proc create_main_dialog*(config: PIhandle): PIhandle =
#proc create_main_dialog(config: PIhandle): PIhandle =                 # Ihandle* create_main_dialog(Ihandle *config)
                                                                      # {
                                                                      #   Ihandle *dlg, *vbox, *canvas, *menu;
                                                                      #   Ihandle *sub_menu_file, *file_menu, *item_exit, *item_new, *item_open, *item_save, *item_saveas, *item_revert;
                                                                      #   Ihandle *sub_menu_edit, *edit_menu, *item_copy, *item_paste;
                                                                      #   Ihandle *btn_copy, *btn_paste, *btn_new, *btn_open, *btn_save;
                                                                      #   Ihandle *sub_menu_help, *help_menu, *item_help, *item_about;
                                                                      #   Ihandle *sub_menu_view, *view_menu, *item_toolbar, *item_statusbar;
                                                                      #   Ihandle *statusbar, *toolbar, *recent_menu, *item_background;
                                                                      #
  var canvas = iup.glCanvas(nil)                                      #    canvas = IupGLCanvas(NULL);
  iup.setAttribute(canvas, "NAME", "CANVAS")                          #   IupSetAttribute(canvas, "NAME", "CANVAS");
  iup.setAttribute(canvas, "DIRTY", "NO")                             #   IupSetAttribute(canvas, "DIRTY", "NO");
  iup.setAttribute(canvas, "BUFFER", "DOUBLE")                        #   IupSetAttribute(canvas, "BUFFER", "DOUBLE");
# todo iup.setCallback(canvas, "ACTION", (Icallback)canvas_action_cb)       #   IupSetCallback(canvas, "ACTION", (Icallback)canvas_action_cb);
# todo iup.setCallback(canvas, "DROPFILES_CB", (Icallback)dropfiles_cb)     #   IupSetCallback(canvas, "DROPFILES_CB", (Icallback)dropfiles_cb);
                                                                      #
  var statusbar = iup.label("(0, 0) = [0   0   0]")                   #   statusbar = IupLabel("(0, 0) = [0   0   0]");
  iup.setAttribute(statusbar, "NAME", "STATUSBAR")                    #   IupSetAttribute(statusbar, "NAME", "STATUSBAR");
  iup.setAttribute(statusbar, "EXPAND", "HORIZONTAL")                 #   IupSetAttribute(statusbar, "EXPAND", "HORIZONTAL");
  iup.setAttribute(statusbar, "PADDING", "10x5")                      #   IupSetAttribute(statusbar, "PADDING", "10x5");
                                                                      # 
  var item_new = iup.item("&New\tCtrl+N", nil)                        #   item_new = IupItem("&New\tCtrl+N", NULL);
  iup.setAttribute(item_new, "IMAGE", "IUP_FileNew")                  #   IupSetAttribute(item_new, "IMAGE", "IUP_FileNew");
# todo iup.setCallback(item_new, "ACTION", (Icallback)item_new_action_cb)    #   IupSetCallback(item_new, "ACTION", (Icallback)item_new_action_cb);
  var btn_new = iup.button(nil, nil)                                  #   btn_new = IupButton(NULL, NULL);
  iup.setAttribute(btn_new, "IMAGE", "IUP_FileNew")                   #   IupSetAttribute(btn_new, "IMAGE", "IUP_FileNew");
  iup.setAttribute(btn_new, "FLAT", "Yes")                            #   IupSetAttribute(btn_new, "FLAT", "Yes");
# todo iup.setCallback(btn_new, "ACTION", (Icallback)item_new_action_cb)    #   IupSetCallback(btn_new, "ACTION", (Icallback)item_new_action_cb);
  iup.setAttribute(btn_new, "TIP", "New (Ctrl+N)")                    #   IupSetAttribute(btn_new, "TIP", "New (Ctrl+N)");
  iup.setAttribute(btn_new, "CANFOCUS", "No")                         #   IupSetAttribute(btn_new, "CANFOCUS", "No");
                                                                      # 
  var item_open = iup.item("&Open...\tCtrl+O", nil)                   #   item_open = IupItem("&Open...\tCtrl+O", NULL);
  iup.setAttribute(item_open, "IMAGE", "IUP_FileOpen")                #   IupSetAttribute(item_open, "IMAGE", "IUP_FileOpen");
  discard iup.setCallback(item_open, "ACTION", (Icallback)item_open_action_cb)#  IupSetCallback(item_open, "ACTION", (Icallback)item_open_action_cb);
  var btn_open = iup.button(nil, nil)                                 #   btn_open = IupButton(NULL, NULL);
  iup.setAttribute(btn_open, "IMAGE", "IUP_FileOpen")                 #   IupSetAttribute(btn_open, "IMAGE", "IUP_FileOpen");
  iup.setAttribute(btn_open, "FLAT", "Yes")                           #   IupSetAttribute(btn_open, "FLAT", "Yes");
  iup.setCallback(btn_open, "ACTION", (Icallback)item_open_action_cb) #   IupSetCallback(btn_open, "ACTION", (Icallback)item_open_action_cb);
  iup.setAttribute(btn_open, "TIP", "Open (Ctrl+O)")                  #   IupSetAttribute(btn_open, "TIP", "Open (Ctrl+O)");
  iup.setAttribute(btn_open, "CANFOCUS", "No")                        #   IupSetAttribute(btn_open, "CANFOCUS", "No");
                                                                      # 
  var item_save = iup.item("&Save\tCtrl+S", nil)                      #   item_save = IupItem("&Save\tCtrl+S", NULL);
  iup.setAttribute(item_save, "NAME", "ITEM_SAVE")                    #   IupSetAttribute(item_save, "NAME", "ITEM_SAVE");
  iup.setAttribute(item_save, "IMAGE", "IUP_FileSave")                #   IupSetAttribute(item_save, "IMAGE", "IUP_FileSave");
# todo iup.setCallback(item_save, "ACTION", (Icallback)item_save_action_cb)#   IupSetCallback(item_save, "ACTION", (Icallback)item_save_action_cb);
  var btn_save = iup.button(nil, nil)                                 #   btn_save = IupButton(NULL, NULL);
  iup.setAttribute(btn_save, "IMAGE", "IUP_FileSave")                 #   IupSetAttribute(btn_save, "IMAGE", "IUP_FileSave");
  iup.setAttribute(btn_save, "FLAT", "Yes")                           #   IupSetAttribute(btn_save, "FLAT", "Yes");
# todo iup.setCallback(btn_save, "ACTION", (Icallback)item_save_action_cb) #   IupSetCallback(btn_save, "ACTION", (Icallback)item_save_action_cb);
  iup.setAttribute(btn_save, "TIP", "Save (Ctrl+S)")                  #   IupSetAttribute(btn_save, "TIP", "Save (Ctrl+S)");
  iup.setAttribute(btn_save, "CANFOCUS", "No")                        #   IupSetAttribute(btn_save, "CANFOCUS", "No");
                                                                      # 
  var item_saveas = iup.item("Save &As...", nil)                      #   item_saveas = IupItem("Save &As...", NULL);
  iup.setAttribute(item_saveas, "NAME", "ITEM_SAVEAS")                #   IupSetAttribute(item_saveas, "NAME", "ITEM_SAVEAS");
# todo iup.setCallback(item_saveas, "ACTION", (Icallback)item_saveas_action_cb) #   IupSetCallback(item_saveas, "ACTION", (Icallback)item_saveas_action_cb);
                                                                      # 
  var item_revert = iup.item("&Revert", nil)                          #   item_revert = IupItem("&Revert", NULL);
  iup.setAttribute(item_revert, "NAME", "ITEM_REVERT")                #   IupSetAttribute(item_revert, "NAME", "ITEM_REVERT");
# todo iup.setCallback(item_revert, "ACTION", (Icallback)item_revert_action_cb) #   IupSetCallback(item_revert, "ACTION", (Icallback)item_revert_action_cb);
                                                                      # 
  var item_exit = iup.item("E&xit", nil)                              #   item_exit = IupItem("E&xit", NULL);
# todo  iup.setCallback(item_exit, "ACTION", (Icallback)item_exit_action_cb)#   IupSetCallback(item_exit, "ACTION", (Icallback)item_exit_action_cb);
                                                                      # 
  var item_copy = iup.item("&Copy\tCtrl+C", nil)                      #   item_copy = IupItem("&Copy\tCtrl+C", NULL);
  iup.setAttribute(item_copy, "NAME", "ITEM_COPY")                    #   IupSetAttribute(item_copy, "NAME", "ITEM_COPY");
  iup.setAttribute(item_copy, "IMAGE", "IUP_EditCopy")                #   IupSetAttribute(item_copy, "IMAGE", "IUP_EditCopy");
# todo iup.setCallback(item_copy, "ACTION", (Icallback)item_copy_action_cb)#   IupSetCallback(item_copy, "ACTION", (Icallback)item_copy_action_cb);
  var btn_copy = iup.button(nil, nil)                                 #   btn_copy = IupButton(NULL, NULL);
  iup.setAttribute(btn_copy, "IMAGE", "IUP_EditCopy")                 #   IupSetAttribute(btn_copy, "IMAGE", "IUP_EditCopy");
  iup.setAttribute(btn_copy, "FLAT", "Yes")                           #   IupSetAttribute(btn_copy, "FLAT", "Yes");
# todo iup.setCallback(btn_copy, "ACTION", (Icallback)item_copy_action_cb) #   IupSetCallback(btn_copy, "ACTION", (Icallback)item_copy_action_cb);
  iup.setAttribute(btn_copy, "TIP", "Copy (Ctrl+C)")                  #   IupSetAttribute(btn_copy, "TIP", "Copy (Ctrl+C)");
  iup.setAttribute(btn_copy, "CANFOCUS", "No")                        #   IupSetAttribute(btn_copy, "CANFOCUS", "No");
                                                                      # 
  var item_paste = iup.item("&Paste\tCtrl+V", nil)                    #   item_paste = IupItem("&Paste\tCtrl+V", NULL);
  iup.setAttribute(item_paste, "NAME", "ITEM_PASTE")                  #   IupSetAttribute(item_paste, "NAME", "ITEM_PASTE");
  iup.setAttribute(item_paste, "IMAGE", "IUP_EditPaste")              #   IupSetAttribute(item_paste, "IMAGE", "IUP_EditPaste");
# todo iup.setCallback(item_paste, "ACTION", (Icallback)item_paste_action_cb)#   IupSetCallback(item_paste, "ACTION", (Icallback)item_paste_action_cb);
  var btn_paste = iup.button(nil, nil)                                #   btn_paste = IupButton(NULL, NULL);
  iup.setAttribute(btn_paste, "IMAGE", "IUP_EditPaste")               #   IupSetAttribute(btn_paste, "IMAGE", "IUP_EditPaste");
  iup.setAttribute(btn_paste, "FLAT", "Yes")                          #   IupSetAttribute(btn_paste, "FLAT", "Yes");
# todo iup.setCallback(btn_paste, "ACTION", (Icallback)item_paste_action_cb) #   IupSetCallback(btn_paste, "ACTION", (Icallback)item_paste_action_cb);
  iup.setAttribute(btn_paste, "TIP", "Paste (Ctrl+V)")                #   IupSetAttribute(btn_paste, "TIP", "Paste (Ctrl+V)");
  iup.setAttribute(btn_paste, "CANFOCUS", "No")                       #   IupSetAttribute(btn_paste, "CANFOCUS", "No");
                                                                      # 
  var item_background = iup.item("&Background...", nil)               #   item_background = IupItem("&Background...", NULL);
# todo iup.setCallback(item_background, "ACTION", (Icallback)item_background_action_cb);#   IupSetCallback(item_background, "ACTION", (Icallback)item_background_action_cb);
                                                                      # 
  var item_toolbar = iup.item("&Toobar", nil)                         #   item_toolbar = IupItem("&Toobar", NULL);
# todo iup.setCallback(item_toolbar, "ACTION", (Icallback)item_toolbar_action_cb)#   IupSetCallback(item_toolbar, "ACTION", (Icallback)item_toolbar_action_cb);
  iup.setAttribute(item_toolbar, "VALUE", "ON")                       #   IupSetAttribute(item_toolbar, "VALUE", "ON");
                                                                      # 
  var item_statusbar = iup.item("&Statusbar", nil)                    #   item_statusbar = IupItem("&Statusbar", NULL);
# todo iup.setCallback(item_statusbar, "ACTION", (Icallback)item_statusbar_action_cb)#   IupSetCallback(item_statusbar, "ACTION", (Icallback)item_statusbar_action_cb);
  iup.setAttribute(item_statusbar, "VALUE", "ON")                     #   IupSetAttribute(item_statusbar, "VALUE", "ON");
                                                                      # 
  var item_help = iup.item("&Help...", nil)                           #   item_help = IupItem("&Help...", NULL);
# todo iup.setCallback(item_help, "ACTION", (Icallback)item_help_action_cb)#   IupSetCallback(item_help, "ACTION", (Icallback)item_help_action_cb);
                                                                      # 
  var item_about = iup.item("&About...", nil)                         #   item_about = IupItem("&About...", NULL);
# todo iup.SetCallback(item_about, "ACTION", (Icallback)item_about_action_cb)#   IupSetCallback(item_about, "ACTION", (Icallback)item_about_action_cb);
                                                                      # 
  var recent_menu = iup.menu(nil);                                    #   recent_menu = IupMenu(NULL);
                                                                      # 
  var file_menu = iup.menu(                                           #   file_menu = IupMenu(
    item_new,                                                         #     item_new,
    item_open,                                                        #     item_open,
    item_save,                                                        #     item_save,
    item_saveas,                                                      #     item_saveas,
    item_revert,                                                      #     item_revert,
    iup.separator(),                                                  #     IupSeparator(),
    iup.submenu("Recent &Files", recent_menu),                        #     IupSubmenu("Recent &Files", recent_menu),
    item_exit,                                                        #     item_exit,
    nil)                                                              #     NULL);
  var edit_menu = iup.menu(                                           #   edit_menu = IupMenu(
    item_copy,                                                        #     item_copy,
    item_paste,                                                       #     item_paste,
    nil)                                                              #     NULL);
  var view_menu = iup.menu(                                           #   view_menu = IupMenu(
    item_background,                                                  #     item_background,
    iup.separator(),                                                   #     IupSeparator(),
    item_toolbar,                                                     #     item_toolbar,
    item_statusbar,                                                   #     item_statusbar,
    nil)                                                              #     NULL);
  var help_menu = iup.menu(                                           #   help_menu = IupMenu(
    item_help,                                                        #     item_help,
    item_about,                                                       #     item_about,
    nil)                                                              #     NULL);
                                                                      # 
# todo iup.setCallback(file_menu, "OPEN_CB", (Icallback)file_menu_open_cb) #   IupSetCallback(file_menu, "OPEN_CB", (Icallback)file_menu_open_cb);
# todo iup.setCallback(edit_menu, "OPEN_CB", (Icallback)edit_menu_open_cb) #   IupSetCallback(edit_menu, "OPEN_CB", (Icallback)edit_menu_open_cb);
                                                                      # 
  var sub_menu_file = iup.submenu("&File", file_menu)                 #   sub_menu_file = IupSubmenu("&File", file_menu);
  var sub_menu_edit = iup.submenu("&Edit", edit_menu)                 #   sub_menu_edit = IupSubmenu("&Edit", edit_menu);
  var sub_menu_view = iup.submenu("&View", view_menu)                 #   sub_menu_view = IupSubmenu("&View", view_menu);
  var sub_menu_help = iup.submenu("&Help", help_menu)                 #   sub_menu_help = IupSubmenu("&Help", help_menu);
                                                                      # 
  var menu = iup.menu(                                                #   menu = IupMenu(
    sub_menu_file,                                                    #     sub_menu_file,
    sub_menu_edit,                                                    #     sub_menu_edit,
    sub_menu_view,                                                    #     sub_menu_view,
    sub_menu_help,                                                    #     sub_menu_help,
    nil)                                                              #     NULL);
                                                                      # 
  var toolbar = iup.hbox(                                             #   toolbar = IupHbox(
    btn_new,                                                          #     btn_new,
    btn_open,                                                         #     btn_open,
    btn_save,                                                         #     btn_save,
    iup.setAttributes(iup.label(nil), "SEPARATOR=VERTICAL"),          #     IupSetAttributes(IupLabel(NULL), "SEPARATOR=VERTICAL"),
    btn_copy,                                                         #     btn_copy,
    btn_paste,                                                        #     btn_paste,
    nil)                                                              #     NULL);
  iup.setAttribute(toolbar, "MARGIN", "5x5")                          #   IupSetAttribute(toolbar, "MARGIN", "5x5");
  iup.setAttribute(toolbar, "GAP", "2")                               #   IupSetAttribute(toolbar, "GAP", "2");
                                                                      # 
  var vbox = iup.vbox(                                                #   vbox = IupVbox(
    toolbar,                                                          #     toolbar,
    canvas,                                                           #     canvas,
    statusbar,                                                        #     statusbar,
    nil)                                                              #     NULL);
                                                                      # 
  var dlg = iup.dialog(vbox)                                          #   dlg = IupDialog(vbox);
  iup.setAttributeHandle(dlg, "MENU", menu)                           #   IupSetAttributeHandle(dlg, "MENU", menu);
  iup.setAttribute(dlg, "SIZE", "HALFxHALF")                          #   IupSetAttribute(dlg, "SIZE", "HALFxHALF");
# todo iup.setCallback(dlg, "CLOSE_CB", (Icallback)item_exit_action_cb)#   IupSetCallback(dlg, "CLOSE_CB", (Icallback)item_exit_action_cb);
# todo iup.setCallback(dlg, "DROPFILES_CB", (Icallback)dropfiles_cb) #   IupSetCallback(dlg, "DROPFILES_CB", (Icallback)dropfiles_cb);
                                                                      # 
# todo iup.setCallback(dlg, "K_cN", (Icallback)item_new_action_cb)    #   IupSetCallback(dlg, "K_cN", (Icallback)item_new_action_cb);
# todo iup.setCallback(dlg, "K_cO", (Icallback)item_open_action_cb)   #   IupSetCallback(dlg, "K_cO", (Icallback)item_open_action_cb);
# todo iup.setCallback(dlg, "K_cS", (Icallback)item_save_action_cb)   #   IupSetCallback(dlg, "K_cS", (Icallback)item_save_action_cb);
# todo iup.setCallback(dlg, "K_cV", (Icallback)item_paste_action_cb)  #   IupSetCallback(dlg, "K_cV", (Icallback)item_paste_action_cb);
# todo iup.setCallback(dlg, "K_cC", (Icallback)item_copy_action_cb)   #   IupSetCallback(dlg, "K_cC", (Icallback)item_copy_action_cb);
                                                                      # 
                                                                      #   /* parent for pre-defined dialogs in closed functions (IupMessage and IupAlarm) */
  iup.setAttributeHandle(nil, "PARENTDIALOG", dlg)                    #   IupSetAttributeHandle(NULL, "PARENTDIALOG", dlg);
                                                                      # 
                                                                      #   /* Initialize variables from the configuration file */
                                                                      # 
# todo iup.configRecentInit(config, recent_menu, config_recent_cb, 10)     #   IupConfigRecentInit(config, recent_menu, config_recent_cb, 10);
                                                                      # 
  if iup.configGetVariableIntDef(config, "MainWindow", "Toolbar", 1) != 1:#   if (!IupConfigGetVariableIntDef(config, "MainWindow", "Toolbar", 1))
    iup.setAttribute(item_toolbar, "VALUE", "OFF")                    #   {
    iup.setAttribute(toolbar, "FLOATING", "YES")                      #     IupSetAttribute(item_toolbar, "VALUE", "OFF");
    iup.setAttribute(toolbar, "VISIBLE", "NO")                        # 
                                                                      #     IupSetAttribute(toolbar, "FLOATING", "YES");
                                                                      #     IupSetAttribute(toolbar, "VISIBLE", "NO");
                                                                      #   }
                                                                      # 
  if iup.configGetVariableIntDef(config, "MainWindow", "Statusbar", 1) != 1:#   if (!IupConfigGetVariableIntDef(config, "MainWindow", "Statusbar", 1))
    iup.setAttribute(item_statusbar, "VALUE", "OFF")                  #   {
    iup.setAttribute(statusbar, "FLOATING", "YES")                    #     IupSetAttribute(item_statusbar, "VALUE", "OFF");  
    iup.setAttribute(statusbar, "VISIBLE", "NO")                      #                                                                                                     
                                                                      #     IupSetAttribute(statusbar, "FLOATING", "YES");    
                                                                      #     IupSetAttribute(statusbar, "VISIBLE", "NO");        
  # echo @[config] !!! not work                                         #   }
  # echo $$config                                                       # 
  iup.setAttribute(dlg, "CONFIG", $$config) #!!!!!                    #   IupSetAttribute(dlg, "CONFIG", (char*)config);
                                                                      # 
  return dlg                                                          #   return dlg;
                                                                      # }
                                                               
#--  main  -------------------------------------------------------------------------------------------------------------------------------
when isMainModule:
                                                                      #Ihandle *dlg;
                                                                      #Ihandle *config;
                                                                      #
  discard iup.open(nil, nil)                                          #IupOpen(&argc, &argv);
  iup.glCanvasOpen()                                                  #IupGLCanvasOpen();
  iup.imageLibOpen()                                                  #IupImageLibOpen();
                                                                      #
  var config = iup.config()                                           #config = IupConfig();
  iup.setAttribute(config, "APP_NAME", "simple_paint")                #IupSetAttribute(config, "APP_NAME", "simple_paint");
  discard iup.configLoad(config)                                      #IupConfigLoad(config);
                                                                      #
  var dlg = create_main_dialog(config)                                #dlg = create_main_dialog(config);
                                                                      #
                                                                      #/* show the dialog at the last position, with the last size */
  iup.configDialogShow(config, dlg, "MainWindow")                     #IupConfigDialogShow(config, dlg, "MainWindow");
                                                                      #
                                                                      #/* open a file from the command line (allow file association in Windows) */
  if paramCount() > 0: open_file(dlg, paramStr(1))                    #if (argc > 1 && argv[1])
                                                                      #{
                                                                      #  const char* filename = argv[1];
                                                                      #  open_file(dlg, filename);
                                                                      #}
                                                                      #
                                                                      #/* initialize the current file, if not already loaded */
  check_new_file(dlg)                                                 #check_new_file(dlg);
                                                                      #                     
  discard iup.mainLoop()                                              #IupMainLoop();
                                                                      #                     
  iup.close()                                                         #IupClose();
                                                                      #return EXIT_SUCCESS;





  
  



# #proc hello() =
# #  echo "hello world"
#   
# when isMainModule:
#   discard iup.open(nil, nil)  
#   iup.imageLibOpen()
#   iup.glCanvasOpen()
# 
#   config = iup.config()
#   iup.setAttribute(config, "APP_NAME", "simple_paint")
#   iup.configLoad(config)
# 
#   var dlg = create_main_dialog(config)
# 
#   # show the dialog at the last position, with the last size
#   iup.configDialogShow(config, dlg, "MainWindow")
# 
#   # create and show the toolbox
#   create_toolbox(dlg, config)
# 
#   # open a file from the command line (allow file association in Windows)
# #todo # # #   if argc > 1 && argv[1]:
# #todo # # #     const char* filename = argv[1]
# #todo # # #     open_file(dlg, filename)
# 
#   # initialize the current file, if not already loaded
#   check_new_file(dlg)
# 
#   discard iup.mainLoop()
# 
#   iup.close()


