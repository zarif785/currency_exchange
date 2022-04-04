import 'package:currency_exchange/common/theme/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:currency_exchange/module/recent_screen/service/recent_screen_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({Key? key}) : super(key: key);

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> with AppTheme,RecentScreenService{


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
                "RECENTS",
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
              stream: recentListStream,
              builder: (context, snapshot) {
                var state = snapshot.data;
                if(state is DataLoadedState){
                  return Column(
                    children: state.data.recents.map((e){
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const Text("From: "),
                                  const SizedBox(height: 8,),
                                  Text(e.currencyFrom),
                                  const SizedBox(height: 8,),
                                  Text(e.amountFrom.toString())
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const Text("To: "),
                                  const SizedBox(height: 8,),
                                  Text(e.currencyTo),
                                  const SizedBox(height: 8,),
                                  Text(e.amountTo.toString())
                                ],
                              ),
                            ),
                          ],
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
