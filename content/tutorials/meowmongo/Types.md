+++
date = "2016-12-14T12:36:56Z"
title = "Supported Types"
[menu.main]
  parent = "meowmongo"
  identifier = "Types"
  weight = 20
+++

# Supported types

This list includes all types supported by MeowMongo.

Swift standard library types are prefixed with `Swift.`.

Foundation types are prefixed with `Foundation.`

BSON specific types are prefixed with `BSON.`.

Please note that we have our own RegularExpression object in BSON for compatibility purposes. Foundation.RegularExpression is not 100% equal in behaviour to BSON.RegularExpression.

- BSON.ObjectId
- Swift.String
- Swift.Int
- Swift.Int32
- Swift.Bool
- BSON.Document
- Swift.Double
- Foundation.Data
- BSON.Binary
- Foundation.Date
- BSON.RegularExpression
