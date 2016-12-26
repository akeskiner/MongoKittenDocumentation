+++
date = "2016-12-26T12:09:53+01:00"
title = "BSONPrimitive"
[menu.main]
  parent = "BSON"
  identifier = "BSONPrimitive"
  weight = 81
  pre = "<i class='fa'></i>"
+++

# BSONPrimitive

BSON is based upon a set of primitive types. These are described [here](http://bsonspec.org/spec.html).

In this BSON library we contain a protocol: `BSONPrimitive`. This protocol is public and should normally *not* be implemented on an existing object.

This protocol is here to support all native Swift types that are related to an existing MongoDB type. Examples of this would be `Int` `Bool` `String`, but also custom BSON types like `JavascriptCode` and `Binary`.

BSONPrimitives are representable as BSON binary data that can be put into the Value position of a(n) (array-)Document.

These primitives also have a typeIdentifier that identifies the type of the binary data.

Adding custom types that does not conform to an unsupported/custom version of the BSON specification will *not* be deserialized and will result in corrupt data.

The list of BSON Primitives:

- Double
- String
- [Document](Document.md) (Array and Dictionary)
- [ObjectId](ObjectId.md)
- Bool
- Int32
- Int64
- Binary
- Decimal128
- JavascriptCode
- Null (not nil)
- Date (from Foundation)
- MinKey
- MaxKey
- NSRegularExpression (or RegularExpression on Linux)
