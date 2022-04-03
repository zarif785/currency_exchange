import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/appTheme.dart';


class TextFieldWidget extends StatefulWidget{
  final TextEditingController controller;
  final String hintText;
  final String initialValue;
  final ValueChanged<String>? onTextChanged;
  const TextFieldWidget({Key? key,required this.hintText, this.onTextChanged, this.initialValue="", required this.controller,}) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> with AppTheme {
  late final TextEditingController _controller = TextEditingController(text:widget.initialValue);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: size.s16,vertical: size.s4),
      padding: EdgeInsets.symmetric(horizontal: size.s16,vertical: size.s4),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        border: Border.all(
          color: Colors.transparent,
          width: 8.w,
        ),
        borderRadius: BorderRadius.circular(size.s12),
      ),
      child: TextField(
        enabled: true,
        textAlign: TextAlign.end,
        controller: widget.controller,
        keyboardType: TextInputType.number,
        maxLines: 1,
        minLines: 1,
        onChanged: widget.onTextChanged,
        style: TextStyle(
            color: Colors.black,
            fontSize: size.textLarge,
            fontWeight: FontWeight.w600
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            isDense: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: size.textSmall,
            )
        ),
      ),
    );
  }
}
