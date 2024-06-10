import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildCategoryCard(String cardText,Color textColor,Color cardColor,String imageLink,Size size,Function() onTap){
  return GestureDetector(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: cardColor,),
        margin: EdgeInsets.only(right: 20),
        // color: cardColor,
        width: size.width * 0.16,
        height: size.width * 0.18,
        padding: EdgeInsets.only(
          top: 8,bottom: 3
        ),
        child: Column(
          children: [
            Image.network(
              imageLink,
              width: size.width * 0.08,
            ),
            SizedBox(
              height: size.height * 0.005,
            ),
            Text(
              cardText,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: size.width * 0.03,
              overflow: TextOverflow.ellipsis,
              color: textColor),
            ),
          ],
        ),
      ),
    onTap: onTap,
  );
}