import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'config/routes/coordinator.dart';
import 'config/themes/app_theme.dart';
import 'modules/cart/cubit/cart_cubit.dart';
import 'modules/chat/cubit/chat_cubit.dart';
import 'modules/cubits/app/app_cubit.dart';
import 'modules/cubits/favorite/favorite_cubit.dart';
import 'modules/food/cubit/food_cubit.dart';
import 'modules/home/cubit/home_cubit.dart';
import 'modules/home/screens/cubit/view_more_cubit.dart';
import 'modules/login/cubit/login_cubit.dart';
import 'modules/order/cubit/orders_cubit.dart';
import 'modules/search/cubit/search_cubit.dart';
import 'modules/signup/cubit/sign_up_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetIt.I<LoginCubit>(),
        ),
        BlocProvider(
          create: (_) => GetIt.I<SignUpCubit>(),
        ),
        BlocProvider(
          create: (_) => GetIt.I<AppCubit>(),
        ),
        BlocProvider(
          create: (_) => GetIt.I<SearchCubit>(),
        ),
        BlocProvider(
          create: (_) => GetIt.I<CartCubit>(),
        ),
        BlocProvider(
          create: (_) => GetIt.I<FavoriteCubit>(),
        ),
        BlocProvider(
          create: (_) => GetIt.I<HomeCubit>(),
        ),
        BlocProvider(
          create: (_) => GetIt.I<OrdersCubit>(),
        ),
        BlocProvider(
          create: (_) => GetIt.I<FoodCubit>(),
        ),
        BlocProvider(
          create: (_) => GetIt.I<ChatCubit>(),
        ),
        BlocProvider(
          create: (_) => GetIt.I<ViewMoreCubit>(),
        )
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: messengerKey,
        debugShowCheckedModeBanner: false,
        theme: appThemeData[AppTheme.light],
        title: 'Food Delivery',
        routerDelegate: appRouter.routerDelegate,
        routeInformationParser: appRouter.routeInformationParser,
        routeInformationProvider: appRouter.routeInformationProvider,
        // routeInformationProvider: appRouter.routeInfoProvider(),
      ),
    );
  }
}
