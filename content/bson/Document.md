+++
date = "2016-12-26T12:14:08+01:00"
title = "Document"
[menu.main]
  parent = "BSON"
  identifier = "Document"
  weight = 84
  pre = "<i class='fa'></i>"
+++

# Document

Document is the primary type of BSON. It's either a Dictionary or Array and allows interaction like a native Swift Dictionary or Array.

## Basic Usage

Documents are usable like any other Swift dictionary/array. Only you'll need to explicitely specify your variable to be a Document.

```swift
let document: Document = [
	"my": "data",
	"isAwesome": true
]
```

or

```swift
let document = [
	"my": "data",
	"isAwesome": true
] as Document
```

Alternatively, if you need an Array, you can use the Array literal.

```swift
let arrayDocument = [
	1, 2, 3, 4, 5
]

let arrayDocument2 = [
	"a", "b", "c", "d", "e"
]
```

There are two restrictions to a Document.

- If the Document is a Dictionary, the key *must* be a String
- The Value in both the Dictionary and Array for *must* be a ValueConvertible.

However, ValueConvertible is a protocol that, by defaut, supports BSON primitives. BSON Primitives can always be used. And custom types can be ValueConvertible.

Documents allow various methods of initializing:

```swift
let document0 = Document()
let document1 = Document(array: ...)
let document2 = Document(dictionaryElements: ...)
let document3 = Document(data: [5, 0, 0, 0, 0])
```

They allow actions like an array:

```swift
var document: Document = [1, 2, 3, 4, 5]

document.append(6)
document[3] // 4
document.count // 6
```

Or actions like a Dictionary:

```swift
var document: Document = [
	"key0": 0,
	"key1": 1,
	"key2": 2,
	"key3": 3
]

document["key1"] // 1
document["key4"] // nil
document["key4"] = 4
document["key4"] // 4

document.keys // ["key0", "key1", "key2", "key3", "key4"]
document.values // [0, 1, 2, 3, 4]
```

Dictionary Documents act like you would expect.

```swift
let document: Document = [
  "hey": true,
  "hello": 3.33
]

for (key, value) in document {
	guard key == "hey" || key == "hello" else {
		fatalError("Impossible!")
	}
	
	guard value as? Bool == true || value as? Double == 3.33 else {
		fatalError("Impossible!")
	}
}
```

Array Documents act in a similar way:

```swift
let document: Document = [true, false, 3.3, false, true]

for (key, value) in document {
	guard ["0", "1", "2", "3", "4"].contains(key) else {
		fatalError("The key in an array is the position as string number")
	}
}
```

Documents can be easily embedded inside each other. Because of this we allow you to easily subscript a Document to access sub-Documents and even deeper layers of the structure using variadic subscripts.

These subscripts accept Strings (for Dictionary Document keys) and `Int`egers (for Array positions or Dictionary positions). These work like you would expect from any other Array or Dictionary.

```swift
var document = [
	"subdoc": [
		"subsubdoc": [
			"array": [0, false, true, "henk"]
		] as Document
	] as Document
] as Document

// Get element position 2 from array in subsubdoc in subdoc in document
document["subdoc", "subsubdoc", "array", 2] // true
```

Document also provides some extra features that are commonly used with BSON:

```swift
var document: Document = [
	"key": true,
	"subdoc": [
	  "value": 3
	] as Document
]

document[dotNotated: "subdoc.value"] // 3

document.flattened() // ["key": true, "subdoc.value": 3]
```