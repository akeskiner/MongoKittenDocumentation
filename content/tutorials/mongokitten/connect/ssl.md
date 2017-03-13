+++
date = "2016-12-14T12:36:56Z"
title = "SSL Settings"
[menu.main]
  parent = "Connect to MongoDB"
  identifier = "TLS/SSL Settings"
  weight = 35
  pre = "<i class='fa'></i>"
+++

# TLS/SSL

MongoKitten supports TLS/SSL connections to MongoDB that support TLS/SSL support.

You can add the query parameter "ssl" to your connection string `mongodb://.....?ssl` or enable SSL in the ClientSettings when initializing a Server. SSLSettings are an immutable part of the ClientSettings, so any configuration will have to be done prior to initializing a ClientSettings object with SSLSettings. SSL configuration be done using secure defaults by initializing it with a `true` literal.

```swift
var sslSettings: SSLSettings = true
```

These sslSettings can then be modified to accept a specific certificate or even allow unverified hostnames and/or certificates.
