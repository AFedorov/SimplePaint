import iup, os, marshal

proc read_file(filename: cstring): ptr imImage =
  var error: cint
  var image: ptr imImage = imFileImageLoadBitmap(filename, 0, addr(error))
  if error:
    show_file_error(error)
  else:
    ## # we are going to support only RGB images with no alpha
    imImageRemoveAlpha(image)
    if image.color_space != IM_RGB:
      var new_image: ptr imImage = imImageCreateBased(image, - 1, - 1, IM_RGB, - 1)
      imConvertColorSpace(image, new_image)
      imImageDestroy(image)
      image = new_image
    imImageGetOpenGLData(image, nil)
  return image

proc openFile(ih: PIhandle; filename: cstring) =
  var image: ptr imImage = readFile(filename)
  if image:
    var dlg: PIhandle = iup.getDialog(ih)
    var canvas: PIhandle = iup.getDialogChild(dlg, "CANVAS")
    var config: PIhandle = cast[PIhandle](iup.getAttribute(canvas, "CONFIG"))
    var old_image: ptr imImage = cast[ptr imImage](iup.getAttribute(canvas, "IMAGE"))
    # iup.setfAttribute(dlg, "TITLE", "%s - Simple Paint", str_filetitle(filename))
    iup.setStrAttribute(canvas, "FILENAME", filename)
    iup.setAttribute(canvas, "DIRTY", "NO")
    iup.setAttribute(canvas, "IMAGE", cast[cstring](image))
    iup.update(canvas)
    if old_image: imImageDestroy(old_image)
    iup.configRecentUpdate(config, filename)

proc selectFile(parent_dlg: PIhandle; is_open: cint): cint =
  var config: PIhandle = cast[PIhandle](iup.getAttribute(parent_dlg, "CONFIG"))
  var canvas: PIhandle = iup.getDialogChild(parent_dlg, "CANVAS")
  var dir: cstring = iup.configGetVariableStr(config, "MainWindow", "LastDirectory")
  var filedlg: PIhandle = iup.fileDlg()
  if is_open == 1:
    iup.setAttribute(filedlg, "DIALOGTYPE", "OPEN")
    echo iup.getAttribute(filedlg, "DIALOGTYPE")
  else:
    iup.setAttribute(filedlg, "DIALOGTYPE", "SAVE")
    iup.setStrAttribute(filedlg, "FILE", iup.getAttribute(canvas, "FILENAME"))
    echo $$filedlg
  iup.setAttribute(filedlg, "EXTFILTER",
                  "Image Files|*.bmp;*.jpg;*.png;*.tif;*.tga|All Files|*.*|")
  iup.setStrAttribute(filedlg, "DIRECTORY", dir)
  iup.setAttributeHandle(filedlg, "PARENTDIALOG", parent_dlg)
  iup.popup(filedlg, IUP_CENTERPARENT, IUP_CENTERPARENT)
  if iup.getInt(filedlg, "STATUS") != - 1:
    var filename: cstring = iup.getAttribute(filedlg, "VALUE")
    if is_open == 1: openFile(parent_dlg, filename)
    #  else: saveas_file(canvas, filename)
    dir = iup.getAttribute(filedlg, "DIRECTORY")
    iup.configSetVariableStr(config, "MainWindow", "LastDirectory", dir)
  iup.destroy(filedlg)
  return IUP_DEFAULT

proc save_file*(canvas: PIhandle) =
  var filename: cstring = iup.getAttribute(canvas, "FILENAME")
#  var image: ptr imImage = cast[ptr imImage](IupGetAttribute(canvas, "IMAGE"))
#  if write_file(filename, image): IupSetAttribute(canvas, "DIRTY", "NO")
#-------------------------------------------------------------------------------------

proc save_check(ih: PIhandle): bool =
  var canvas: PIhandle = iup.getDialogChild(ih, "CANVAS")
#   STUB iup.setAttribute(canvas, "DIRTY", "YES");
#   echo iup.getInt(canvas, "DIRTY")
  result = true
  if (iup.getInt(canvas, "DIRTY") == 1):
    case iup.alarm("Warning", "File not saved! Save it now?", "Yes", "No", "Cancel")
    of 1:                      ## # save the changes and continue
      save_file(canvas)
    #of 2:                      ## # ignore the changes and continue
    #  discard
    of 3:                      ## # cancel
      result = false
    else:
      discard

proc item_open_action_cb(item_open: PIhandle): cint {.cdecl.} =
  if not save_check(item_open): return IUP_DEFAULT
  return select_file(iup.getDialog(item_open), 1)

proc check_new_file*(dlg: PIhandle) =
  echo "check_new_file"

proc config_recent_cb*(ih: PIhandle): cint =
  if save_check(ih):
    var filename: cstring = iup.getAttribute(ih, "TITLE")
# todo    open_file(ih, filename)
  return IUP_DEFAULT

proc create_main_dialog*(config: PIhandle): PIhandle =
#proc create_main_dialog(config: PIhandle): PIhandle =
  var canvas = iup.glCanvas(nil)
  iup.setAttribute(canvas, "NAME", "CANVAS")
  iup.setAttribute(canvas, "DIRTY", "NO")
  iup.setAttribute(canvas, "BUFFER", "DOUBLE")
# todo iup.setCallback(canvas, "ACTION", (Icallback)canvas_action_cb)
# todo iup.setCallback(canvas, "DROPFILES_CB", (Icallback)dropfiles_cb)

  var statusbar = iup.label("(0, 0) = [0   0   0]")
  iup.setAttribute(statusbar, "NAME", "STATUSBAR")
  iup.setAttribute(statusbar, "EXPAND", "HORIZONTAL")
  iup.setAttribute(statusbar, "PADDING", "10x5")
  
  var item_new = iup.item("&New\tCtrl+N", nil)
  iup.setAttribute(item_new, "IMAGE", "IUP_FileNew")
# todo iup.setCallback(item_new, "ACTION", (Icallback)item_new_action_cb)
  var btn_new = iup.button(nil, nil)
  iup.setAttribute(btn_new, "IMAGE", "IUP_FileNew")
  iup.setAttribute(btn_new, "FLAT", "Yes")
# todo iup.setCallback(btn_new, "ACTION", (Icallback)item_new_action_cb)
  iup.setAttribute(btn_new, "TIP", "New (Ctrl+N)")
  iup.setAttribute(btn_new, "CANFOCUS", "No")
  
  var item_open = iup.item("&Open...\tCtrl+O", nil)
  iup.setAttribute(item_open, "IMAGE", "IUP_FileOpen")
  discard iup.setCallback(item_open, "ACTION", (Icallback)item_open_action_cb)
  var btn_open = iup.button(nil, nil)
  iup.setAttribute(btn_open, "IMAGE", "IUP_FileOpen")
  iup.setAttribute(btn_open, "FLAT", "Yes")
  iup.setCallback(btn_open, "ACTION", (Icallback)item_open_action_cb)
  iup.setAttribute(btn_open, "TIP", "Open (Ctrl+O)")
  iup.setAttribute(btn_open, "CANFOCUS", "No")

  var item_save = iup.item("&Save\tCtrl+S", nil)
  iup.setAttribute(item_save, "NAME", "ITEM_SAVE")
  iup.setAttribute(item_save, "IMAGE", "IUP_FileSave")
# todo iup.setCallback(item_save, "ACTION", (Icallback)item_save_action_cb)
  var btn_save = iup.button(nil, nil)
  iup.setAttribute(btn_save, "IMAGE", "IUP_FileSave")
  iup.setAttribute(btn_save, "FLAT", "Yes")
# todo iup.setCallback(btn_save, "ACTION", (Icallback)item_save_action_cb)
  iup.setAttribute(btn_save, "TIP", "Save (Ctrl+S)")
  iup.setAttribute(btn_save, "CANFOCUS", "No")

  var item_saveas = iup.item("Save &As...", nil)
  iup.setAttribute(item_saveas, "NAME", "ITEM_SAVEAS")
# todo iup.setCallback(item_saveas, "ACTION", (Icallback)item_saveas_action_cb)

  var item_revert = iup.item("&Revert", nil)
  iup.setAttribute(item_revert, "NAME", "ITEM_REVERT")
# todo iup.setCallback(item_revert, "ACTION", (Icallback)item_revert_action_cb)

  var item_exit = iup.item("E&xit", nil)
# todo  iup.setCallback(item_exit, "ACTION", (Icallback)item_exit_action_cb)

  var item_copy = iup.item("&Copy\tCtrl+C", nil)
  iup.setAttribute(item_copy, "NAME", "ITEM_COPY")
  iup.setAttribute(item_copy, "IMAGE", "IUP_EditCopy")                                
# todo iup.setCallback(item_copy, "ACTION", (Icallback)item_copy_action_cb)           
  var btn_copy = iup.button(nil, nil)                                                 
  iup.setAttribute(btn_copy, "IMAGE", "IUP_EditCopy")                                 
  iup.setAttribute(btn_copy, "FLAT", "Yes")                                           
# todo iup.setCallback(btn_copy, "ACTION", (Icallback)item_copy_action_cb)            
  iup.setAttribute(btn_copy, "TIP", "Copy (Ctrl+C)")                                  
  iup.setAttribute(btn_copy, "CANFOCUS", "No")                                        
                                                                                      
  var item_paste = iup.item("&Paste\tCtrl+V", nil)                                    
  iup.setAttribute(item_paste, "NAME", "ITEM_PASTE")                                  
  iup.setAttribute(item_paste, "IMAGE", "IUP_EditPaste")                              
# todo iup.setCallback(item_paste, "ACTION", (Icallback)item_paste_action_cb)         
  var btn_paste = iup.button(nil, nil)                                                
  iup.setAttribute(btn_paste, "IMAGE", "IUP_EditPaste")                               
  iup.setAttribute(btn_paste, "FLAT", "Yes")                                          
# todo iup.setCallback(btn_paste, "ACTION", (Icallback)item_paste_action_cb)          
  iup.setAttribute(btn_paste, "TIP", "Paste (Ctrl+V)")                                
  iup.setAttribute(btn_paste, "CANFOCUS", "No")                                       
                                                                                      
  var item_background = iup.item("&Background...", nil)                               
# todo iup.setCallback(item_background, "ACTION", (Icallback)item_background_action_cb);
                                                                                      
  var item_toolbar = iup.item("&Toobar", nil)                                         
# todo iup.setCallback(item_toolbar, "ACTION", (Icallback)item_toolbar_action_cb)     
  iup.setAttribute(item_toolbar, "VALUE", "ON")                                       
                                                                                      
  var item_statusbar = iup.item("&Statusbar", nil)                                    
# todo iup.setCallback(item_statusbar, "ACTION", (Icallback)item_statusbar_action_cb) 
  iup.setAttribute(item_statusbar, "VALUE", "ON")                                     
                                                                                      
  var item_help = iup.item("&Help...", nil)                                           
# todo iup.setCallback(item_help, "ACTION", (Icallback)item_help_action_cb)           
                                                                                      
  var item_about = iup.item("&About...", nil)                                         
# todo iup.SetCallback(item_about, "ACTION", (Icallback)item_about_action_cb)         
                                                                                      
  var recent_menu = iup.menu(nil);                                                    
                                                                                      
  var file_menu = iup.menu(                                                           
    item_new,                                                                         
    item_open,                                                                        
    item_save,                                                                        
    item_saveas,                                                                      
    item_revert,                                                                      
    iup.separator(),                                                                  
    iup.submenu("Recent &Files", recent_menu),                                        
    item_exit,                                                                        
    nil)                                                                              
  var edit_menu = iup.menu(                                                           
    item_copy,                                                                        
    item_paste,                                                                       
    nil)                                                                              
  var view_menu = iup.menu(                                                           
    item_background,                                                                  
    iup.separator(),                                                                  
    item_toolbar,                                                                     
    item_statusbar,                                                                   
    nil)                                                                              
  var help_menu = iup.menu(                                                           
    item_help,                                                                        
    item_about,                                                                       
    nil)                                                                              
                                                                                      
# todo iup.setCallback(file_menu, "OPEN_CB", (Icallback)file_menu_open_cb)            
# todo iup.setCallback(edit_menu, "OPEN_CB", (Icallback)edit_menu_open_cb)            
                                                                      
  var sub_menu_file = iup.submenu("&File", file_menu)                 
  var sub_menu_edit = iup.submenu("&Edit", edit_menu)                 
  var sub_menu_view = iup.submenu("&View", view_menu)                 
  var sub_menu_help = iup.submenu("&Help", help_menu)                 
                                                                      
  var menu = iup.menu(                                                
    sub_menu_file,                                                    
    sub_menu_edit,                                                    
    sub_menu_view,                                                    
    sub_menu_help,                                                    
    nil)                                                              
                                                                      
  var toolbar = iup.hbox(                                             
    btn_new,                                                          
    btn_open,                                                         
    btn_save,                                                         
    iup.setAttributes(iup.label(nil), "SEPARATOR=VERTICAL"),          
    btn_copy,                                                         
    btn_paste,                                                        
    nil)                                                              
  iup.setAttribute(toolbar, "MARGIN", "5x5")                          
  iup.setAttribute(toolbar, "GAP", "2")                               
                                                                      
  var vbox = iup.vbox(                                                
    toolbar,                                                          
    canvas,                                                           
    statusbar,                                                        
    nil)                                                              
                                                                      
  var dlg = iup.dialog(vbox)                                          
  iup.setAttributeHandle(dlg, "MENU", menu)                           
  iup.setAttribute(dlg, "SIZE", "HALFxHALF")                          
# todo iup.setCallback(dlg, "CLOSE_CB", (Icallback)item_exit_action_cb)
# todo iup.setCallback(dlg, "DROPFILES_CB", (Icallback)dropfiles_cb)  
                                                                      
# todo iup.setCallback(dlg, "K_cN", (Icallback)item_new_action_cb)    
# todo iup.setCallback(dlg, "K_cO", (Icallback)item_open_action_cb)   
# todo iup.setCallback(dlg, "K_cS", (Icallback)item_save_action_cb)   
# todo iup.setCallback(dlg, "K_cV", (Icallback)item_paste_action_cb)  
# todo iup.setCallback(dlg, "K_cC", (Icallback)item_copy_action_cb)   
                                                                      
                                                                      
  iup.setAttributeHandle(nil, "PARENTDIALOG", dlg)                    
                                                                      
                                                                      
                                                                      
# todo iup.configRecentInit(config, recent_menu, config_recent_cb, 10)
                                                                      
  if iup.configGetVariableIntDef(config, "MainWindow", "Toolbar", 1) != 1:
    iup.setAttribute(item_toolbar, "VALUE", "OFF")                    
    iup.setAttribute(toolbar, "FLOATING", "YES")                      
    iup.setAttribute(toolbar, "VISIBLE", "NO")                        
                                                                      
                                                                      
                                                                      
                                                                      
  if iup.configGetVariableIntDef(config, "MainWindow", "Statusbar", 1) != 1:
    iup.setAttribute(item_statusbar, "VALUE", "OFF")                  
    iup.setAttribute(statusbar, "FLOATING", "YES")                    
    iup.setAttribute(statusbar, "VISIBLE", "NO")                      
                                                                      
                                                                      
  # echo @[config] !!! not work                                       
  # echo $$config                                                     
  iup.setAttribute(dlg, "CONFIG", $$config) #!!!!!                    
                                                                      
  return dlg                                                          
                                                                      
                                                               
#--  main  -----------------------------------------------------------
when isMainModule:
                                                                      
                                                                      
                                                                      
  discard iup.open(nil, nil)                                          
  iup.glCanvasOpen()                                                  
  iup.imageLibOpen()                                                  
                                                                      
  var config = iup.config()                                           
  iup.setAttribute(config, "APP_NAME", "simple_paint")                
  discard iup.configLoad(config)                                      
                                                                      
  var dlg = create_main_dialog(config)                                
                                                                      
                                                                      
  iup.configDialogShow(config, dlg, "MainWindow")                     
                                                                      
                                                                      
  if paramCount() > 0: open_file(dlg, paramStr(1))                    
                                                                      
                                                                      
                                                                      
                                                                      
                                                                      
                                                                      
  check_new_file(dlg)                                                 
                                                                      
  discard iup.mainLoop()                                              
                                                                      
  iup.close()                                                         
                                                                      





  
  



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


