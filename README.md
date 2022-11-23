# Food Delivery App

<p align="center">
  <a href="https://flutter.io/">
    <img src="https://storage.googleapis.com/cms-storage-bucket/ec64036b4eacc9f3fd73.svg" alt="Logo" width=320 height=72>
  </a>

  <!-- <h3 align="center">Flutter Boilerplate Project</h3> -->

  <p align="center">
    Fork this project then start you project with a lot of stuck prepare
    <br>
    Base project made with much  :heart: . Contains CRUD, patterns, and much more!
    <br>
    <br>
    <a href="https://github.com/viet-t-nguyen/food_delivery_demo/issues/new">Report bug</a>
    ·
    <a href="https://github.com/viet-t-nguyen/food_delivery_demo/issues/new">Request feature</a>
  </p>
</p>

## Table of contents

- [How to Use](#how-to-use)
- [Code Conventions](#code-conventions)
- [Dependencies](#dependencies)
- [Code structure](#code-structure)

## How to Use 

1. Download or clone this repo by using the link below:
  ```
  https://github.com/viet-t-nguyen/food_delivery_demo.git
  ```
2. Go to project root and execute the following command in console to get the required dependencies: 

  ```
  flutter pub get 
  ```

# Code Conventions
- [analysis_options.yaml](analysis_options.yaml)
- [About code analytics flutter](https://medium.com/flutter-community/effective-code-in-your-flutter-app-from-the-beginning-e597444e1273)

  In Flutter, Modularization will be done at a file level. While building widgets, we have to make sure they stay independent and re-usable as maximum. Ideally, widgets should be easily extractable into an independent project.


# Dependencies
- [equatable](https://pub.dev/packages/equatable): Simplify Equality Comparisons.

## Helper

- [go_router](https://pub.dev/packages/go_router): Manager router

- [get_it](https://pub.dev/packages/get_it): This is a simple Service Locator


## State Management
> State Management is still the hottest topic in Flutter Community. There are tons of choices available and it’s super intimidating for a beginner to choose one. Also, all of them have their pros and cons. So, what’s the best approach
- [flutter_bloc](https://pub.dev/packages/flutter_bloc): Widgets that make it easy to integrate blocs and cubits into Flutter. [Learn more](https://bloclibrary.dev/#/) 

- [More about state management](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options)

## Flutter Gen
- [flutter_gen](https://pub.dev/packages/flutter_gen): The Flutter code generator for your assets, fonts, colors, … — Get rid of all String-based APIs.

# Code structure
Here is the core folder structure which flutter provides.
```
flutter-app/
|- android
|- ios
|- lib
|- modules
|- test
```
Here is the folder structure we have been using in this project

```
lib/
|- base/
|- config/
  |- routes/
  |- themes/
|- constants/
|- gen/
|- modules/
  |- cubit/
  |- home/
    |- cubit/
    |- widgets/
    |- home_screen.dart
  |- product/
    |- cubit/
    |- widgets/
    |- product_screen.dart
|- repositories/
|- utils/
  |- helpers/
  |- services/
  |- ui/
|- widgets/
  |- buttons/
  |- chips/
  |- dialog/
|- app.dart
|- locator.dart
|- main.dart
```

## Github Action
- Github Action only deploys to google play console when pull request has been merged.
- Version of file release will auto increase when github action deploy.