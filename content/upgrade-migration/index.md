+++
date = "2016-12-14T12:36:56Z"
title = "Upgrade Guide"
[menu.main]
  identifier = "Upgrade Guide"
  weight = 45
  pre = "<i class='fa fa-cog'></i>"
+++
# Migrating to MongoKitten 3

This guide will help users of MongoKitten 1.x and 2.x to migrate to MongoKitten 3.

## Setup

The setup for Connection URLs stays mostly the same. But the parameter is now named "mongoURL"

`let server = try Server("mongodb://...")` becomes `let server = try Server(mongoURL: "mongodb://...")`

The connection URL supports `authSource`, `authMechanism`, `ssl`, Replica Sets and Sharded Clusters. But if you prefer not using an URL you still can.

MongoKitten 3 has an object "ClientSettings" which separates out the settings from the server.

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

However, all Documents need to have their type explicitely defined now. This would look like the following

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
  ] as Document
]
```

### Subscripting

Subscripting has changed quite a bit. We've moved from succeeding subscripts to variadic subscripts because we feel that it better serves our purpose.

The variadic subscripts come in two forms: a type inferred and a raw getter.

`doc["subDoc"]["name"]` will become `doc[raw: "subDoc", "name"]` and will return an optional generic Value.
`Value` has been removed entirely, including `.nothing`. Checks for `Value.nothing` need to be replaced with `nil`.

The raw subscript will get the object as you present it. Which can be any ValueConvertible including all BSON types.

`doc["subdoc", "boolean"] as Bool?` will get the value called "boolean" inside "subdoc" and will return a boolean if it's representable as one.
`doc["_id"] as String?` will try to convert the value to a String. So `Int64(3)` will become `"3"`. A String will stay a String, and ObjectIds will represent themselves as a hexadecimal String.

`doc["_id"] as String?` is exactly equal to `doc[raw: "_id"]?.string`. Both will now return an optional.

If you want to know the type of the data, always use raw subscripting. If you prefer a specific type like a String, use `as String?` or `raw: ...]?.string`

### Extraction getters

Previous versions of BSON and MongoKitten allowed you to get a default value using `.string`, `.int`, `.int32`, etc. This doesn't work anymore. Extracting Strings with `.string` will only return a String if it's clearly representable as a String. Bool represents true or false. But converting it backwards isn't possible since you don't know the type. Integers will be converted to a String and backwards. If a String like `"3.14"` is requested as a Double, BSON will return the value `3.14` as a Double, instead of nil.

### Optional chaining

Because of the vast use of optionals in the new Documents you'll have to set the default values yourself.
Where you would use `doc["stringKey"].string` for getting a `String` you will now receive an optional that will need to be unwrapped or chained. 

```swift
let doc: Document = [
  "stringKey": "Hello World!"
]

print(doc["stringKey"].string) // Prints "Hello World!" unless we can't find a String. Then it will print ""
```

Will become

```swift
let doc: Document = [
  "stringKey": "Hello World!"
]

print(doc["stringKey"] as String? ?? "") // Prints "Hello World!" unless we can't find a String. Then it will print ""
```

or `print(doc["stringKey"].string ?? "")`
