import 'package:currency_exchange/module/home_screen/screen/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(412, 868),
        builder:()=> MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          navigatorKey: AppRoute.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: "CV Maker",
          onGenerateRoute: RouteGenerator.generate,
          // onGenerateRoute: RouteGenerator.generate,
        )
    );
  }
}

