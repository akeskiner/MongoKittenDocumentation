+++
date = "2016-12-14T12:36:56Z"
title = "index"
type = "index"
+++

# OpenKitten Documentation

OpenKitten consists of a group of actively supported libraries listed underneath.

## BSON

BSON is the underlying type for MongoDB and MongoKitten. Obviously it is important to understand BSON at a basic level before using MongoKitten. The learning curve is minimal and it feels like using a more polished Dictionary.

BSON is 5x slower than using specialized Dictionaries, but faster than almost all other libraries that do similar tasks by storing all data in serialized format it is the fastest serializer and still a really fast parser.

### Learning about BSON

- [Basic usage]({{< relref "bson/BSON.md" >}})
- [Document]({{< relref "bson/Document.md" >}})
- [Primitive]({{< relref "bson/Primitive.md" >}})
- [ObjectId]({{< relref "bson/ObjectId.md" >}})

## MongoKitten

MongoKitten is the fastest, and only native Swift MongoDB driver.
It works like you'd expect from familiar Swift types and protocols.

Not only is it the fastest Swift MongoDB driver but is on-par with popular drivers like the ones in:
- Ruby
- NodeJS
- Java

And outperforms drivers like the ones in:
- Go
- Dart

### Starting points

* [Installing the driver]({{< relref "installation-guide/index.md" >}})
* [Quick start]({{< relref "quick-start/index.md" >}})
* [Collection CRUD operations]({{< relref "tutorials/mongokitten/crud.md" >}})

### Next steps

* [Indexes]({{< relref "tutorials/mongokitten/Indexes.md" >}})
* [Grid FS]({{< relref "tutorials/mongokitten/gridfs/index.md" >}})

### Advanced topics

Advanced configuration and features for the driver.

* [Authentication]({{< relref "tutorials/mongokitten/connect/authenticating.md" >}})
* [SSL]({{< relref "tutorials/mongokitten/connect/ssl.md" >}})
* [FAQ]({{< relref "reference/faq/index.md" >}})

### Migrating to MongoKitten 3

If you are upgrading from a previous MongoKitten version (2.x or 3.x), consult the [migration guide]({{< relref "upgrade-migration/index.md" >}}) for
information on updating your code to MongoKitten 3.

## Cheetah
