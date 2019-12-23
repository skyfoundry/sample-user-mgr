//
// Copyright (c) 2019, SkyFoundry LLC
// Licensed under the MIT License
//
// History:
//   23 Dec 2019  Andy Frank  Creation
//

using dom
using domkit

@Js class UserMgr : Box
{
  ** Client-side entry point.
  static Void main()
  {
    mgr := UserMgr {}
    Win.cur.doc.body.add(mgr)
    mgr.onInit
  }

  ** Constructor.
  new make()
  {
    toolbar := FlowBox {
      it.gaps = ["4px"]
      Button { it.text="New";    it.onAction { onNew  } },
      Button { it.text="Edit";   it.onAction { onEdit }; it.enabled=false   },
      Button { it.text="Delete"; it.onAction { onDel  }; it.enabled=false },
    }

    // TODO: replace me with domkit::Table which is empty
    // to start. See onInit to load model data.
    table := Box {
      it.style.addClass("domkit-border")
      it.style->padding = "20px"
      it.text = "TODO: user table here"
    }

    this.style->padding = "10px"
    this.add(SashBox {
      it.dir = Dir.down
      it.sizes = ["24px","10px","100%"]
      toolbar,
      Box {},  // spacer
      table,
    })
  }

  ** Init callback to load data
  private Void onInit()
  {
    // TODO:
    //  - load user data using dom::HttpReq
    //  - load data into domkit::Table
    //  - don't forget to call `Table.rebuild` to update contents
  }

  ** Callback to create a new record.
  private Void onNew()
  {
    // TODO:
    //  - present form to update user data
    //  - req to server to update rec in "database"
    //  - reload table data

    NewUser.open |form|
    {
      // TODO
      Win.cur.alert(form)
    }
  }

  ** Callback to edit an existing record.
  private Void onEdit()
  {
    // TODO:
    //  - present form to update user data
    //  - req to server to update rec in "database"
    //  - reload table data
  }

  ** Callback to delete an existing record.
  private Void onDel()
  {
    // TODO:
    //  - challengr user to confirm action
    //  - req to server to remove content
    //  - reload table data
  }
}