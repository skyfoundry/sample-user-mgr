#! /usr/bin/env fan

using build

class Build : build::BuildPod
{
  new make()
  {
    podName = "sampleUserMgr"
    summary = "Sample User Manager Project"
    version = Version("1.0")
    depends = [
      "sys 1.0",
      "util 1.0",
      "concurrent 1.0",
      "web 1.0",
      "webmod 1.0",
      "wisp 1.0",
      "graphics 1.0",
      "dom 1.0",
      "domkit 1.0"]
    srcDirs  = [`fan/`, `fan/ui/`]
    resDirs  = [`res/`]
  }
}
