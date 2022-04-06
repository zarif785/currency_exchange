import 'package:currency_exchange/common/theme/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  const SearchBar({Key? key, required this.controller}) : super(key: key);


  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with AppTheme{


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 280.w,
          height: 36.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.s16),
            color: Colors.grey.withOpacity(0.3),
          ),
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(left: 20,top: 8),
                isDense: true,
                hintText: "Search Currency",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: size.textSmall,
                )
            ),
          ),

        ),
        SizedBox(width: size.s16,),
        GestureDetector(
          onTap: (){},
          child: const Icon(Icons.search),
        )
      ],
    );
  }
}


