+++
date = "2016-12-14T12:36:56Z"
title = "Upgrade Guide"
[menu.main]
  identifier = "Upgrade Guide"
  weight = 45
  pre = "<i class='fa fa-cog'></i>"
+++
# Migrating to MongoKitten 4

This guide will help users of MongoKitten 1.x, 2.x and 3.x to migrate to 4.x

## Setup

The connection URL supports `authSource`, `authMechanism`, `ssl`, Replica Sets and Sharded Clusters. But if you prefer not using an URL you still can.

MongoKitten 4 has an object "ClientSettings" which separates out the settings from the server.

ClientSettings accepts one or more hosts. Multiple hosts should only be used for replica sets and sharded databases.

`ClientSettings(host: ...)` accepts a MongoHost. Which is manually creatable but is initializable using a String (literal).

The String needs to be formatted like this:
`subdomain.example.com:12345`.

The ClientSettings then accepts `sslSettings`. sslSettings is an object that has 3 values. One for enabling or disabling SSL. The other 2 are for certificate and host validation.

SSLSettings is ExpressibleByBooleanLiteral, so `true` will enable SSL with secure defaults. `false` will not use SSL.

Last but not least ClientSettings accepts login details in the form of `MongoCredentials`.

This accepts a username, password and database. If you don't know the authentication database (it's not always the same database as the one you're trying to access) you can leave it empty wil `nil` here.

### Connecting

The `automatically` parameter has been removed. MongoKitten will always connect automatically now and will always attempt to reconnect.

`server.connect()` has been removed for the same reason.

## Documents and Values

The `~` operator has been removed because Values are now directly embeddable inside Documents/Dictionary literals.

```swift
let name = "Joannis"

let doc: Document = [
  "name" ~name,
  "name2": "Joannis"
  "subDoc": [
    "name": ~name
  ]
]
```

Will become

```swift
let name = "Joannis"

let doc: Document = [
  "name" name,
  "name2": "Joannis"
  "subDoc": [
    "name": name
  ]
]
```

### Subscripting

Document subscripts can be chained in MongoKitten 4.

`Bool(doc["subdoc"]["boolean"])` will get the value called "boolean" inside "subdoc" and will return a boolean if it's representable as one, nil otherwise.
`String(doc["_id"])` will try to convert the value to a String. So `Int(3)` will become `"3"`. A String will stay a String, and ObjectIds will represent themselves as a hexadecimal String.

### Collection insertion

Collection now feels more like a sequence, so inserting has been simplified.

```
try collection.insert(contentsOf: [
    userJoannisDocument, userLaurentDocument, userRobbertDocument
  ])
```
