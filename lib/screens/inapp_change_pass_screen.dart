import 'package:fashion_guru/services/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/elevatedbutton.dart';
import '../components/textfields.dart';
import '../constants/textstyles.dart';
import '../controllers/users.dart';
import 'login_screen.dart';

const inactiveEyeColor = Colors.grey;
const activeEyeColor = Color(0xFFF5A811);

class InAppChangePassScreen extends StatefulWidget {
  const InAppChangePassScreen({super.key});

  @override
  State<InAppChangePassScreen> createState() => _InAppChangePassScreenState();
}

class _InAppChangePassScreenState extends State<InAppChangePassScreen> {

  TextEditingController oldPassController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool passwordEye = true;
  bool confirmPasswordEye = true;
  Color passEyeColor = inactiveEyeColor;
  Color confirmPassEyeColor = inactiveEyeColor;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.left_chevron,
            size: size.width * 0.065,
          ),
        ),
        title: Text(
          'Change Password',
          style: screenHeading(size),
        ),
        // actions: [
        //   Icon(
        //     CupertinoIcons.ellipsis_vertical,
        //     size: size.width * 0.065,
        //   ),
        // ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(

        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height*0.05,),
                Image.asset("images/changepass.png", width: 300,),
                SizedBox(
                  height: size.height*0.03,
                ),
                Text(
                  "Enter Password Details",
                  style: TextStyle(
                      color: Color(0xFF3D3D3D),
                      fontSize: size.width*0.06,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),

                // Text(
                //   errors+"",
                //   style: TextStyle(
                //       color: Colors.red,
                //       fontFamily: 'Poppins',
                //       fontWeight: FontWeight.bold),
                // ),
                buildTextField(
                  "Old Password",
                  Icon(
                    Icons.lock,
                    size: 25,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.visibility,
                      color: passEyeColor,
                      size: 25,
                    ),
                    onPressed: () {
                      if (passwordEye) {
                        setState(() {
                          passEyeColor = activeEyeColor;
                          passwordEye = false;
                        });
                      } else {
                        setState(() {
                          passEyeColor = inactiveEyeColor;
                          passwordEye = true;

                        });
                      }
                    },
                  ),
                  oldPassController,
                  passwordEye, (value) {
                  String _validator =
                  passwordValidator(value);
                  if (_validator != "") {
                    return _validator;
                  }
                },size,),
                SizedBox(height: size.height * 0.03),
                buildTextField(
                  "New Password",
                  Icon(
                    Icons.lock,
                    size: 25,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.visibility,
                      color: passEyeColor,
                      size: 25,
                    ),
                    onPressed: () {
                      if (passwordEye) {
                        setState(() {
                          passEyeColor = activeEyeColor;
                          passwordEye = false;
                        });
                      } else {
                        setState(() {
                          passEyeColor = inactiveEyeColor;
                          passwordEye = true;

                        });
                      }
                    },
                  ),
                  passwordController,
                  passwordEye, (value) {
                  String _validator =
                  passwordValidator(value);
                  if (_validator != "") {
                    return _validator;
                  }
                },size,),
                SizedBox(height: size.height * 0.03),
                buildTextField(
                  "Confirm Password",
                  Icon(
                    Icons.lock,
                    size: 25,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.visibility,
                      color: confirmPassEyeColor,
                      size: 25,
                    ),
                    onPressed: () {
                      if (confirmPasswordEye) {
                        setState(() {
                          confirmPassEyeColor = activeEyeColor;
                          confirmPasswordEye = false;
                        });
                      } else {
                        setState(() {
                          confirmPassEyeColor = inactiveEyeColor;
                          confirmPasswordEye = true;
                        });
                      }
                    },
                  ),
                  confirmPassController,
                  confirmPasswordEye, (value) {
                  if (passwordController.text !=
                      confirmPassController.text) {
                    return "Password doesn't match";
                  }
                },size,),

                SizedBox(height: size.height * 0.06),
                SizedBox(
                  width: size.width,

                  child: buildElevatedButton("Submit",size,(){}),
                ),
              ],
            ),
          ),
        ),),
    );
  }
}
