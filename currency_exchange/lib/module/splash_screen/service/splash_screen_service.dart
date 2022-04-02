import 'package:flutter/cupertino.dart';

abstract class _ViewModel{
  void navigateToHomeScreen();
}

mixin SplashScreenService <T extends StatefulWidget> on State<T> implements _ViewModel{
  late _ViewModel _view;

  @override
  void initState() {
    _view = this;
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _fetchUserSession();
    });
  }

  void _fetchUserSession() async{
    ///Delayed for 2 seconds
    await Future.delayed(const Duration(milliseconds:2000));
    _view.navigateToHomeScreen();

  }

}

