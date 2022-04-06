import 'package:currency_exchange/common/theme/appTheme.dart';
import 'package:currency_exchange/common/utils/Toasty.dart';
import 'package:currency_exchange/common/widgets/search_bar_widget.dart';
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
  TextEditingController fromSearchController = TextEditingController();
  TextEditingController toSearchController = TextEditingController();
  bool isStrechedFromDropDown = false;
  bool isStrechedToDropDown = false;
  final TextEditingController amountController =
      TextEditingController(text: "0.00");
  int from_id = 0;
  int to_id = 0;
  String label = "Select Currency";
  String toLabel = "Select Currency";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: clr.bgWhite,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: GestureDetector(
          onTap: (){
            setState(() {
              isStrechedFromDropDown=false;
              isStrechedToDropDown=false;

            });
          },
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
                  child: Icon(
                    Icons.history_outlined,
                    color: clr.appWhite,
                  ),
                ),
              ),
              Positioned(
                top: 30.w,
                left: 15.w,
                child: GestureDetector(
                  onTap: navigateToFavoriteScreen,
                  child: Icon(
                    Icons.favorite,
                    color: clr.appWhite,
                  ),
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
                  height: 550.w,
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
                          labelBuilder(label, true, fromSearchController),
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
                          labelBuilder(toLabel, false, toSearchController),
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
                                  initialData: "0.0000",
                                  stream: convertorListStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.data != null) {
                                      return Text(
                                        snapshot.data!.substring(
                                            0, snapshot.data!.length - 2),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: size.textLarge,
                                            fontWeight: FontWeight.w600),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: clr.appPrimary,
                                        ),
                                      );
                                    }
                                  }),
                              alignment: Alignment.centerRight,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 60),
                      GestureDetector(
                        onTap: () {
                          if (!Validator.isValidNumber(amountController.text)) {
                            Toasty.of(context)
                                .showError(message: "Number Invalid");
                          }

                          if (double.parse(amountController.text) <= 0) {
                            Toasty.of(context)
                                .showError(message: "Enter a valid number");
                          } else if (amountController.text.length > 16) {
                            Toasty.of(context)
                                .showError(message: "Enter upto 16 digits");
                          } else {
                            getConvertedAmount(
                                label.substring(0, 3),
                                toLabel.substring(0, 3),
                                amountController.text,
                                from_id,
                                to_id);
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
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            label = "Select Currency";
                            toLabel = "Select Currency";
                            amountController.text = "0";
                            getConvertedAmount("BDT", "USD", "0", 1, 2);
                            fromSearchController.clear();
                            toSearchController.clear();
                            isStrechedFromDropDown=false;
                            isStrechedToDropDown=false;
                          });
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
                              "CLEAR",
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
                      top: 240,
                      left: 110,
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
                                            amountController.text = "0.00";
                                            getConvertedAmount(
                                                "BDT", "USD", "0", 1, 2);
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
                              }
                                else if(data is EmptyState){
                                  return Column(

                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(data.icon,size: size.s42,),
                                      Text(data.message),
                                    ],
                                  );
                              }

                              else {
                                return Center(
                                    child: CircularProgressIndicator(
                                  color: clr.appPrimary,
                                ));
                              }
                            }),
                      ))
                  : const Offstage(),
              isStrechedToDropDown
                  ? Positioned(
                      top: 420,
                      right: 110,
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
                                      var content = data.data.currencyList
                                          .where((element) =>
                                              element.currencyShort !=
                                              label.substring(0, 3))
                                          .toList();
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            toLabel =
                                                '${content[index].currencyShort}-${content[index].currencyLong}';

                                            to_id = content[index].id;
                                            isStrechedToDropDown =
                                                !isStrechedToDropDown;

                                            getConvertedAmount(
                                                "BDT", "USD", "0", 1, 2);
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
                              }

                              else if(data is EmptyState){
                                return Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(data.icon,size: size.s42,),
                                    Text(data.message),
                                  ],
                                );
                              }
                              else {
                                return Center(
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
      ),
    );
  }

  Widget labelBuilder(
      String label, bool flag, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(top: 30.w, left: 20.w, right: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 280.w,
                height: 36.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.s16),
                  color: Colors.grey.withOpacity(0.3),
                ),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 20, top: 8),
                      isDense: true,
                      hintText: "Search Currency",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: size.textSmall,
                      )),
                ),
              ),
              SizedBox(
                width: size.s16,
              ),
        controller.text.isNotEmpty?GestureDetector(
                onTap: () {
                  setState(() {
                    if (flag == true) {
                      isStrechedFromDropDown = !isStrechedFromDropDown;
                    } else {
                      isStrechedToDropDown = !isStrechedToDropDown;
                    }

                    getCurrencyList(controller.text);
                  });
                },
                child: const Icon(Icons.search),
              ): const Icon(Icons.search),
            ],
          ),
          Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: size.textSmall),
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

// GestureDetector(
// onTap: () {
// setState(() {
// if (flag == true) {
// isStrechedFromDropDown = !isStrechedFromDropDown;
// } else {
// isStrechedToDropDown = !isStrechedToDropDown;
// }
//
// getCurrencyList();
// });
// },
// child: Container(
// height: 25,
// width: 24,
// decoration: BoxDecoration(
// color: Colors.grey.withOpacity(0.3),
// shape: BoxShape.circle,
// ),
// child: flag
// ? isStrechedFromDropDown
// ? const Icon(Icons.arrow_drop_up)
// : const Icon(Icons.arrow_drop_down)
// : isStrechedToDropDown
// ? const Icon(Icons.arrow_drop_up)
// : const Icon(Icons.arrow_drop_down),
// ),
// ),
