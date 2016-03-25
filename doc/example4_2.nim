when defined(WIN32):
## #********************************* Utilities ****************************************

proc str_filetitle*(filename: cstring): cstring =
  ## # Start at the last character 
  var len: cint = cast[cint](strlen(filename))
  var offset: cint = len - 1
  while offset != 0:
    if filename[offset] == '\x08' or filename[offset] == '/':
      inc(offset)
      break
    dec(offset)
  return filename + offset

proc str_fileext*(filename: cstring): cstring =
  ## # Start at the last character 
  var len: cint = cast[cint](strlen(filename))
  var offset: cint = len - 1
  while offset != 0:
    if filename[offset] == '\x08' or filename[offset] == '/': break
    if filename[offset] == '.':
      inc(offset)
      return filename + offset
    dec(offset)
  return nil

proc str_compare*(l: cstring; r: cstring; casesensitive: cint): cint =
  if not l or not r: return 0
  while l[] and r[]:
    var diff: cint
    var
      l_char: char = l[]
      r_char: char = r[]
    ## # compute the difference of both characters 
    if casesensitive: diff = l_char - r_char
    else: diff = tolower(cast[cint](l_char)) - tolower(cast[cint](r_char))
    ## # if they differ we have a result 
    if diff != 0:
      return 0
    inc(l)
    inc(r)
  ## # check also for terminator 
  if l[] == r[]: return 1
  if r[] == 0:
    return 1
  return 0

proc show_error*(message: cstring; is_error: cint) =
  var dlg: ptr Ihandle = IupMessageDlg()
  IupSetStrAttribute(dlg, "PARENTDIALOG", IupGetGlobal("PARENTDIALOG"))
  IupSetAttribute(dlg, "DIALOGTYPE", if is_error: "ERROR" else: "WARNING")
  IupSetAttribute(dlg, "BUTTONS", "OK")
  IupSetStrAttribute(dlg, "TITLE", if is_error: "Error" else: "Warning")
  IupSetStrAttribute(dlg, "VALUE", message)
  IupPopup(dlg, IUP_CENTERPARENT, IUP_CENTERPARENT)
  IupDestroy(dlg)

proc show_file_error*(error: cint) =
  case error
  of IM_ERR_OPEN:
    show_error("Error Opening File.", 1)
  of IM_ERR_MEM:
    show_error("Insufficient memory.", 1)
  of IM_ERR_ACCESS:
    show_error("Error Accessing File.", 1)
  of IM_ERR_DATA:
    show_error("Image type not Supported.", 1)
  of IM_ERR_FORMAT:
    show_error("Invalid Format.", 1)
  of IM_ERR_COMPRESS:
    show_error("Invalid or unsupported compression.", 1)
  else:
    show_error("Unknown Error.", 1)

proc read_file*(filename: cstring): ptr imImage =
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

proc write_file*(filename: cstring; image: ptr imImage): cint =
  var format: cstring = imImageGetAttribString(image, "FileFormat")
  var error: cint = imFileImageSave(filename, format, image)
  if error:
    show_file_error(error)
    return 0
  return 1

proc new_file*(ih: ptr Ihandle; image: ptr imImage) =
  var dlg: ptr Ihandle = IupGetDialog(ih)
  var canvas: ptr Ihandle = IupGetDialogChild(dlg, "CANVAS")
  var old_image: ptr imImage = cast[ptr imImage](IupGetAttribute(canvas, "IMAGE"))
  IupSetAttribute(dlg, "TITLE", "Untitled - Simple Paint")
  IupSetAttribute(canvas, "FILENAME", nil)
  IupSetAttribute(canvas, "DIRTY", "NO")
  IupSetAttribute(canvas, "IMAGE", cast[cstring](image))
  ## # create OpenGL compatible data 
  imImageGetOpenGLData(image, nil)
  IupUpdate(canvas)
  if old_image: imImageDestroy(old_image)
  
proc check_new_file*(dlg: ptr Ihandle) =
  var canvas: ptr Ihandle = IupGetDialogChild(dlg, "CANVAS")
  var image: ptr imImage = cast[ptr imImage](IupGetAttribute(canvas, "IMAGE"))
  if not image:
    var config: ptr Ihandle = cast[ptr Ihandle](IupGetAttribute(canvas, "CONFIG"))
    var width: cint = IupConfigGetVariableIntDef(config, "NewImage", "Width", 640)
    var height: cint = IupConfigGetVariableIntDef(config, "NewImage", "Height", 480)
    image = imImageCreate(width, height, IM_RGB, IM_BYTE)
    new_file(dlg, image)

proc open_file*(ih: ptr Ihandle; filename: cstring) =
  var image: ptr imImage = read_file(filename)
  if image:
    var dlg: ptr Ihandle = IupGetDialog(ih)
    var canvas: ptr Ihandle = IupGetDialogChild(dlg, "CANVAS")
    var config: ptr Ihandle = cast[ptr Ihandle](IupGetAttribute(canvas, "CONFIG"))
    var old_image: ptr imImage = cast[ptr imImage](IupGetAttribute(canvas, "IMAGE"))
    IupSetfAttribute(dlg, "TITLE", "%s - Simple Paint", str_filetitle(filename))
    IupSetStrAttribute(canvas, "FILENAME", filename)
    IupSetAttribute(canvas, "DIRTY", "NO")
    IupSetAttribute(canvas, "IMAGE", cast[cstring](image))
    IupUpdate(canvas)
    if old_image: imImageDestroy(old_image)
    IupConfigRecentUpdate(config, filename)

proc save_file*(canvas: ptr Ihandle) =
  var filename: cstring = IupGetAttribute(canvas, "FILENAME")
  var image: ptr imImage = cast[ptr imImage](IupGetAttribute(canvas, "IMAGE"))
  if write_file(filename, image): IupSetAttribute(canvas, "DIRTY", "NO")
  
proc set_file_format*(image: ptr imImage; filename: cstring) =
  var ext: cstring = str_fileext(filename)
  var format: cstring = "JPEG"
  if str_compare(ext, "jpg", 0) or str_compare(ext, "jpeg", 0): format = "JPEG"
  elif str_compare(ext, "bmp", 0): format = "BMP"
  elif str_compare(ext, "png", 0): format = "PNG"
  elif str_compare(ext, "tga", 0): format = "TGA"
  elif str_compare(ext, "tif", 0) or str_compare(ext, "tiff", 0): format = "TIFF"
  imImageSetAttribString(image, "FileFormat", format)

proc saveas_file*(canvas: ptr Ihandle; filename: cstring) =
  var image: ptr imImage = cast[ptr imImage](IupGetAttribute(canvas, "IMAGE"))
  set_file_format(image, filename)
  if write_file(filename, image):
    var config: ptr Ihandle = cast[ptr Ihandle](IupGetAttribute(canvas, "CONFIG"))
    IupSetfAttribute(IupGetDialog(canvas), "TITLE", "%s - Simple Paint",
                     str_filetitle(filename))
    IupSetStrAttribute(canvas, "FILENAME", filename)
    IupSetAttribute(canvas, "DIRTY", "NO")
    IupConfigRecentUpdate(config, filename)

proc save_check*(ih: ptr Ihandle): cint =
  var canvas: ptr Ihandle = IupGetDialogChild(ih, "CANVAS")
  if IupGetInt(canvas, "DIRTY"):
    case IupAlarm("Warning", "File not saved! Save it now?", "Yes", "No", "Cancel")
    of 1:                      ## # save the changes and continue 
      save_file(canvas)
    of 2:                      ## # ignore the changes and continue 
      nil
    of 3:                      ## # cancel 
      return 0
  return 1

proc toggle_bar_visibility*(item: ptr Ihandle; ih: ptr Ihandle) =
  if IupGetInt(item, "VALUE"):
    IupSetAttribute(ih, "FLOATING", "YES")
    IupSetAttribute(ih, "VISIBLE", "NO")
    IupSetAttribute(item, "VALUE", "OFF")
  else:
    IupSetAttribute(ih, "FLOATING", "NO")
    IupSetAttribute(ih, "VISIBLE", "YES")
    IupSetAttribute(item, "VALUE", "ON")
  IupRefresh(ih)
  ## # refresh the dialog layout 
  
## #********************************* Callbacks ****************************************

proc canvas_action_cb*(canvas: ptr Ihandle): cint =
  var
    x: cint
    y: cint
    canvas_width: cint
    canvas_height: cint
  var gldata: pointer
  var
    ri: cuint
    gi: cuint
    bi: cuint
  var image: ptr imImage
  var config: ptr Ihandle = cast[ptr Ihandle](IupGetAttribute(canvas, "CONFIG"))
  var background: cstring = IupConfigGetVariableStrDef(config, "Canvas", "Background",
      "255 255 255")
  IupGetIntInt(canvas, "DRAWSIZE", addr(canvas_width), addr(canvas_height))
  IupGLMakeCurrent(canvas)
  ## # OpenGL configuration 
  glPixelStorei(GL_UNPACK_ALIGNMENT, 1)
  ## # image data alignment is 1 
  glViewport(0, 0, canvas_width, canvas_height)
  glMatrixMode(GL_PROJECTION)
  glLoadIdentity()
  glOrtho(0, canvas_width, 0, canvas_height, - 1, 1)
  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity()
  ## # draw the background 
  sscanf(background, "%u %u %u", addr(ri), addr(gi), addr(bi))
  glClearColor(ri div 255.0, gi div 255.0, bi div 255.0, 1)
  glClear(GL_COLOR_BUFFER_BIT)
  ## # draw the image at the center of the canvas 
  image = cast[ptr imImage](IupGetAttribute(canvas, "IMAGE"))
  if image:
    x = (canvas_width - image.width) div 2
    y = (canvas_height - image.height) div 2
    gldata = cast[pointer](imImageGetAttribute(image, "GLDATA", nil, nil))
    glRasterPos2i(x, y)
    ## # this will not work for negative values, OpenGL limitation 
    glDrawPixels(image.width, image.height, GL_RGB, GL_UNSIGNED_BYTE, gldata)
    ## # no zoom support, must use texture 
  IupGLSwapBuffers(canvas)
  return IUP_DEFAULT

proc dropfiles_cb*(ih: ptr Ihandle; filename: cstring): cint =
  if save_check(ih): open_file(ih, filename)
  return IUP_DEFAULT

proc file_menu_open_cb*(ih: ptr Ihandle): cint =
  var item_revert: ptr Ihandle = IupGetDialogChild(ih, "ITEM_REVERT")
  var item_save: ptr Ihandle = IupGetDialogChild(ih, "ITEM_SAVE")
  var canvas: ptr Ihandle = IupGetDialogChild(ih, "CANVAS")
  var filename: cstring = IupGetAttribute(canvas, "FILENAME")
  var dirty: cint = IupGetInt(canvas, "DIRTY")
  if dirty: IupSetAttribute(item_save, "ACTIVE", "YES")
  else: IupSetAttribute(item_save, "ACTIVE", "NO")
  if dirty and filename: IupSetAttribute(item_revert, "ACTIVE", "YES")
  else: IupSetAttribute(item_revert, "ACTIVE", "NO")
  return IUP_DEFAULT

proc edit_menu_open_cb*(ih: ptr Ihandle): cint =
  var clipboard: ptr Ihandle = IupClipboard()
  var item_paste: ptr Ihandle = IupGetDialogChild(ih, "ITEM_PASTE")
  if not IupGetInt(clipboard, "IMAGEAVAILABLE"):
    IupSetAttribute(item_paste, "ACTIVE", "NO")
  else:
    IupSetAttribute(item_paste, "ACTIVE", "YES")
  IupDestroy(clipboard)
  return IUP_DEFAULT

proc config_recent_cb*(ih: ptr Ihandle): cint =
  if save_check(ih):
    var filename: cstring = IupGetAttribute(ih, "TITLE")
    open_file(ih, filename)
  return IUP_DEFAULT

proc item_new_action_cb*(item_new: ptr Ihandle): cint =
  if save_check(item_new):
    var canvas: ptr Ihandle = IupGetDialogChild(item_new, "CANVAS")
    var config: ptr Ihandle = cast[ptr Ihandle](IupGetAttribute(canvas, "CONFIG"))
    var width: cint = IupConfigGetVariableIntDef(config, "NewImage", "Width", 640)
    var height: cint = IupConfigGetVariableIntDef(config, "NewImage", "Height", 480)
    if IupGetParam("New Image", nil, nil, "Width: %i[1,]\x0AHeight: %i[1,]\x0A",
                  addr(width), addr(height), nil):
      var image: ptr imImage = imImageCreate(width, height, IM_RGB, IM_BYTE)
      IupConfigSetVariableInt(config, "NewImage", "Width", width)
      IupConfigSetVariableInt(config, "NewImage", "Height", height)
      new_file(item_new, image)
  return IUP_DEFAULT

proc select_file*(parent_dlg: ptr Ihandle; is_open: cint): cint =
  var config: ptr Ihandle = cast[ptr Ihandle](IupGetAttribute(parent_dlg, "CONFIG"))
  var canvas: ptr Ihandle = IupGetDialogChild(parent_dlg, "CANVAS")
  var dir: cstring = IupConfigGetVariableStr(config, "MainWindow", "LastDirectory")
  var filedlg: ptr Ihandle = IupFileDlg()
  if is_open:
    IupSetAttribute(filedlg, "DIALOGTYPE", "OPEN")
  else:
    IupSetAttribute(filedlg, "DIALOGTYPE", "SAVE")
    IupSetStrAttribute(filedlg, "FILE", IupGetAttribute(canvas, "FILENAME"))
  IupSetAttribute(filedlg, "EXTFILTER",
                  "Image Files|*.bmp;*.jpg;*.png;*.tif;*.tga|All Files|*.*|")
  IupSetStrAttribute(filedlg, "DIRECTORY", dir)
  IupSetAttributeHandle(filedlg, "PARENTDIALOG", parent_dlg)
  IupPopup(filedlg, IUP_CENTERPARENT, IUP_CENTERPARENT)
  if IupGetInt(filedlg, "STATUS") != - 1:
    var filename: cstring = IupGetAttribute(filedlg, "VALUE")
    if is_open: open_file(parent_dlg, filename)
    else: saveas_file(canvas, filename)
    dir = IupGetAttribute(filedlg, "DIRECTORY")
    IupConfigSetVariableStr(config, "MainWindow", "LastDirectory", dir)
  IupDestroy(filedlg)
  return IUP_DEFAULT

proc item_open_action_cb*(item_open: ptr Ihandle): cint =
  if not save_check(item_open): return IUP_DEFAULT
  return select_file(IupGetDialog(item_open), 1)

proc item_saveas_action_cb*(item_saveas: ptr Ihandle): cint =
  return select_file(IupGetDialog(item_saveas), 0)

proc item_save_action_cb*(item_save: ptr Ihandle): cint =
  var canvas: ptr Ihandle = IupGetDialogChild(item_save, "CANVAS")
  var filename: cstring = IupGetAttribute(canvas, "FILENAME")
  if not filename:
    item_saveas_action_cb(item_save)
  else:
    ## # test again because in can be called using the hot key 
    var dirty: cint = IupGetInt(canvas, "DIRTY")
    if dirty: save_file(canvas)
  return IUP_DEFAULT

proc item_revert_action_cb*(item_revert: ptr Ihandle): cint =
  var canvas: ptr Ihandle = IupGetDialogChild(item_revert, "CANVAS")
  var filename: cstring = IupGetAttribute(canvas, "FILENAME")
  open_file(item_revert, filename)
  return IUP_DEFAULT

proc item_exit_action_cb*(item_exit: ptr Ihandle): cint =
  var dlg: ptr Ihandle = IupGetDialog(item_exit)
  var config: ptr Ihandle = cast[ptr Ihandle](IupGetAttribute(dlg, "CONFIG"))
  var canvas: ptr Ihandle = IupGetDialogChild(dlg, "CANVAS")
  var image: ptr imImage = cast[ptr imImage](IupGetAttribute(canvas, "IMAGE"))
  if not save_check(item_exit):
    return IUP_IGNORE
  if image: imImageDestroy(image)
  IupConfigDialogClosed(config, dlg, "MainWindow")
  IupConfigSave(config)
  IupDestroy(config)
  return IUP_CLOSE

proc item_copy_action_cb*(item_copy: ptr Ihandle): cint =
  var canvas: ptr Ihandle = IupGetDialogChild(item_copy, "CANVAS")
  var image: ptr imImage = cast[ptr imImage](IupGetAttribute(canvas, "IMAGE"))
  var clipboard: ptr Ihandle = IupClipboard()
  IupSetAttribute(clipboard, "NATIVEIMAGE",
                  cast[cstring](IupGetImageNativeHandle(image)))
  IupDestroy(clipboard)
  return IUP_DEFAULT

proc item_paste_action_cb*(item_paste: ptr Ihandle): cint =
  if save_check(item_paste):
    var canvas: ptr Ihandle = IupGetDialogChild(item_paste, "CANVAS")
    var old_image: ptr imImage = cast[ptr imImage](IupGetAttribute(canvas, "IMAGE"))
    var clipboard: ptr Ihandle = IupClipboard()
    var image: ptr imImage = IupGetNativeHandleImage(
        IupGetAttribute(clipboard, "NATIVEIMAGE"))
    IupDestroy(clipboard)
    if not image:
      show_error("Invalid Clipboard Data", 1)
      return IUP_DEFAULT
    imImageRemoveAlpha(image)
    if image.color_space != IM_RGB:
      var new_image: ptr imImage = imImageCreateBased(image, - 1, - 1, IM_RGB, - 1)
      imConvertColorSpace(image, new_image)
      imImageDestroy(image)
      image = new_image
    imImageGetOpenGLData(image, nil)
    imImageSetAttribString(image, "FileFormat", "JPEG")
    IupSetAttribute(canvas, "DIRTY", "Yes")
    IupSetAttribute(canvas, "IMAGE", cast[cstring](image))
    IupSetAttribute(canvas, "FILENAME", nil)
    IupSetAttribute(IupGetDialog(canvas), "TITLE", "Untitled - Simple Paint")
    IupUpdate(canvas)
    if old_image: imImageDestroy(old_image)
  return IUP_DEFAULT

proc item_background_action_cb*(item_background: ptr Ihandle): cint =
  var canvas: ptr Ihandle = IupGetDialogChild(item_background, "CANVAS")
  var config: ptr Ihandle = cast[ptr Ihandle](IupGetAttribute(canvas, "CONFIG"))
  var colordlg: ptr Ihandle = IupColorDlg()
  var background: cstring = IupConfigGetVariableStrDef(config, "Canvas", "Background",
      "255 255 255")
  IupSetStrAttribute(colordlg, "VALUE", background)
  IupSetAttributeHandle(colordlg, "PARENTDIALOG", IupGetDialog(item_background))
  IupPopup(colordlg, IUP_CENTERPARENT, IUP_CENTERPARENT)
  if IupGetInt(colordlg, "STATUS") == 1:
    background = IupGetAttribute(colordlg, "VALUE")
    IupConfigSetVariableStr(config, "Canvas", "Background", background)
    IupUpdate(canvas)
  IupDestroy(colordlg)
  return IUP_DEFAULT

proc item_toolbar_action_cb*(item_toolbar: ptr Ihandle): cint =
  var canvas: ptr Ihandle = IupGetDialogChild(item_toolbar, "CANVAS")
  var toolbar: ptr Ihandle = IupGetChild(IupGetParent(canvas), 0)
  var config: ptr Ihandle = cast[ptr Ihandle](IupGetAttribute(canvas, "CONFIG"))
  toggle_bar_visibility(item_toolbar, toolbar)
  IupConfigSetVariableStr(config, "MainWindow", "Toolbar",
                          IupGetAttribute(item_toolbar, "VALUE"))
  return IUP_DEFAULT

proc item_statusbar_action_cb*(item_statusbar: ptr Ihandle): cint =
  var canvas: ptr Ihandle = IupGetDialogChild(item_statusbar, "CANVAS")
  var statusbar: ptr Ihandle = IupGetBrother(canvas)
  var config: ptr Ihandle = cast[ptr Ihandle](IupGetAttribute(canvas, "CONFIG"))
  toggle_bar_visibility(item_statusbar, statusbar)
  IupConfigSetVariableStr(config, "MainWindow", "Statusbar",
                          IupGetAttribute(item_statusbar, "VALUE"))
  return IUP_DEFAULT

proc item_help_action_cb*(): cint =
  IupHelp("http://www.tecgraf.puc-rio.br/iup")
  return IUP_DEFAULT

proc item_about_action_cb*(): cint =
  IupMessage("About", "   Simple Paint\x0A\x0AAutors:\x0A   Gustavo Lyrio\x0A   Antonio Scuri")
  return IUP_DEFAULT

## #********************************* Main ****************************************

proc create_main_dialog*(config: ptr Ihandle): ptr Ihandle =
  var
    dlg: ptr Ihandle
    vbox: ptr Ihandle
    canvas: ptr Ihandle
    menu: ptr Ihandle
  var
    sub_menu_file: ptr Ihandle
    file_menu: ptr Ihandle
    item_exit: ptr Ihandle
    item_new: ptr Ihandle
    item_open: ptr Ihandle
    item_save: ptr Ihandle
    item_saveas: ptr Ihandle
    item_revert: ptr Ihandle
  var
    sub_menu_edit: ptr Ihandle
    edit_menu: ptr Ihandle
    item_copy: ptr Ihandle
    item_paste: ptr Ihandle
  var
    btn_copy: ptr Ihandle
    btn_paste: ptr Ihandle
    btn_new: ptr Ihandle
    btn_open: ptr Ihandle
    btn_save: ptr Ihandle
  var
    sub_menu_help: ptr Ihandle
    help_menu: ptr Ihandle
    item_help: ptr Ihandle
    item_about: ptr Ihandle
  var
    sub_menu_view: ptr Ihandle
    view_menu: ptr Ihandle
    item_toolbar: ptr Ihandle
    item_statusbar: ptr Ihandle
  var
    statusbar: ptr Ihandle
    toolbar: ptr Ihandle
    recent_menu: ptr Ihandle
    item_background: ptr Ihandle
  canvas = IupGLCanvas(nil)
  IupSetAttribute(canvas, "NAME", "CANVAS")
  IupSetAttribute(canvas, "DIRTY", "NO")
  IupSetAttribute(canvas, "BUFFER", "DOUBLE")
  IupSetCallback(canvas, "ACTION", cast[Icallback](canvas_action_cb))
  IupSetCallback(canvas, "DROPFILES_CB", cast[Icallback](dropfiles_cb))
  statusbar = IupLabel("(0, 0) = [0   0   0]")
  IupSetAttribute(statusbar, "NAME", "STATUSBAR")
  IupSetAttribute(statusbar, "EXPAND", "HORIZONTAL")
  IupSetAttribute(statusbar, "PADDING", "10x5")
  item_new = IupItem("&New\x09Ctrl+N", nil)
  IupSetAttribute(item_new, "IMAGE", "IUP_FileNew")
  IupSetCallback(item_new, "ACTION", cast[Icallback](item_new_action_cb))
  btn_new = IupButton(nil, nil)
  IupSetAttribute(btn_new, "IMAGE", "IUP_FileNew")
  IupSetAttribute(btn_new, "FLAT", "Yes")
  IupSetCallback(btn_new, "ACTION", cast[Icallback](item_new_action_cb))
  IupSetAttribute(btn_new, "TIP", "New (Ctrl+N)")
  IupSetAttribute(btn_new, "CANFOCUS", "No")
  item_open = IupItem("&Open...\x09Ctrl+O", nil)
  IupSetAttribute(item_open, "IMAGE", "IUP_FileOpen")
  IupSetCallback(item_open, "ACTION", cast[Icallback](item_open_action_cb))
  btn_open = IupButton(nil, nil)
  IupSetAttribute(btn_open, "IMAGE", "IUP_FileOpen")
  IupSetAttribute(btn_open, "FLAT", "Yes")
  IupSetCallback(btn_open, "ACTION", cast[Icallback](item_open_action_cb))
  IupSetAttribute(btn_open, "TIP", "Open (Ctrl+O)")
  IupSetAttribute(btn_open, "CANFOCUS", "No")
  item_save = IupItem("&Save\x09Ctrl+S", nil)
  IupSetAttribute(item_save, "NAME", "ITEM_SAVE")
  IupSetAttribute(item_save, "IMAGE", "IUP_FileSave")
  IupSetCallback(item_save, "ACTION", cast[Icallback](item_save_action_cb))
  btn_save = IupButton(nil, nil)
  IupSetAttribute(btn_save, "IMAGE", "IUP_FileSave")
  IupSetAttribute(btn_save, "FLAT", "Yes")
  IupSetCallback(btn_save, "ACTION", cast[Icallback](item_save_action_cb))
  IupSetAttribute(btn_save, "TIP", "Save (Ctrl+S)")
  IupSetAttribute(btn_save, "CANFOCUS", "No")
  item_saveas = IupItem("Save &As...", nil)
  IupSetAttribute(item_saveas, "NAME", "ITEM_SAVEAS")
  IupSetCallback(item_saveas, "ACTION", cast[Icallback](item_saveas_action_cb))
  item_revert = IupItem("&Revert", nil)
  IupSetAttribute(item_revert, "NAME", "ITEM_REVERT")
  IupSetCallback(item_revert, "ACTION", cast[Icallback](item_revert_action_cb))
  item_exit = IupItem("E&xit", nil)
  IupSetCallback(item_exit, "ACTION", cast[Icallback](item_exit_action_cb))
  item_copy = IupItem("&Copy\x09Ctrl+C", nil)
  IupSetAttribute(item_copy, "NAME", "ITEM_COPY")
  IupSetAttribute(item_copy, "IMAGE", "IUP_EditCopy")
  IupSetCallback(item_copy, "ACTION", cast[Icallback](item_copy_action_cb))
  btn_copy = IupButton(nil, nil)
  IupSetAttribute(btn_copy, "IMAGE", "IUP_EditCopy")
  IupSetAttribute(btn_copy, "FLAT", "Yes")
  IupSetCallback(btn_copy, "ACTION", cast[Icallback](item_copy_action_cb))
  IupSetAttribute(btn_copy, "TIP", "Copy (Ctrl+C)")
  IupSetAttribute(btn_copy, "CANFOCUS", "No")
  item_paste = IupItem("&Paste\x09Ctrl+V", nil)
  IupSetAttribute(item_paste, "NAME", "ITEM_PASTE")
  IupSetAttribute(item_paste, "IMAGE", "IUP_EditPaste")
  IupSetCallback(item_paste, "ACTION", cast[Icallback](item_paste_action_cb))
  btn_paste = IupButton(nil, nil)
  IupSetAttribute(btn_paste, "IMAGE", "IUP_EditPaste")
  IupSetAttribute(btn_paste, "FLAT", "Yes")
  IupSetCallback(btn_paste, "ACTION", cast[Icallback](item_paste_action_cb))
  IupSetAttribute(btn_paste, "TIP", "Paste (Ctrl+V)")
  IupSetAttribute(btn_paste, "CANFOCUS", "No")
  item_background = IupItem("&Background...", nil)
  IupSetCallback(item_background, "ACTION",
                 cast[Icallback](item_background_action_cb))
  item_toolbar = IupItem("&Toobar", nil)
  IupSetCallback(item_toolbar, "ACTION", cast[Icallback](item_toolbar_action_cb))
  IupSetAttribute(item_toolbar, "VALUE", "ON")
  item_statusbar = IupItem("&Statusbar", nil)
  IupSetCallback(item_statusbar, "ACTION",
                 cast[Icallback](item_statusbar_action_cb))
  IupSetAttribute(item_statusbar, "VALUE", "ON")
  item_help = IupItem("&Help...", nil)
  IupSetCallback(item_help, "ACTION", cast[Icallback](item_help_action_cb))
  item_about = IupItem("&About...", nil)
  IupSetCallback(item_about, "ACTION", cast[Icallback](item_about_action_cb))
  recent_menu = IupMenu(nil)
  file_menu = IupMenu(item_new, item_open, item_save, item_saveas, item_revert,
                    IupSeparator(), IupSubmenu("Recent &Files", recent_menu),
                    item_exit, nil)
  edit_menu = IupMenu(item_copy, item_paste, nil)
  view_menu = IupMenu(item_background, IupSeparator(), item_toolbar, item_statusbar,
                    nil)
  help_menu = IupMenu(item_help, item_about, nil)
  IupSetCallback(file_menu, "OPEN_CB", cast[Icallback](file_menu_open_cb))
  IupSetCallback(edit_menu, "OPEN_CB", cast[Icallback](edit_menu_open_cb))
  sub_menu_file = IupSubmenu("&File", file_menu)
  sub_menu_edit = IupSubmenu("&Edit", edit_menu)
  sub_menu_view = IupSubmenu("&View", view_menu)
  sub_menu_help = IupSubmenu("&Help", help_menu)
  menu = IupMenu(sub_menu_file, sub_menu_edit, sub_menu_view, sub_menu_help, nil)
  toolbar = IupHbox(btn_new, btn_open, btn_save,
                  IupSetAttributes(IupLabel(nil), "SEPARATOR=VERTICAL"), btn_copy,
                  btn_paste, nil)
  IupSetAttribute(toolbar, "MARGIN", "5x5")
  IupSetAttribute(toolbar, "GAP", "2")
  vbox = IupVbox(toolbar, canvas, statusbar, nil)
  dlg = IupDialog(vbox)
  IupSetAttributeHandle(dlg, "MENU", menu)
  IupSetAttribute(dlg, "SIZE", "HALFxHALF")
  IupSetCallback(dlg, "CLOSE_CB", cast[Icallback](item_exit_action_cb))
  IupSetCallback(dlg, "DROPFILES_CB", cast[Icallback](dropfiles_cb))
  IupSetCallback(dlg, "K_cN", cast[Icallback](item_new_action_cb))
  IupSetCallback(dlg, "K_cO", cast[Icallback](item_open_action_cb))
  IupSetCallback(dlg, "K_cS", cast[Icallback](item_save_action_cb))
  IupSetCallback(dlg, "K_cV", cast[Icallback](item_paste_action_cb))
  IupSetCallback(dlg, "K_cC", cast[Icallback](item_copy_action_cb))
  ## # parent for pre-defined dialogs in closed functions (IupMessage and IupAlarm) 
  IupSetAttributeHandle(nil, "PARENTDIALOG", dlg)
  ## # Initialize variables from the configuration file 
  IupConfigRecentInit(config, recent_menu, config_recent_cb, 10)
  if not IupConfigGetVariableIntDef(config, "MainWindow", "Toolbar", 1):
    IupSetAttribute(item_toolbar, "VALUE", "OFF")
    IupSetAttribute(toolbar, "FLOATING", "YES")
    IupSetAttribute(toolbar, "VISIBLE", "NO")
  if not IupConfigGetVariableIntDef(config, "MainWindow", "Statusbar", 1):
    IupSetAttribute(item_statusbar, "VALUE", "OFF")
    IupSetAttribute(statusbar, "FLOATING", "YES")
    IupSetAttribute(statusbar, "VISIBLE", "NO")
  IupSetAttribute(dlg, "CONFIG", cast[cstring](config))
  return dlg

proc main*(argc: cint; argv: cstringArray): cint =
  var dlg: ptr Ihandle
  var config: ptr Ihandle
  IupOpen(addr(argc), addr(argv))
  IupGLCanvasOpen()
  IupImageLibOpen()
  config = IupConfig()
  IupSetAttribute(config, "APP_NAME", "simple_paint")
  IupConfigLoad(config)
  dlg = create_main_dialog(config)
  ## # show the dialog at the last position, with the last size 
  IupConfigDialogShow(config, dlg, "MainWindow")
  ## # open a file from the command line (allow file association in Windows) 
  if argc > 1 and argv[1]:
    var filename: cstring = argv[1]
    open_file(dlg, filename)
  check_new_file(dlg)
  IupMainLoop()
  IupClose()
  return EXIT_SUCCESS
