+++
date = "2016-12-14T12:36:56Z"
title = "Meow Mongo (ORM)"
[menu.main]
  parent = "Tutorials"
  identifier = "meowmongo"
  weight = 20
+++

# (Meow)Mongo ORM

MeowMongo is a MongoKitten based ORM using code generation.

It's USPs are a type-safe query language, type-safe index builder and a easy set up.

## Installation

[Install Sourcery](https://github.com/krzysztofzablocki/Sourcery#installing) to get access to the main USPs of this ORM.

And include this in your Package.swift and rebuild your .xcodeproj file using `swift package generate-xcodeproj`.

```
  dependencies: [
    .Package(url: "https://github.com/OpenKitten/MeowMongo.git", majorVersion: 0, minor: 3)
  ]
```

## Setting up your database connection

We've made this really easy. All you have to do is call `Meow.init` with your MongoDB connection string.
Please note, `Meow.init` needs to be spelled out *fully*. `Meow("mongodb://localhost")` *will not* work.

```swift
import MeowMongo

// TODO: Replace with MongoDB URL
try Meow.init("mongodb://localhost")
```

## Generating the rest with Sourcery

Assuming your terminal's PWD is the project root where `Package.swift` resides:

```sh
sourcery ./Sources/ .build/checkouts/MeowMongo*/Templates ./Sources/Generated.swift
```

This will scan your sources and generate a new file called `Generated.swift` in your project.

The first time you add this file you will need to regenerate the Xcode project:

```sh
swift package generate-xcodeproj
```

### Frequently updated models

If you frequently update your models (during development), add `--watch` to the sourcery command to update whenever a change is detected.

```sh
sourcery --watch ./Sources/ .build/checkouts/MeowMongo*/Templates ./Sources/Generated.swift
```

## Read More

- [Models - the most important part of an ORM]({{< relref "tutorials/meowmongo/Models.md" >}})
