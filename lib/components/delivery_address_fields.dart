import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/textstyles.dart';

Widget buildDeliveryAddressField(String hintText,int minLines,int maxLines,Size size,TextEditingController controller,String? validation(value)){
  return TextFormField(
    minLines: minLines,
    maxLines: maxLines,
    controller: controller,
    validator: validation,
    style: TextStyle(fontSize: size.width * 0.04),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(12),
      hintText: hintText,
      enabled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Color(0xFFF5A811),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      // fillColor: Colors.grey[150],
      // filled: true,
      hintStyle: TextStyle(
        color: Colors.black.withOpacity(0.3),
        fontSize: size.width * 0.04,
        fontFamily: 'Poppins',
      ),
      // labelStyle: TextStyle(
      //   color: textColor.withOpacity(0.7),
      //   fontSize: size.width * 0.04,
      //   fontFamily: 'Poppins',
      //   fontWeight: FontWeight.w600,
      // ),
    ),
  );
}