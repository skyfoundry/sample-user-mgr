//
// Copyright (c) 2019, SkyFoundry LLC
// Licensed under the MIT License
//
// History:
//   23 Dec 2019  Andy Frank  Creation
//

using util
using web
using webmod
using wisp

class Main : AbstractMain
{
  @Opt { help = "http port" }
  Int port := 8080

  override Int run()
  {
    wisp := WispService
    {
      it.httpPort = this.port
      it.root = UserMgrMod()
    }
    return runServices([wisp])
  }
}
