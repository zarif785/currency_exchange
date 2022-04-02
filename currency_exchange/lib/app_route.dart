
import 'package:flutter/material.dart';
import 'module/home_screen/screen/home_screen.dart';
import 'module/splash_screen/screen/splash_screen.dart';

class AppRoute{
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static const String splashScreen = 'splashScreen';
  static const String homeScreen = 'homeScreen';

}

mixin RouteGenerator{

  static Route<dynamic> generate(RouteSettings settings){
    return FadeInOutRouteBuilder(builder: (context){
      switch(settings.name){
        case AppRoute.homeScreen : return const HomeScreen();
        default:
          return  const SplashScreen();
          // return const SplashScreen();
      }
    });
  }
}

class FadeInOutRouteBuilder extends PageRouteBuilder {
  final WidgetBuilder builder;
  FadeInOutRouteBuilder({required this.builder}) : super(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return builder(context);
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return  FadeTransition(
          opacity: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: const Interval(
                0.50,
                1.00,
                curve: Curves.linear,
              ),
            ),
          ),
          child: child,
        );
      }
  );
}