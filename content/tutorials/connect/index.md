+++
date = "2016-12-14T12:36:56Z"
title = "Connect to MongoDB"
[menu.main]
  parent = "Tutorials"
  identifier = "Connect to MongoDB"
  weight = 0
  pre = "<i class='fa'></i>"
+++

## Setup

MongoKitten is initializable on Server or Database level. Server objects allow access to every database - if the account you use to authenticate has the permissions to - and is generally not used.

Database is initializable separately and allows access to a single database on a MongoDB server. You can still access the server object from the Database and access other parts of the server via there if this is necessary.

You can instantiate a Server using a MongoDB connection URL/String:

```swift
let server = try Server(mongoURL: "mongodb://localhost")
```

The database also has two initializers. One accepts a connection URL as String. The database which is accessed is equal to the authentication database in this case.

```swift
let database = try Database(mongoURL: "mongodb://user:password@ds12345-a0.domain.com:25078,ds12345-a1.domain.com:25078/kitten?replicaSet=rs-ds125078")
```

Alternatively you can create a server object and select the database from there:

```swift
let server = try Server(mongoURL: "mongodb://localhost")

let database = server["my-database-name"]
let database = Database(named: "my-database-name", atServer: server)
```

Last but not least you can select a collection/table within a database:

```swift
let usersCollection = database["users"]
```

From here you can interact with every part of MongoKitten.
