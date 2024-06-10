import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/textstyles.dart';

Widget buildAdminOption(Icon optIcon,String text,Size size,Function() onTap) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
    ),
    padding: EdgeInsets.only(left: 10, right: 0, top: 3, bottom: 3),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color(0xFF2F2E41),),
            child: optIcon),
        SizedBox(
          width: size.width * 0.03,
        ),
        Expanded(
          child: Text(
            text,
            style: p_4_wOpacity(size),
          ),
        ),

        IconButton(
          onPressed: onTap,
          icon: Icon(
            CupertinoIcons.right_chevron,
            size: size.width * 0.06,
            color: Color(0xFFF5A811),
          ),
        ),
      ],
    ),
  );
}


// GestureDetector(
//   child: Icon(
//     CupertinoIcons.chevron_right,
//     size: size.width * 0.06,
//     color: Color(0xFFF5A811),
//   ),
//   onTap: onTap,
// ),
