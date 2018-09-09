# GetYourGuide Assignment

GetYourGuide Assignment - Search Reviews iOS Application that uses GYG API

### Prerequisites

- xcode 9.4.1
- swift 4.1
- carthage

### Dependencies
- [Toaster](https://github.com/devxoul/Toaster)

### Installation

run following command on terminal in the project folder
```
carthage update --platform iOS
```

## Screen Shots
<br/>
<p align="center">
<img width="320" height="530" src="/Screenshots/home.png"/>
<img width="320" height="530" src="/Screenshots/favorites.png"/>
<br/>


# Architecture
The project is developed using MVVM-C archtecture with two additional layers for networking and persistence.

## Model

The models are implemented as structs. The models defining API responses implement `Decodable` protocol for mapping response data to swift structs as well as requests implement `Encodable` to provide json for URLRequests.

## View

The view controllers and storyboards are considered parts of this layer. The responsibility of this layer is only the presentation of data to user and receiving events from user. ViewControlers also don't know navigation logic.

## ViewModel

The view models contain business logic of a view. Preparing data for presentation and handling user events are responsibilities of this layer.

A view model knows nothing about a view but emits events which a view observes by Observable to present data accordingly. The event listening is done in a single block providing event enum value. The primary reason for using a single callback is to reduce the possibility of infamous retain cycles.


## Coordinator

 Coordinator listens ViewController by delegate patern and provides navigation between them. Also Coordinator is responsible for dependemcy injections, here it's possible to change ApiClient and Repository easily.

## Network

This layer is responsible for executing web requests and providing response in asynchronous way. It is described by `RequestSender` protocol. The idea stands that every call to server is a request object that represented 
be Request protocol, it has dynamic reference to `Response`, they must conform Encodable and Decodable respectivelly,
so they can be dynamically be converted to json by `RequestSender`. Its implementation is built on `URLSession`, but can be easily changed to any other networking library. 

## Persistence

This layer is responsible for persisting data based on repository pattern. So there would be a separate repository class for each different kind of entity. For current implementation it is using `CoreData` as repository for Reviews but can be easily changed to any others which must conform `ReviewsRepository`
