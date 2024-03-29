# TDD Clean Architecture

This Flutter project implements clean architecture principles, emphasizing test-driven development (TDD) practices. Clean architecture promotes separation of concerns, maintainability, and testability by organizing code into distinct layers.

## Overview

This project serves as a template for building Flutter applications using clean architecture. It provides a structured approach to application development, with clear separation of business logic, presentation logic, and data access.

## Clean Architecture Principles

This Since we are focusing on Flutter we are going to start with lib folder.
![Folder Structure](assets/1.png)
 

Rest of the folders would reside inside lib/core and lib/src folder. Your core folder would contain the core features of the app written in dart code (mostly) and src folder would contain the screens or pages.

Three layers are Presentation layer, Domain layer and Data layer. Look at the flow them how they are called. The below picture show bidirectional flow of the layer communications.
![Folder Structure](assets/1.png)
 

## Domain layer

Domain layer contains the business logic of our application. But this is not BLoC business logic. Strongly suggest to write your code from domain layer.

In general, domain layer works with presentation layer. Domain layer is triggered by an events from presentation layer. These events could be a button press or API calling.

Domain does not depend on anyone. Presentation layer finds domain layer to work with.

First let's a look at this layer and folder structure
![Layer Communication](assets/2.png)

Here you can see that have entities, repos and usescases folder. First we should create entities.

## Entities in domain layer

Entities hold the blue print of our data model which we will pass around for a certain features or screens or pages.
![Domain Layer Structure](assets/3.png)
Entities are necessary when we deal with incoming responses from our server. Server response data has to match with our data model. 

For example, an user's information coming from server has to match in our application. So we create entities to do it. It's like one on one relationship with server repsponse data.

## Repositories in domain layer

After that we create repository or repos. Repositories contains abstract classes or interfaces. Dart does not have interfaces, Dart only gives us abstract classes. We will use abstract classes to mimic interfaces.

They are the rules of a particular feature or screen. These classes define what a particular feature should do.
![Repositories Structure](assets/4.png)

These classes contain methods signature. So the signatue defines what a feature should do. 
You should also notice that it's an abstract class. It means either we extend or implement this class by others.

Using the repositories we define a contract between domain layer and data layer. In other words because of repositories we can reach from domain layer to the data layer.

If we implement this class by other class, that means all the methods defined in the AuthRepo class must in the other class. All the methods must be defined in the class subclass of AuthRepo, which we will see later. The subclass is AuthRepoImpl.

This is called repository pattern. In repository pattern, we create a layer of abstract between the UI and data layer.

When presentation layer communicates with domain layer, presentation layer first reach out to usecases folder in domain layer.

## Usecases in domain layer

From the name it implies that, usecases tells you the features of our application. It means what methods are defined there to create certain app features or functions. 

Usecases depend on repositories. Every usecase in general depends on a repo.
![Use Cases Structure](assets/5.png)

Usecases sub layer contains tunnel between presentation and domain layer. In general, this is only tunnel between presentation layer and domain layer to communicate.
![Use Cases Structure](assets/6.png)

Here you see how we reached out from our AuthBloc to SignIn class. AuthBloc belongs to presentation layer but it reaches for SignIn class in the usecases folder. 

After that usecases reaches to repo which has AuthRepo. AuthRepo is an abstract class and it is implemented by the data layer.

This usecases layer should only contain a class or methods and helper related logic or function.

Usecases layer should be very independent and should not take anything outside of Domain layer.
![Use Cases Structure](assets/7.png)

No error handling happens in domain layer

## Data layer

Data layer is for fetching data from outside world or from local storage to app. Data layer depends on domain layer. If you delete domain layer, data layer will get error. But the opposite is not true. In general data layer contains three below folders.

1. datasources
2. models
3. repos

![Data layer Structure](assets/8.png)

## Models in data layer

Models in data layer are like entities. But they have more features. they are the extension of the entities, so we will let our model class to extend our entity. So an entity becomes our parent class for a model.

Models are the ones that we test in TDD. 

In our models in data layer we will have toJson, fromJson, copyWith method like these.

## Repositories in data layer

The repos in data layer are also the implimentation of the repos in the domain layer. Why is so? because the repositories in the domain layer are abstruct classes. 

We can not use those abstract classes in directly, we need to someone to take them and extend them. Repositories in the data layer this job of extention or implimentation. 

This is how domain and data layer interact with each other.

The CRUD operations also happen here in the repository of data layer. So this repositories do the actual work of engineering. 

This repositories also depends on the data source of data layer. 
![Repositories and Data source](assets/9.png)

## Data source in data layer

Data source in the data layer creates a link with the outside world. Data source query API, database or even local storage.

These data sources depends on external packages or source like http or sharedpreferences. If you server is firebase, then data source would depend on your firebase instances. 

Since data layer works with external resources and fetch data, it also throws exceptions if necessary. We used dartz package to handle the success or failure.

From the above picture you will see auth_remote_data_source.dart file. This class will contain an abstract class AuthRemoteDataSource as well an implementation of this abstract class name AuthRemoteDataSourceImpl. 
![Data source](assets/10.png)

What ever is defined in the domain layer repositories(repos), data layer repositories would implement them. Remember that repos in the domain is all abstract classes. Datasource would be taken from external server or local storage. The exact approach how to reach out to the external source or local storage is defined in the repos of this layer.

Since we are using GetIt for depedency injection, data layer's repos would have the notion of the repos of datasource. 

Error handling happens here

## Presentation layer

Presentation layer may include your bloc, views, utils, and widgets. This layer mostly depends on other layer.

How the layer may look like see the picture below

![Presentation Layer Structure](assets/11.png)

In general, in widgets folder you will put the reusable classes or files. Utils folder contains things like special widgets like styles, colors and things like that.

### BLoC in Presentation Layer

bloc folder is the most important one. It contains your state, event and bloc. They are at the heart of the state management. 

### Views in Presentation Layer
And views folder actual screen which the users see. And the classes in this folder connects and contains every other classes in the presentation layer.

Ultimately, views file would contain bloc and bloc itself would contain event and state. The bloc would reach out to domain layer first when an user interaction happens.
![Presentation Layer Structure](assets/12.png)

The above picture should give you how the views inside presentation layer works. Even though it's one way from the arrow, but it should also work the opposite if you receive data from outside world.

In general the bloc in presentation layer would trigger the usecases of domain layer. And then the usecases would trigger the repositories in domain layer to data layer repository. Remember data layer's repositories are the implementation of the domain layer repositories(they are just abstract classes).

And then data layer's repositories would find the data source and get data back to the usecases of domain layer.

Then domain layer would feed data back to the bloc. And bloc will show the data on the view. 
![Presentation Layer Structure](assets/13.png)

Let's take another look. This might help how you understand the basic flow. The below diagram shows how the basic flow starts from Presentation layer to the domain layer to the data layer. This is uni directional.

![Presentation Layer Structure](assets/14.png)

## Dependency injection
![Dependency Injection](assets/15.png)

Here we see how dependency injection also blends into clean architecture pattern. Here we injected from presentation layer to data layer and even to the external storage.

This starts with installing get_it package and then creating an instance of it. We call it sl() or service location. You may call it anything you like.

You should start with BLoC/Cubit/GetX at the top with registerFactory() method. Inside the registerFactory() method you should get your app logic, it means your state management mechanism.

As we initialize app logic(bloc/cubit/getx), we don't pass the dependencies directly, rather we pass the sl(), this service location instance sl() will find the related dependencies.


## Getting Started

To get started with this project:

1. Clone the repository to your local machine.
2. Open the project in your preferred Flutter IDE or editor.
3. Explore the project structure and familiarize yourself with the clean architecture pattern.
4. Use the provided sample code and tests as a guide for implementing your own features.
5. Refer to the documentation links provided for further learning resources on Flutter development and clean architecture.

## Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/): Official documentation for Flutter development.
- [Clean Architecture Video](https://www.youtube.com/watch?v=_E3EF1jPumM&t=1027s): Watch a video explanation of clean architecture principles.
