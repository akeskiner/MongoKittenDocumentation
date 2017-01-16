+++
date = "2016-12-14T12:36:56Z"
title = "Aggregation"
[menu.main]
  parent = "Tutorials"
  identifier = "Aggregation"
  weight = 46
  pre = "<i class='fa'></i>"
+++
# Aggregation

## Overview

Aggregation operations process data records and return
computed results. Aggregation operations group values from
multiple documents together, and can perform a variety of
operations on the grouped data to return a single result.

## The Aggregation Pipeline

The aggregation pipeline is a framework for data aggregation
modeled on the concept of data processing pipelines. Documents
enter a multi-stage pipeline that transforms the documents into
aggregated results.

For a full explanation and a complete list of pipeline stages
and operators, see the [manual:](https://docs.mongodb.com/manual/core/aggregation-pipeline/)

The following example uses the aggregation pipeline on the
[restaurants](https://raw.githubusercontent.com/OpenKitten/Mongo-Assets/master/restaurants.json) 
sample dataset.

In the following example, the aggregation pipeline

- first use a `$match` stage to filter for documents whose `categories` array field contains the element `Bakery`. 
The example uses [`AggregationPipeline.Stage.matching`](http://mongokitten.openkitten.org/Structs/AggregationPipeline/Stage.html#/s:ZFVV11MongoKitten19AggregationPipeline5Stage8matchingFVS_5QueryS1_) to build the `$match` stage.
- Then, uses a `$group` stage to group the matching documents by the starts field, accumulating a count of documents for 
each distinct value of `stars`. The example uses [`AggregationPipeline.Stage.grouping`](http://mongokitten.openkitten.org/Structs/AggregationPipeline/Stage.html#/s:ZFVV11MongoKitten19AggregationPipeline5Stage8groupingFTPS_23ExpressionRepresentable_8computedGVs10DictionarySSOS_26AccumulatedGroupExpression__S1_) to build the `$group` stage 
and [`AccumulatedGroupExpression.sumOf`](http://mongokitten.openkitten.org/Enums/AccumulatedGroupExpression.html#/s:ZFO11MongoKitten26AccumulatedGroupExpression5sumOfFtGSaPS_23ExpressionRepresentable___S0_) to build the accumulator expression.


```swift
import MongoKitten

let server = try Server(mongoURL: "mongodb://localhost:27017")
let database = server["tutorial"]

let restaurants = database["restaurants"]

let matchStage = AggregationPipeline.Stage.matching("categories" == "Bakery")
let groupStage = AggregationPipeline.Stage.grouping("$stars", computed: ["count": .sumOf(1)])

let pipeline: AggregationPipeline = [matchStage, groupStage]

let results = try restaurants.aggregate(pipeline: pipeline)

let _ = results.map {
    print($0.dictionaryValue)
}
``` 


