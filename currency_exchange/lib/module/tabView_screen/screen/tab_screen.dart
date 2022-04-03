import 'package:currency_exchange/module/home_screen/screen/home_screen.dart';
import 'package:currency_exchange/module/recent_screen/screen/recent_screen.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/customAnimatedBottomBar.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;
  final _inactiveColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:getBody(),
        bottomNavigationBar: _buildBottomBar()
    );
  }
  Widget getBody() {
    List<Widget> pages = [
      HomeScreen(),
      RecentScreen(),
     Container(),

    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  Widget _buildBottomBar(){
    return CustomAnimatedBottomBar(
      containerHeight: 60,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.monetization_on_outlined),
          title: Text('Converter'),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.history_outlined),
          title: Text('Recent'),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          title: Text(
            'Popular ',
          ),
          activeColor: Colors.pink,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),

      ],
    );
  }

}
