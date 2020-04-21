# Sample User Manager

This repo contains skeleton code for implementing a sample project that builds
a basic CRUD UI to edit a database of users using Fantom and DomKit.

## Setup

[path-env]:    https://fantom.org/doc/docLang/Env#PathEnv
[fan-install]: https://fantom.org/download

This repo contains a `fan.props` file which creates its own local
[PathEnv][path-env]. You can verify this by running `fan -version`:

    sample-user-mgr$ fan -version
    Fantom Launcher
    Copyright (c) 2006-2019, Brian Frank and Andy Frank
    Licensed under the Academic Free License version 3.0

    Java Runtime:
      ...
      fan.env:         util::PathEnv
      fan.home:        /Users/andy/proj/fan/dev

    Env Path:
      /Users/andy/proj/sf/sample-user-mgr (work)
      /Users/andy/proj/fan/dev (home)

The `fan.home` value should point to your [Fantom installation][fan-install]
and your `Env Path` should include your fork of this project.

## Building

This project will compile and run out-of-the-box to make it easy to start
filling in the missing pieces.

To compile:

    sample-user-mgr$ src/sampleUserMgr/build.fan

To run:

    sample-user-mgr$ fan sampleUserMgr
    [11:00:39 23-Dec-19] [info] [web] http started on port 8080

Point your browser to `http://localhost:8080` to load the page.

## Implementation Notes

[doc-dom]:    https://fantom.org/doc/dom/index#overview
[doc-xhr]:    https://fantom.org/doc/dom/index#xhr
[doc-domkit]: https://fantom.org/doc/docDomkit/Intro
[doc-table]:  https://fantom.org/doc/docDomkit/Controls#table
[csv-in]:     https://fantom.org/doc/util/CsvInStream
[csv-out]:    https://fantom.org/doc/util/CsvOutStream

 * The [dom][doc-dom] chapter covers practical API usage for the core DOM pod,
   including [HttpReq][doc-xhr].

 * The [docDomkit][doc-domkit] chapter covers the high level overview as
   well as practical examples of all the DomKit APIs.

 * See [Table][doc-table] section for details on wiring up `domkit::Table`

 * User demo data is available under `data/users.csv`

 * See [CsvInStream][csv-in] and [CvsOutStream][csv-out] for APIs to
   read and write CSV data.

 * Start with `UserMgr.onInit` to wire up `data/users.csv` into the main
   `domkit::Table` instance.

 * See `NewUser` for skeleton code for creating and laying out controls
   in a dialog box.
