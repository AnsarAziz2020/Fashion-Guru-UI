import 'package:flutter/material.dart';

Color primaryColor = Color(0xFFF5A811);
Color textColor = Color(0xFF3D3D3D);

TextStyle mainHeading(Size size) => TextStyle(
    color: Color(0xFF3D3D3D),
    fontSize: size.width * 0.08,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold);
// This is a text style
TextStyle p_6(Size size) => TextStyle(
      color: Colors.grey,
      fontSize: size.width * 0.04,
      fontFamily: 'Poppins',
    );

TextStyle p_4_wOpacity(Size size) => TextStyle(
      color: Color(0xFF3D3D3D).withOpacity(0.75),
      fontSize: size.width * 0.04,
      fontFamily: 'Poppins',
    );

TextStyle small_wOpacity(Size size) => TextStyle(
      color: Color(0xFF3D3D3D).withOpacity(0.75),
      fontSize: size.width * 0.02,
      fontFamily: 'Poppins',
    );

TextStyle p_4(Size size) => TextStyle(
    fontSize: size.width * 0.04,
    fontWeight: FontWeight.w600,
    color: Color(0xFF3D3D3D),
    overflow: TextOverflow.ellipsis);

TextStyle screenHeading(Size size) => TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: size.width * 0.06,
      color: Color(0xFF3D3D3D),
      // fontFamily: 'Poppins'
    );

TextStyle profileCardTextStyle(Size size) => TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: size.width * 0.03,
      overflow: TextOverflow.ellipsis,
      color: Color(0xFF2F2E41),
    );

TextStyle b_style(Size size) => TextStyle(
      color: Colors.white,
      fontSize: size.width * 0.04,
      fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',
    );

TextStyle detailsStyle(size) => TextStyle(
      // color: Colors.white,
      fontSize: size.width * 0.045,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    );

TextStyle subHeading(size) => TextStyle(
      color: Color(0xFF3D3D3D),
      fontSize: size.width * 0.06,
      fontWeight: FontWeight.w700,
      fontFamily: 'Poppins',
    );

dynamic customMediaQuery = (context) {
  return MediaQuery.of(context).size;
};

TextStyle profileNameStyle(Size size) => TextStyle(
    color: Color(0xFF3D3D3D),
    fontSize: size.width * 0.06,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    overflow: TextOverflow.ellipsis);

TextStyle profileEmailStyle(Size size) => TextStyle(
    color: Color(0xFF3D3D3D),
    fontSize: size.width * 0.035,
    fontFamily: 'Poppins',
    overflow: TextOverflow.ellipsis);
