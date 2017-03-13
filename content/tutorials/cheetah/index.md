+++
date = "2016-12-14T12:36:56Z"
title = "Cheetah"
[menu.main]
  parent = "Tutorials"
  identifier = "cheetah"
  weight = 11
  pre = "<i class='fa'></i>"
+++

# Cheetah - JSON

Cheetah is a JSON library that is really performant and easy to use at the same time.

It provides an API similar to BSON which makes it feel part of the ecosystem.
Using KittenCore, Cheetah and BSON objects can be converted to the other.

It is both performant and unicode compliant.

## Initialization

```json
{
  "names": ["Joannis", "Laurent", "Robbert"],
  "awesomeNumber": 3,
  "OpenKitten approved": true,
  "bignum": 13.37e+100,
  "smallnum": -1,
  "project": "Cheetah",
  "details": {
    "open": "Kitten",
    "license": "MIT"
  }
}
```

This works out in Cheetah like this:

```swift
let object: JSONObject = [
  "names": ["Joannis", "Laurent", "Robbert"],
  "awesomeNumber": 3,
  "OpenKitten approved": true,
  "bignum": 13.37e+100,
  "smallnum": -1,
  "project": "Cheetah",
  "details": [
    "open": "Kitten",
    "license": "MIT"
  ]
]
```

## Extraction

Whenever you want to extract values you can subscript it painlessly:

```swift
let project = String(object["project"])
let bignum = Double(object["bignum"])
let smallnum = Int(object["smallnum"])
let approved = Bool(object["OpenKitten approved"])
let license = String(object["details"]["license"])
```

## Parsing

Serialization:
