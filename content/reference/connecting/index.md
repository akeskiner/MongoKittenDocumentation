+++
date = "2016-12-14T12:36:56Z"
title = "Connection Options"
[menu.main]
  parent = "Reference"
  identifier = "Connection Options"
  weight = 30
  pre = "<i class='fa'></i>"
+++

# URL

Before we go into much further detail we'll cover the concept and structure of a MongoDB connection URL.

The most basic example of this would be `mongodb://localhost`. This consists of the schema (`mongodb://` which is required in all MongoDB connection URLs) as well as the hostname, in this case, `localhost`.

The hostname can be either an IP address or a full address like `example.com`.

Hostnames can be succeeded by a semicolon `:` and a port. A port is a number between 0 and 66535. By default MongoDB is hosted on 27017 which is used by default.

In the URL you can also add the username and password and authentication database.

`mongodb://usern4m3:p455word@example.com:12345/admin`

In this example the hostname is `example.com`. The instance should be hosted at port `12345` and we're authenticating at the username `usern4m3` and the password `p455word`. The username and password should be URL percent encoded and the authentication database is `admin`

Last but not least we can specify multiple hosts in the case of a replica set.

`mongodb://username:password@host0.example.com:12345,host1.example.com:54321,host2.example.com:27017/admin`

In this example we're connecting to a replica set of 3 hosts.

- host0.example.com:12345
- host1.example.com:54321
- host2.example.com:27017

### Query parameters

After the URL's path (the database) you can optionally add Query parameters.

These are started with a question mark (`?`) and have key-value pairs. Pairs are separated by an ampersand (`&`). Every key-value pair has a key which is a string *without* `&`, `?` or `=` characters (unless percent encoded) which is then followed by an equals sign (`=`), followed by a value. The `=` and value are optional for some parameters.

`mongodb://localhost?ssl&authSource=admin&authMechanism=MONGODB-CR`

This URL has three keys:
- ssl
- authSource
- authMechanism

- `ssl` doesn't have a value
- `authSource` has the value `admin`
- `authMechanism` has the value `MONGODB-CR`

### SSL

SSL is enabled for a server by adding the query parameter key `ssl`.

`mongodb://mongodb.example.com:12345/myDatabase?ssl`

### authSource

`authSource` indicates that the authentication database differs from the default (admin) or the selected database in the path.

Where `mongodb://mongodb.example.com:12345/myDatabase` will use `myDatabase` for authentication and `mongodb://mongodb.example.com:12345` will use `admin`.

`mongodb://mongodb.example.com:12345/myDatabase?authSource=test` will use `admin` for authentication. This is also useful for databases where the user logs in against `admin` but the path is used for selecting a database, for example, in the Database initializer.

`mongodb://mongodb.example.com:12345/myDatabase?authSource=admin`

### authMechanism

Selects a mechanism that will be used for authentication to the MongoDB server.

MongoDB supports the following mechanisms:
- SCRAM_SHA_1
- MONGODB-CR
- MONGODB-X509
- GSSAP
- PLAIN

MongoKitten only supports `SCRAM_SHA_1` and `MONGODB-CR`, currently.