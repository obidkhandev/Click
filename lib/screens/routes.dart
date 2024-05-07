import 'package:click/data/models/user_model.dart';
import 'package:click/screens/biometric/touch_id.dart';
import 'package:click/screens/local_auth/confirm_pin.dart';
import 'package:click/screens/local_auth/set_password.dart';
import 'package:click/screens/screens/auth/auth_screen.dart';
import 'package:click/screens/screens/auth/login.dart';
import 'package:click/screens/screens/no_internet/no_internet_screen.dart';
import 'package:click/screens/screens/on_boarding/on_boarding_screen.dart';
import 'package:click/screens/screens/tab/profile/update_screen.dart';
import 'package:flutter/material.dart';
import 'screens/payment/payment_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/tab/tab_screen.dart';
import 'screens/transfer/transfer_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return navigate(const SplashScreen());

      case RouteNames.tabRoute:
        return navigate(const TabScreen());

      // case RouteNames.noInternetRoute:
      //   return navigate(NoInternetScreen(
      //       onInternetComeBack: settings.arguments as VoidCallback));

      case RouteNames.transferRoute:
        return navigate(const TransferScreen());
      case RouteNames.loginScreen:
        return navigate(const LoginScreen());
      case RouteNames.paymentRoute:
        return navigate(const PaymentScreen());
      case RouteNames.register:
        return navigate(const RegisterScreen());
      case RouteNames.onBoardingRoute:
        return navigate(const OnBoardingScreen());
      case RouteNames.touchIdRoute:
        return navigate(const TouchIdScreen());
      case RouteNames.confirmPinRoute:
        return navigate(
            ConfirmPinScreen(previousPin: settings.arguments as String));
      case RouteNames.setPinRoute:
        return navigate(SetPinScreen());
      case RouteNames.updateScreen:
        return navigate(
            UpdateUserScreen(userModel: settings.arguments as UserModel));

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

class RouteNames {
  static const String splashScreen = "/";
  static const String updateScreen = "/update_screen";
  static const String touchIdRoute = "/touch_id_route";
  static const String confirmPinRoute = "/confirm_pin_route";
  static const String setPinRoute = "/set_pin_route";

  static const String loginScreen = "/login";
  static const String tabRoute = "/tab_route";
  static const String register = "/auth_route";
  static const String noInternetRoute = "/no_internet_route";
  static const String paymentRoute = "/payment_route";
  static const String transferRoute = "/transfer_route";
  static const String onBoardingRoute = "/on_boarding_route";
}
