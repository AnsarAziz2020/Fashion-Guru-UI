import 'package:fashion_guru/constants/textstyles.dart';
import 'package:flutter/material.dart';

Widget buildSearchField(
    String hintText,
    IconButton suffixIcon,
    TextEditingController controller,
    bool isPassField,
    String? validation(value),
    Size size) {
  return TextFormField(
    controller: controller,
    obscureText: isPassField,
    validator: validation,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.only(left: 20, top: 12,right: 15,bottom: 12),
      enabled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.transparent),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2,color: Color(0xFFF5A811),),
        borderRadius: BorderRadius.circular(8),
      ),


      suffixIcon: suffixIcon,
      // Icon(
      //   Icons.person,
      //   color: Color(0xFFF5A811),
      //   size: 25,
      // ),
      fillColor: Colors.grey[150],
      filled: true,
      hintText: hintText,
      // "Username",
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: size.width*0.04,
        fontFamily: 'Poppins',
      ),
    ),
    style: TextStyle(fontSize: size.width*0.04),
    textInputAction: isPassField ? TextInputAction.done : TextInputAction.next,
  );
}
