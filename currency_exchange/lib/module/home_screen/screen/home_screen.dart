import 'package:currency_exchange/common/theme/appTheme.dart';
import 'package:currency_exchange/module/home_screen/service/home_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AppTheme,HomeScreenService{




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: clr.bgWhite,
      body: Stack(
        children: [
          Container(
            height:280.0.w,
            decoration:  BoxDecoration(
              color: clr.appPrimary,
              boxShadow: [
                 BoxShadow(blurRadius: 10.0)
              ],
              borderRadius:  BorderRadius.vertical(
                  bottom:  Radius.elliptical(
                      MediaQuery.of(context).size.width, 100.0)),
            ),
          ),
           Positioned(
             top: 70.w,
             left: 20.w,
             child: Text("Welcome !",style: TextStyle(
              color: clr.appWhite,
              fontSize: size.textXLarge,
               fontWeight: FontWeight.w700
          ),),
           ),

          Positioned(
            top: 100.w,
            left: 20.w,
            child: Text("Convert currency at current rate.",style: TextStyle(
                color: clr.appWhite,
                fontSize: size.textSmall,
                fontWeight: FontWeight.w300
            ),),
          ),

          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 150.w,bottom: 80.w) ,
              height:800.w,
              width: 370.w,

              decoration: BoxDecoration(
                  color: clr.appWhite,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 8.0, // shadow direction: bottom right
                )]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30.w,left: 20.w,right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("BDT-Bangladeshi Taka",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: size.textSmall
                            ),
                        ),
                        GestureDetector(
                          child: Container(
                            height: 25,
                            width: 24,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(),
                              child: Icon(Icons.arrow_drop_down),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  const TextFieldWidget(hintText: '0.0',)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
