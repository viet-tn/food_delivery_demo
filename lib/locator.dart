import 'package:dart_geohash/dart_geohash.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'config/secrets.dart';
import 'modules/cart/cubit/cart_cubit.dart';
import 'modules/chat/chat_detail/cubit/chat_detail_cubit.dart';
import 'modules/chat/cubit/chat_cubit.dart';
import 'modules/checkout/cubit/payment_cubit.dart';
import 'modules/cubits/app/app_cubit.dart';
import 'modules/cubits/favorite/favorite_cubit.dart';
import 'modules/food/cubit/food_cubit.dart';
import 'modules/forgot_password/cubit/forgot_password_cubit.dart';
import 'modules/home/cubit/home_cubit.dart';
import 'modules/home/screens/cubit/view_more_cubit.dart';
import 'modules/login/cubit/login_cubit.dart';
import 'modules/restaurant/cubit/restaurant_cubit.dart';
import 'modules/search/cubit/search_cubit.dart';
import 'modules/signup/cubit/sign_up_cubit.dart';
import 'modules/signup/screens/map_screen/cubit/map_screen_cubit.dart';
import 'repositories/domain_manager.dart';
import 'repositories/payment/payment_repostiory.dart';
import 'utils/services/shared_preferences.dart';

Future<void> initializeApp() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp();

  Stripe.publishableKey = Credentials.stripePublishableKey;

  await Stripe.instance.applySettings();

  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Set true to disable verification for testing
  await FirebaseAuth.instance
      .setSettings(appVerificationDisabledForTesting: true);

  // Remove '#' sign in url
  usePathUrlStrategy();

  await _locator();

  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
}

Future<void> _locator() async {
  GetIt.I.registerLazySingleton(() => http.Client());

  final sharedPreferences = await SharedPreferences.getInstance();
  GetIt.I.registerLazySingleton<FSharedPreferences>(
    () => FSharedPreferences(sharedPreferences),
  );

  GetIt.I.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );

  GetIt.I.registerSingleton<LoginCubit>(
    dispose: (cubit) => cubit.close(),
    LoginCubit(
      authRepository: DomainManager().authRepository,
      userRepository: DomainManager().userRepository,
      sharedPreferences: GetIt.I<FSharedPreferences>(),
    )..init(),
  );

  GetIt.I.registerLazySingleton<AppCubit>(
    dispose: (cubit) => cubit.close(),
    () => AppCubit(
      userRepository: DomainManager().userRepository,
      cloudStorage: DomainManager().cloudStorage,
      authRepository: DomainManager().authRepository,
    ),
  );

  GetIt.I.registerLazySingleton<SignUpCubit>(
    dispose: (cubit) => cubit.close(),
    () => SignUpCubit(
      authRepository: DomainManager().authRepository,
      userRepository: DomainManager().userRepository,
      cloudStorage: DomainManager().cloudStorage,
    ),
  );

  GetIt.I.registerFactory<HomeCubit>(
    () => HomeCubit(
      restaurantRepository: DomainManager().restaurantRepository,
      foodRepository: DomainManager().foodRepository,
    )..init(),
  );

  GetIt.I.registerFactory<FoodCubit>(
    () => FoodCubit(
      foodRepository: DomainManager().foodRepository,
    ),
  );

  GetIt.I.registerFactory<RestaurantCubit>(
    () => RestaurantCubit(
      foodRepository: DomainManager().foodRepository,
    ),
  );

  GetIt.I.registerFactory<CartCubit>(
    () => CartCubit(
      cartRepository: DomainManager().cartRepository,
      foodRepository: DomainManager().foodRepository,
    ),
  );

  GetIt.I.registerFactory<ChatCubit>(
    () => ChatCubit(
      chatRepository: DomainManager().chatRepository,
    )..init(GetIt.I<AppCubit>().state.user!.id),
  );
  GetIt.I.registerFactory<ChatDetailCubit>(
    () => ChatDetailCubit(
      chatRepository: DomainManager().chatRepository,
      messageRepository: DomainManager().messageRepository,
    ),
  );
  GetIt.I.registerFactory<SearchCubit>(
    () => SearchCubit(
      searchRepository: DomainManager().searchRepository,
    )..init(),
  );
  GetIt.I.registerFactory<MapScreenCubit>(
    () => MapScreenCubit(
      geocodingRepository: DomainManager().geocodingRepository,
      placesSearchRepository: DomainManager().placesSearchRepository,
    ),
  );
  GetIt.I.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(DomainManager().authRepository),
  );
  GetIt.I.registerFactory<ViewMoreCubit>(
    () => ViewMoreCubit(
      DomainManager().foodRepository,
      DomainManager().restaurantRepository,
    ),
  );

  GetIt.I.registerFactory<PaymentCubit>(
    () => PaymentCubit(),
  );

  GetIt.I.registerFactory<FavoriteCubit>(
    () => FavoriteCubit(
      uid: GetIt.I<AppCubit>().state.user!.id,
      favoriteListRepository: DomainManager().favoriteListRepository,
      foodRepository: DomainManager().foodRepository,
    )..fetchFavoriteList(),
  );

  // External services
  GetIt.I.registerLazySingleton<GeoHasher>(
    () => GeoHasher(),
  );

  // Payment repository
  GetIt.I.registerFactory<PaymentRepository>(
    () => PaymentRepository(GetIt.I<AppCubit>().state.user!.id),
  );
}
