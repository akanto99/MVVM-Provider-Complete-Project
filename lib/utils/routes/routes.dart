import 'package:flutter/material.dart';
import 'package:mvvm_provider_completeproject/utils/routes/routes_name.dart';
import 'package:mvvm_provider_completeproject/view/home/home.dart';
import 'package:mvvm_provider_completeproject/view/splash&login/login_view.dart';
import 'package:mvvm_provider_completeproject/view/splash&login/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginView());

        case RoutesName.homeView:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeView());


      default:
        return _errorRoute();

    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('No route defined'),
        ),
      );
    });
  }
}
