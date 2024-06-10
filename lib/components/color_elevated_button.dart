import 'package:fashion_guru/constants/textstyles.dart';
import 'package:flutter/material.dart';

Widget buildColorElevatedButton(String buttonText,Size size,Color color, Function() onPressed){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        textStyle: b_style(size),
      backgroundColor: color,

      // primary: Color(0xFFF5A811),
      // onPrimary: Colors.white,

    ),
    onPressed: onPressed,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Text(buttonText,style: TextStyle(color: Colors.white),),
    ),
  );
}