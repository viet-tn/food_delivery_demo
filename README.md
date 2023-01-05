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
    <a href="https://github.com/finn-go-nguyen/food_delivery_demo/issues/new">Report bug</a>
    ·
    <a href="https://github.com/finn-go-nguyen/food_delivery_demo/issues/new">Request feature</a>
  </p>
</p>

## Table of contents

- [How to Use](#how-to-use)
- [Code Conventions](#code-conventions)
- [Dependencies](#dependencies)
- [Code structure](#code-structure)

## How to Use 
**Step 1:**

Download or clone this repo by using the link below:
```
https://github.com/finn-go-nguyen/food_delivery_demo.git
```
**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```
**Step 3:**

This project uses inject library that works with code generation, execute the following command to generate files:
```
flutter pub run build_runner build --delete-conflicting-outputs
```
or watch command in order to keep the source code synced automatically:

```
flutter pub run build_runner watch
```

# Code Conventions
- [analysis_options.yaml](analysis_options.yaml)
- [About code analytics flutter](https://medium.com/flutter-community/effective-code-in-your-flutter-app-from-the-beginning-e597444e1273)

  In Flutter, Modularization will be done at a file level. While building widgets, we have to make sure they stay independent and re-usable as maximum. Ideally, widgets should be easily extractable into an independent project.


# Dependencies


## State Management
> State Management is still the hottest topic in Flutter Community. There are tons of choices available and it’s super intimidating for a beginner to choose one. Also, all of them have their pros and cons. So, what’s the best approach
- [flutter_bloc](https://pub.dev/packages/flutter_bloc): Widgets that make it easy to integrate blocs and cubits into Flutter. [Learn more](https://bloclibrary.dev/#/) 
- [More about state management](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options)

## Routing

- [go_router](https://pub.dev/packages/go_router)

## Utilities

- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) generate splash screen
- [google_fonts](https://pub.dev/packages/google_fonts)
- [formz](https://pub.dev/packages/formz): form validation
- [image_picker](https://pub.dev/packages/image_picker)
- [cached_network_image](https://pub.dev/packages/cached_network_image)
- [geolocator](https://pub.dev/packages/geolocator) location services
- [dart_geohash](https://pub.dev/packages/dart_geohash) calculate geohash from latitude and longitude
- [http](https://pub.dev/packages/http) HTTP request handler
- [url_launcher](https://pub.dev/packages/url_launcher)
- [android_intent_plus](https://pub.dev/packages/android_intent_plus)
- [intl](https://pub.dev/packages/intl) date, number formatting
- [uuid](https://pub.dev/packages/uuid) id generator
- [freezed](https://pub.dev/packages/freezed) write model class with less boiler code
- [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) push notification
- [shared_preferences](https://pub.dev/packages/shared_preferences) persistent storage
- [equatable](https://pub.dev/packages/equatable) simplify equality comparisons.
- [get_it](https://pub.dev/packages/get_it) service locator

- [flutter_rating_bar](https://pub.dev/packages/flutter_rating_bar)
- [carousel_slider](https://pub.dev/packages/carousel_slider)
- [smooth_page_indicator](https://pub.dev/packages/smooth_page_indicator)
- [awesome_snackbar_content](https://pub.dev/packages/awesome_snackbar_content)
- [lottie](https://pub.dev/packages/lottie)
- [shimmer](https://pub.dev/packages/shimmer) Loading effect
- [flutter_svg](https://pub.dev/packages/flutter_svg)

## Flutter Gen
- [flutter_gen](https://pub.dev/packages/flutter_gen): The Flutter code generator for your assets, fonts, colors, … — Get rid of all String-based APIs.

## Third-party APIs
### Algolia Search
- [algolia_helper_flutter](https://pub.dev/packages/algolia_helper_flutter)

## Firebase
- [firebase_core](https://pub.dev/packages/firebase_core)

- [firebase_auth](https://pub.dev/packages/firebase_auth)

- [cloud_firestore](https://pub.dev/packages/cloud_firestore)

- [google_sign_in](https://pub.dev/packages/google_sign_in)

- [flutter_facebook_auth](https://pub.dev/packages/flutter_facebook_auth)

- [firebase_app_check](https://pub.dev/packages/firebase_app_check)

- [firebase_storage](https://pub.dev/packages/firebase_storage)

- [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics)

- [firebase_messaging](https://pub.dev/packages/firebase_messaging)

## Google Maps

- [google_maps_flutter](https://pub.dev/packages/google_maps_flutter)
- [flutter_polyline_points](https://pub.dev/packages/flutter_polyline_points)

## Stripe Payment

- [flutter_stripe](https://pub.dev/packages/flutter_stripe)



# Code structure
Here is the core folder structure which flutter provides.
```
flutter-app/
|- android
|- assets
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
  |- cubits/
  |- home/
    |- cubit/
    |- widgets/
    |- home_screen.dart
  |- product/
  |- cart/
  |- chat/
  |- checkout/
  |- food/
  |- forgot_password/
  |- login/
  |- notification/
  |- onboarding/
  |- order/
  |- profile/ 
  |- rating/ 
  |- restaurant/ 
  |- search/ 
  |- sign_up/ 
  |- tracking/ 
  |- voucher/ 
|- repositories/
  |- food/
    |- food_model.dart/
    |- food_repository.dart/
    |- food_repository_impl.dart/
  |- auth/
  |- cart/
  |- chat/
  |- cloud_storage/
  |- favorite/
  |- maps/
  |- notification/
  |- payment/
  |- rating/
  |- restaurant/
  |- search/
  |- user/
  |- domain_manager.dart
|- utils/
  |- converters/
  |- helpers/
  |- page_arguments/
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