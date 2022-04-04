import 'package:flutter/material.dart';

import '../../../app_route.dart';
import '../../../common/theme/appTheme.dart';
import '../../../common/utils/appAssets.dart';
import '../service/splash_screen_service.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SplashScreenService,AppTheme{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.appPrimary,
      body: Center(
          child: Image.asset(
              AppAssets.brandLogo,
              color: clr.appWhite,
              scale: 3.5,
          )
      ),
    );
  }

  @override
  void navigateToTabScreen() {
    Navigator.of(context).pushNamed(AppRoute.homeScreen);
  }
}
