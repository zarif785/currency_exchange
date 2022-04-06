import 'package:currency_exchange/common/theme/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../service/favorites_screen_service.dart';

class FavortiesScreen extends StatefulWidget {
  const FavortiesScreen({Key? key}) : super(key: key);

  @override
  State<FavortiesScreen> createState() => _FavortiesScreenState();
}

class _FavortiesScreenState extends State<FavortiesScreen> with AppTheme,FavoriteScreenService {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: size.s24),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: clr.appPrimary,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(
                        size.s16),
                  )),

              child: Text(
                "POPULAR CONVERSIONS",
                style: TextStyle(
                    color: clr.appWhite,
                    fontSize: size.textXLarge,
                    fontWeight: FontWeight.w700),
              ),
            ),

            const SizedBox(
              height: 30,
            ),
            StreamBuilder<PageState>(
                initialData: LoadingState(),
                stream: popularListStream,
                builder: (context, snapshot) {
                  var state = snapshot.data;
                  if(state is DataLoadedState){
                    return Column(
                      children: state.data.popular.map((e){
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10.w,horizontal: 20.w),
                          height: 100.w,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: clr.appWhite,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 4.0, // shadow direction: bottom right
                                ),
                              ]),
                          child: Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                          e.currencyFrom,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: size.textLarge
                                          ),
                                      ),
                                      Icon(Icons.arrow_forward,size: size.s42,),
                                      Text(
                                        e.currencyTo,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: size.textLarge
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding:  const EdgeInsets.only(right: 20.0),
                                      child: Text('Number of Checks: ${e.count.toString()}'),
                                    ))
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                  else{
                    return Center(
                      child: CircularProgressIndicator(
                        color: clr.appPrimary,
                      ),
                    );

                  }
                }
            )

          ],
        ),
      ),
    );
  }
}
