+++
date = "2016-12-14T12:36:56Z"
title = "Authentication"
draft = true
[menu.main]
  parent = "Connect to MongoDB"
  identifier = "Authentication"
  weight = 30
  pre = "<i class='fa'></i>"
+++

# Authentication

Authentication is done using by either providing a MongoDB connection string or a ClientSettings object.

## MongoDB connection String

Authentication via a connection String requires the username and password on the left side of the hostname like so:

```swift
let database = try Database(mongoURL: "mongodb://user:password@hostname")
```

The username and password need to be URL percent encoded.

### Query Parameters

You can enable SSL with the query parameter `ssl` as described [here.]({{< relref "tutorials/connect/ssl.md" }})

If you need to authenticate to a specific database other than "admin" you can provide an "authSource":

```swift
let database = try Database(mongoURL: "mongodb://user:password@hostname?authSource=myauthdb")
```

And if you need an authentication mechanism other than SCRAM you can select one using:

```swift
let database = try Database(mongoURL: "mongodb://user:password@hostname?authMechanism=SCRAM_SHA_1")
```

We currently only support "SCRAM_SHA_1" and "MONGODB-CR". Although other mechanisms can be implemented in the future.
