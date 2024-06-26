import 'package:click/bloc/auth/auth_bloc.dart';
import 'package:click/bloc/card_bloc/card_bloc.dart';
import 'package:click/bloc/connectivity/connectivity_bloc.dart';
import 'package:click/bloc/user_bloc/user_bloc.dart';
import 'package:click/data/repositories/auth_repository.dart';
import 'package:click/data/repositories/card_repository.dart';
import 'package:click/data/repositories/user_repository.dart';
import 'package:click/service/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/routes.dart';

class App extends StatelessWidget {
  App({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.localNotificationService.init(navigatorKey);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => UserRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          // BlocProvider(create: (_) => ConnectivityBloc()),
          BlocProvider(
              create: (context) =>
                  UserProfileBloc(context.read<UserRepository>())),
          BlocProvider(create: (context) => AuthBloc()),
          BlocProvider(
            create: (context) => UserCardsBloc(
              cardRepository: CardRepository(),
            ),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(430, 930),
          builder: (context, child) {
            ScreenUtil.init(context);
            return MaterialApp(
              theme: ThemeData(useMaterial3: false),
              debugShowCheckedModeBanner: false,
              initialRoute: RouteNames.splashScreen,
              navigatorKey: navigatorKey,
              onGenerateRoute: AppRoutes.generateRoute,
            );
          },
        ),
      ),
    );
  }
}
