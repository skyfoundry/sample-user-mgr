//
// Copyright (c) 2019, SkyFoundry LLC
// Licensed under the MIT License
//
// History:
//   23 Dec 2019  Andy Frank  Creation
//

using web
using webmod

const class UserMgrMod : WebMod
{
  override Void onGet()
  {
    name := req.modRel.path.first
    switch (name)
    {
      case null:  onIndex
      case "pod": onPodResource
      default:    res.sendErr(404)
    }
  }

  override Void onPost()
  {
  }

  ** Load index.
  private Void onIndex()
  {
    res.headers["Content-Type"] = "text/html; charset=utf-8"
    out := res.out
    out.docType
    out.html
    out.head
      .title.w("User Manager").titleEnd
      .includeCss(`/pod/domkit/res/css/domkit.css`)
      .includeCss(`/pod/sampleUserMgr/res/styles.css`)
      .includeJs(`/pod/sys/sys.js`)
      .includeJs(`/pod/util/util.js`)
      .includeJs(`/pod/concurrent/concurrent.js`)
      .includeJs(`/pod/graphics/graphics.js`)
      .includeJs(`/pod/web/web.js`)
      .includeJs(`/pod/dom/dom.js`)
      .includeJs(`/pod/domkit/domkit.js`)
      .includeJs(`/pod/sampleUserMgr/sampleUserMgr.js`)
      WebUtil.jsMain(out, "sampleUserMgr::UserMgr")
      out.headEnd
    out.body.bodyEnd
    out.htmlEnd
  }

  ** Service a pod resource file.
  private Void onPodResource()
  {
    File file := ("fan://" + req.uri[1..-1]).toUri.get
    if (!file.exists) { res.sendErr(404); return }
    FileWeblet(file).onService
  }
}
