+++
date = "2016-12-14T12:36:56Z"
title = "KittenTemplating"
[menu.main]
  parent = "Tutorials"
  identifier = "kittentemplating"
  weight = 20
+++

# KittenTemplating

KittenTemplating is a bitcode format and runtime for Swift templates. Currently it only supports parsing Leaf syntax.

The goal of KittenTemplating is to provide high performance for existing templates.

## Installation

And include this in your Package.swift and rebuild your .xcodeproj file using `swift package generate-xcodeproj`.

```
  dependencies: [
    .Package(url: "https://github.com/OpenKitten/KittenTemplating.git", majorVersion: 0, minor: 6)
  ]
```

## Parsing/Compiling leaf templates

Before being able to use a library, you'll need to convert your template(s) to bitcode.
This works similar to Leaf. You have a "Stem", which is a directory of Leafs (templates).

In the same fashion, we use a "path" (directory) that contains Leaf templates.

Compiling a template is necessary before running.

```swift
import KittenTemplating

let homePage = try LeafSyntax.compile("index.leaf", atPath: "/path/to/templates/")
```

At this point, your `homePage` variable contains all the information the templates need to start rendering.

## Running the templates

Rendering a template is simple. All you need to do is call the `run()` function on your template object to start rendering.

The output is `[UInt8]` bytes. This can be returned via the preferred route, usually HTTP.

For integration with other (HTTP) frameworks [click here.]({{< relref "frameworks/Frameworks.md">}})

```swift
let renderedTemplate = try homePage.run()
```

## Providing some context

Most templates require some form of context. Either the user (username, email, fullName, ...), or the information for usage in a table.

You can provide a context to `run()` which will work like a Dictionary.

```swift
let renderedTemplate = try homePage.run(inContext: [
  "user": [
    "username": "JoannisO",
    "email": "joannis@orlandos.nl"
  ],
  "numbers": [
    0, 2, 4, 8, 16, 15, 13, 11
  ]
])
```
