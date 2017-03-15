+++
date = "2016-12-26T12:09:53+01:00"
title = "BSONPrimitive"
[menu.main]
  parent = "BSON"
  identifier = "BSONPrimitive"
  weight = 81
  pre = "<i class='fa'></i>"
+++

# BSON Primitive

BSON is based upon a set of primitive types. These are described [here](http://bsonspec.org/spec.html).

In this BSON library we contain a protocol: `BSONPrimitive`. This protocol is public and should normally *not* be implemented on an existing object.

This protocol is here to support all native Swift types that are related to an existing MongoDB type. Examples of this would be `Int` `Bool` `String`, but also custom BSON types like `JavascriptCode` and `Binary`.

BSONPrimitives are representable as BSON binary data that can be put into the Value position of a(n) (array-)Document.

These primitives also have a typeIdentifier that identifies the type of the binary data.

Adding custom types that does not conform to an unsupported/custom version of the BSON specification will *not* be deserialized and will result in corrupt data.

The list of BSON Primitives:

- Double
- String
- [Document]({{< relref "bson/Document.md" >}}) (Array and Dictionary)
- [ObjectId]({{< relref "bson/ObjectId.md" >}})
- Bool
- Int32
- Int (Int64)
- Binary
- Decimal128
- JavascriptCode
- Null (not nil)
- Date (from Foundation)
- MinKey
- MaxKey
- NSRegularExpression (or RegularExpression on Linux)

## Conversion

All BSON Primitive types can be used as the value in a Document. If you want to extract a value from a Document you'll need to subscript the Document and initialize the expected type with the subscript outcome:

```swift
let doc: Document = [
  "food": "cheese",
  "age": 3,
  "favouriteNumber": "3",
  "male": true
]

String(doc["food"]) // "cheese"
Int(doc["food"]) // nil
Int(doc["age"]) // 3
String(doc["age"]) // "3"
Int(doc["favouriteNumber"]) // 3
String(doc["favouriteNumber"]) // "3"
Bool(doc["male"]) // true
Bool(doc["nonExistentKey"]) // nil
```
