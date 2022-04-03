import 'package:flutter/material.dart';

class CurrencyDropDownList extends StatefulWidget {
  const CurrencyDropDownList({Key? key}) : super(key: key);

  @override
  State<CurrencyDropDownList> createState() => _CurrencyDropDownListState();
}

class _CurrencyDropDownListState extends State<CurrencyDropDownList> {

  bool isStrechedDropDown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,),
      height: 40,
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1
        ),
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25)
      ),
      child: Row(

        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text("Title"),
            ),
          ),
          GestureDetector(
            onTap: (){
            },
            child: !isStrechedDropDown?const Icon(Icons.keyboard_arrow_down):const Icon(Icons.keyboard_arrow_up),
          ),

        ],
      ),
    );
  }


}

