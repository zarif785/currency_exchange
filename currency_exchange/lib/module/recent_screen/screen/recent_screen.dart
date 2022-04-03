import 'package:currency_exchange/common/theme/appTheme.dart';
import 'package:flutter/material.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({Key? key}) : super(key: key);

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> with AppTheme{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: size.s24),
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              "RECENTS",
              style: TextStyle(
                  color: clr.appPrimary,
                  fontSize: size.textXLarge,
                  fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
