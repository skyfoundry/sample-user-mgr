//
// Copyright (c) 2019, SkyFoundry LLC
// Licensed under the MIT License
//
// History:
//   23 Dec 2019  Andy Frank  Creation
//

using dom
using domkit

**
** Content dialogs display content with a standard button bar across
** the bottom of the dialog.
**
@Js class ContentDialog : Dialog
{
  ** Constructor.
  new make() : super()
  {
    this.onKeyDown |e|
    {
      switch (e.key)
      {
        case Key.esc:
          k := buttons.keys.find |k| { k == "cancel" }
          if (k != null) fireAction(k)

        case Key.enter:
          if (e.target is TextArea) return
          if (defButton != null && button(defButton).enabled)
            fireAction(defButton)
      }
    }
  }

  ** Width of content in CSS length, or null for default.
  Str? width := null

  ** Height of content in CSS length, or null for default.
  Str? height := null

  ** Content of dialog
  Elem? content

  ** Auxiliary content is displayed below content to the left
  ** of the action buttons.
  Elem? aux

  ** Add an action button to dialog. If 'dis' is null, then lookup
  ** display name using 'key' as the locale key.
  This addButton(Str key, Str? dis := null, Bool def := false)
  {
    buttons.add(key, Button { it.text=dis ?: lookupDis(key) })
    if (def) defButton = key
    return this
  }

  ** Add a button gap to dialog.
  This addButtonGap()
  {
    buttons.add("gap_${buttons.size}", null)
    return this
  }

  ** Get button instance for key.
  Button button(Str key)
  {
    buttons[key] ?: throw ArgErr("Key not found '$key'")
  }

  ** Callback when dialog is closed, where 'key' is the button
  ** used to dismiss the dialog.  Return 'true' to close dialog
  ** or 'false' prevent close and keep dialog open.
  Void onAction(|Str key->Bool| f) { this.cbAction = f }

  protected override Void onBeforeOpen()
  {
    // limit content height
    if (content == null) throw Err("Must set ContentDialog.content")
    content.style->maxHeight = "${Win.cur.viewport.h - 100}px"
    content.style->overflow  = "auto"

    gaps := Str[,]
    butw := 0
    if (buttons.size > 1)
      buttons.keys.eachRange(1..-1) |key|
      {
        isGap := key.startsWith("gap_")
        butw += isGap ? 20 : 4
        gaps.add(isGap ? "20px" : "4px")
      }

    buts := Button[,]
    buttons.each |elem,key|
    {
      if (elem == null) return
      elem.parent?.removeChild(elem)
      butw += 60
      elem.style.toggleClass("def-action", defButton == key)
      elem.style["min-width"] = "60px"
      elem.onAction { fireAction(key) }
      buts.add(elem)
    }

    butBox := FlexBox
    {
      it.flex = ["auto", "none"]
      it.style.addClass("ui-ContentDialog-buttons")
      it.style->padding = "10px"
      aux ?: Elem {},
      FlowBox
      {
        it.halign = Align.right
        it.gaps = gaps
        it.addAll(buts)
      },
    }

    this.removeAll.add(SashBox
    {
      it.dir = Dir.down
      it.style->width = width ?: "500px"
      it.sizes = [height ?: "auto", "auto"]
      content,
      butBox,
    })
  }

  @NoDoc Void fireAction(Str key)
  {
    if (cbAction?.call(key) ?: true == true) close
  }

  ** Lookup up dis using locale key.
  internal static Str lookupDis(Str key)
  {
    // simple name
    if (!key.contains("::")) return ContentDialog#.pod.locale(key) ?: key

    // check for qname
    ix   := key.index("::")
    pod  := key[0..<ix]
    name := key[ix+2..-1]
    return Pod.find(pod, false)?.locale(name) ?: key
  }

  private Str:Button? buttons := [:] { ordered=true }
  private Str? defButton  := null
  private Func? cbAction  := null
}