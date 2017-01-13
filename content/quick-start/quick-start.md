+++
date = "2016-12-14T12:36:56Z"
title = "Quick Start"
[menu.main]
  identifier = "Quick Start"
  weight = 15
  pre = "<i class='fa fa-road'></i>"
+++

Quick Start
===========
This guide will show you how to set up a simple application using Swift Package Manager and MongoDB. Its scope is only how to set up the driver and perform the simple CRUD operations. For more in-depth coverage, see the [tutorials]({{< relref "tutorials/index.md" >}}).

Create the package.swift file
----------------------------
First, create a directory where your application will live.

```
mkdir myproject
cd myproject
```

Enter the following command and answer the questions to create the initial structure for your new project:

```
swift package init --type executable
```

Next, install the driver dependency.

Add this to your `Package.swift` for the stable

`.Package(url: "https://github.com/OpenKitten/MongoKitten.git", majorVersion: 2)`

Or add this to your `Package.swift` for the beta of MongoKitten 3

`.Package(url: "https://github.com/OpenKitten/MongoKitten.git", "3.0.0-beta")`

And `import MongoKitten` in your project.

You should see **SPM** download a lot of files. Once it's done you'll find all the downloaded packages under the **Packages** directory.

Start a MongoDB Server
---------------------------
For complete MongoDB installation instructions, see [the manual](https://docs.mongodb.org/manual/installation/).

1. Download the right MongoDB version from [MongoDB](https://www.mongodb.org/downloads)
2. Create a database directory (in this case under **/data**).
3. Install and start a ``mongod`` process.

```
mongod --dbpath=/data
```

You should see the **mongod** process start up and print some status information.
