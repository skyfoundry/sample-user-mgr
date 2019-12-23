//
// Copyright (c) 2019, SkyFoundry LLC
// Licensed under the MIT License
//
// History:
//   23 Dec 2019  Andy Frank  Creation
//

using dom
using domkit

@Js class NewUser
{
  ** Open new user dialog and return content
  static Void open(|Str:Str form| onCommit)
  {
    username := TextField { it.style->width="400px" }
    fullname := TextField { it.style->width="400px" }
    email    := TextField { it.style->width="400px" }
    role     := ListButton {
      it.style->width = "140px"
      it.items = ["su","dev","ops","biz","markcomm","legal"]
      it.sel.index = 0
    }

    ContentDialog
    {
      it.title   = "New User"
      it.content = GridBox
      {
        it.style->padding = "6px"
        it.cellStyle("*", "*", "padding:4px")
        it.addRow([Label { it.text="Username"  }, username])
        it.addRow([Label { it.text="Full Name" }, fullname])
        it.addRow([Label { it.text="Email"     }, email])
        it.addRow([Label { it.text="Role"      }, role])
      }
      it.addButton("ok", "Ok", true)
      it.addButton("canel", "Cancel")
      it.onOpen { username.focus }
      it.onAction |key|
      {
        if (key == "ok")
        {
          // TODO: can return 'false' to prevent dialog from
          // closing to handle validation without losing
          // user supplied form data

          // build from from controls
          form := Str:Str[
            "username": username.val.trim
            // fullname
            // email
            // role
          ]

          // invoke onCommit callback
          onCommit(form)
        }

        return true
      }
    }.open
  }
}