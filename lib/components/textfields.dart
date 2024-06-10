import 'package:fashion_guru/constants/textstyles.dart';
import 'package:flutter/material.dart';

Widget buildTextField(String hintText, Icon prefixIcon, IconButton suffixIcon,
    TextEditingController controller, bool isPassField,String? validation(value),Size size) {
  return
    TextFormField(
    controller: controller,
    obscureText: isPassField,
    validator: validation,
    decoration: InputDecoration(
      prefixIcon: prefixIcon, suffixIcon: suffixIcon,
      // Icon(
      //   Icons.person,
      //   color: Color(0xFFF5A811),
      //   size: 25,
      // ),
      hintText: hintText,
      // "Username",
      hintStyle: p_6(size),
    ),
    style: TextStyle(fontSize: 18),
    textInputAction: isPassField ? TextInputAction.done : TextInputAction.next,
  );
}
