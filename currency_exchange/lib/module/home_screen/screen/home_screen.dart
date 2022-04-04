import 'package:currency_exchange/common/theme/appTheme.dart';
import 'package:currency_exchange/common/utils/Toasty.dart';
import 'package:currency_exchange/module/home_screen/service/home_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app_route.dart';
import '../../../common/utils/validator.dart';
import '../../../common/widgets/CurrencySelectDropDownList.dart';
import '../../../common/widgets/textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AppTheme, HomeScreenService {
  bool isStrechedFromDropDown = false;
  bool isStrechedToDropDown = false;
  final TextEditingController amountController = TextEditingController(text: "0");
  int from_id =0;
  int to_id=0;
  late double amount_to;
  String label = "Select Currency";
  String toLabel = "Select Currency";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: clr.bgWhite,
      body: SingleChildScrollView(
        child: Stack(
          children: [

            Container(
              height: 380.0.w,
              decoration: BoxDecoration(
                color: clr.appPrimary,
                boxShadow: const [BoxShadow(blurRadius: 10.0)],
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 100.0)),
              ),
            ),
            Positioned(
              top: 30,
              right: 10,
              child: GestureDetector(
                onTap: navigateToRecentScreen,
                child: Icon(Icons.history_outlined,color: clr.appWhite,),
              ),
            ),
            Positioned(
              top: 30.w,
              left: 15.w,
              child: GestureDetector(
                onTap: navigateToFavoriteScreen,
                child: Icon(Icons.favorite,color: clr.appWhite,),
              ),
            ),
            Positioned(
              top: 70.w,
              left: 20.w,
              child: Text(
                "Welcome !",
                style: TextStyle(
                    color: clr.appWhite,
                    fontSize: size.textXLarge,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Positioned(
              top: 100.w,
              left: 20.w,
              child: Text(
                "Convert currency at current rate.",
                style: TextStyle(
                    color: clr.appWhite,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 150.w, bottom: 80.w),
                height: 490.w,
                width: 370.w,
                decoration: BoxDecoration(
                    color: clr.appWhite,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 8.0, // shadow direction: bottom right
                      )
                    ]),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelBuilder(label, true),
                        const SizedBox(
                          height: 15,
                        ),
                         TextFieldWidget(
                          hintText: '0.0',
                          controller: amountController,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        labelBuilder(toLabel, false),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 65,
                          margin: EdgeInsets.symmetric(
                              horizontal: size.s16, vertical: size.s4),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.s16, vertical: size.s4),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            border: Border.all(
                              color: Colors.transparent,
                              width: 8.w,
                            ),
                            borderRadius: BorderRadius.circular(size.s12),
                          ),
                          child: Align(
                            child: StreamBuilder<String>(
                              initialData: "0.0",
                            stream: convertorListStream,
                            builder: (context, snapshot) {
                              if(snapshot.data!=null){
                                return Text(snapshot.data!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.textLarge,
                                    fontWeight: FontWeight.w600
                                ),);
                              }
                              else{
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: clr.appPrimary,
                                  ),
                                );
                              }
                            }
                          ),alignment: Alignment.centerRight,),
                        )
                      ],
                    ),
                    const SizedBox(height: 60),
                    GestureDetector(
                      onTap: (){
                        if(!Validator.isValidNumber(amountController.text)){
                          Toasty.of(context).showError(message: "Number Invalid");
                        }

                        if(double.parse(amountController.text)<=0){
                          Toasty.of(context).showError(message: "Enter a valid number");
                        }
                        else if(amountController.text.length>16){
                        Toasty.of(context).showError(message: "Enter upto 16 digits");

                        }
                        else {
                          getConvertedAmount(label.substring(0,3), toLabel.substring(0,3), amountController.text,from_id,to_id);

                        }

                      },
                      child: Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          color: clr.appPrimary,
                          borderRadius: BorderRadius.circular(12.w),
                        ),
                        child: Center(
                          child: Text(
                            "CONVERT",
                            style: TextStyle(
                                color: clr.appWhite,
                                fontSize: size.textMedium,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            isStrechedFromDropDown
                ? Positioned(
                    top: 220,
                    right: 20,
                    child: Container(
                      height: 300,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 8.0, // shadow direction: bottom right
                            )
                          ]),
                      child: StreamBuilder<PageState>(
                          initialData: LoadingState(),
                          stream: currencyListStream,
                          builder: (context, snapshot) {
                            var data = snapshot.data;
                            if (data is DataLoadedState) {
                              return ListView.builder(
                                  itemCount: data.data.currencyList.length,
                                  itemBuilder: (context, index) {
                                    var content = data.data.currencyList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          label =
                                              '${content.currencyShort}-${content.currencyLong}';
                                          from_id = content.id;
                                          isStrechedFromDropDown =
                                              !isStrechedFromDropDown;
                                        });
                                      },
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              '${content.currencyShort}-${content.currencyLong}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return  Center(
                                  child: CircularProgressIndicator(
                                    color: clr.appPrimary,
                                  ));
                            }
                          }),
                    ))
                : const Offstage(),
            isStrechedToDropDown
                ? Positioned(
                    top: 380,
                    right: 20,
                    child: Container(
                      height: 300,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 8.0, // shadow direction: bottom right
                            )
                          ]),
                      child: StreamBuilder<PageState>(
                          initialData: LoadingState(),
                          stream: currencyListStream,
                          builder: (context, snapshot) {
                            var data = snapshot.data;
                            if (data is DataLoadedState) {
                              return ListView.builder(
                                  itemCount: data.data.currencyList.length-1,
                                  itemBuilder: (context, index) {
                                    var content = data.data.currencyList.where((element) => element.currencyShort!=label.substring(0,3)).toList();
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          toLabel =
                                              '${content[index].currencyShort}-${content[index].currencyLong}';


                                          to_id =content[index].id;
                                          isStrechedToDropDown =
                                              !isStrechedToDropDown;
                                        });
                                      },
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              '${content[index].currencyShort}-${content[index].currencyLong}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return  Center(
                                  child: CircularProgressIndicator(
                                    color: clr.appPrimary,
                                  ));
                            }
                          }),
                    ))
                : const Offstage(),
          ],
        ),
      ),
    );
  }

  Widget labelBuilder(String label, bool flag) {
    return Padding(
      padding: EdgeInsets.only(top: 30.w, left: 20.w, right: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: size.textSmall),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (flag == true) {
                  isStrechedFromDropDown = !isStrechedFromDropDown;
                } else {
                  isStrechedToDropDown = !isStrechedToDropDown;
                }

                getCurrencyList();
              });
            },
            child: Container(
              height: 25,
              width: 24,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: flag
                  ? isStrechedFromDropDown
                      ? Icon(Icons.arrow_drop_up)
                      : Icon(Icons.arrow_drop_down)
                  : isStrechedToDropDown
                      ? Icon(Icons.arrow_drop_up)
                      : Icon(Icons.arrow_drop_down),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void navigateToFavoriteScreen() {
    Navigator.of(context).pushNamed(AppRoute.favortiesScreen);
  }

  @override
  void navigateToRecentScreen() {
    Navigator.of(context).pushNamed(AppRoute.recentScreen);
  }
}
