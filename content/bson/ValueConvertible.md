+++
date = "2016-12-26T12:11:57+01:00"
title = "ValueConvertible"
[menu.main]
  parent = "BSON"
  identifier = "ValueConvertible"
  weight = 82
  pre = "<i class='fa'></i>"
+++

## ValueConvertible

ValueConvertible is the backbone of BSON. BSONConvertible is a protocol that allows any existing type to represent itself as BSONPrimitive.

It requires the implementation of a function with the following signature:
`func makeBSONPrimitive() -> BSONPrimitive`, so it requires you to represent the ValueConvertible as a primitive.

There are a number of BSON Primitives.

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

Document does not exclusively interact with BSONPrimitives but with ValueConvertibles instead.

Normally you can create a Document like this:

```swift
let document: Document = [
	"name": "henk",
	"age": 24,
	"awesome": true,
	"subdocument": [
		"creation": Date(),
		"modification": Date()
	] as Document
]
```

By conforming your type to ValueConvertible you can embed your custom types as BSON type and directly embed them.

```swift
struct MutationDate: ValueConvertible {
	var creation = Date()
	var modification = Date()
	
	func makeBSONPrimitive() -> BSONPrimitive {
		return [
			"creation": self.creation
			"moficiation": moficiation
		] as Document
	}
}

let document: Document = [
	"name": "henk",
	"age": 24,
	"awesome": true,
	"subdocument": MutationDate()
]
```

This doesn't sound like much but helps when you have custom objects that aren't already representable as BSON.

A password needs to be hashed, but needs it's salt, iterations and possibly the algorithm stored. The password ans salt can be binary, the iterations an Int32 or Int64 and thethe algorithm can be defined as a String. All come together in a Document, but you'll need this password to be a part of a User Document, so the password needs to be embeddable in the root Document. Last, but not least, you'll want to have functions on this password that will validate against inputted passwords on a website for example.

This is a good use case for compliance to ValueConvertible.