+++
draft = true
date = "2016-12-26T13:28:36+01:00"
title = "ExtendedJSON"
[menu.main]
  parent = "BSON"
  identifier = "ExtendedJSON"
  weight = 85
  pre = "<i class='fa'></i>"
+++

## ExtendedJSON

MongoDB extended JSON is a type-safe representation of BSON as JSON String. This library contains a parser/serializer for that.

When receiving a JSON object that is MongoDB extended JSON you can initialize the Array/Dictionary Document using the intializer:

```swift
let document = Document(extendedJSON: jsonString)
```

Documents (and other ValueConvertibles) can also be serialized to a String using the `makeExtendedJson() -> String` functionality.

```swift
let jsonString = document.makeExtendedJSON()
```

Both are easily convertible to- and from each other.

Extended JSON is particularely useful in combination with a JavaScript client which is able to interact with MongoDB Extended JSON.

This allows you to - for example - transfer a date as a typed object which the Javascript client would convert back into a DateTime object.