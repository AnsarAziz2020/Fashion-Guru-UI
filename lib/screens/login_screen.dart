import 'dart:convert';
import 'dart:math';

import 'package:fashion_guru/components/elevatedbutton.dart';
import 'package:fashion_guru/components/textfields.dart';
import 'package:fashion_guru/constants/textstyles.dart';
import 'package:fashion_guru/controllers/session.dart';
import 'package:fashion_guru/controllers/users.dart';
import 'package:fashion_guru/screens/dashboard_screen.dart';
import 'package:fashion_guru/screens/forgetpass_screen.dart';
import 'package:fashion_guru/screens/dashboard_screen.dart';
import 'package:fashion_guru/screens/signup_screen.dart';
import 'package:fashion_guru/services/firebase_api.dart';
import 'package:fashion_guru/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fashion_guru/constants/textstyles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool passwordEye = true;
  String errorMsg="";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFFF8F8F8),
        body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.35,
                  child: Center(
                    child: Image.asset(
                      'images/logo.png',
                      width: 300,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  height: size.height * 0.65,
                  // width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(75),
                        topRight: Radius.circular(75),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          offset: Offset(0, -2),
                          spreadRadius: -20,
                        )
                      ]),
                  child: Center(
                      child: Form(
                    key: _formKey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.05),
                        Text(
                          "LOGIN",
                          style: mainHeading(size),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          "${errorMsg}",
                          style: TextStyle(
                            color: Colors.red
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        buildTextField(
                            "Email",
                            Icon(
                              Icons.email,
                              color: Color(0xFFF5A811),
                              size: 25,
                            ),
                            IconButton(
                              icon: Icon(null),
                              onPressed: () {},
                            ),
                            emailController,
                            false, (value) {
                          String _validator = emailValidate(value);
                          if (_validator != "") {
                            return _validator;
                          }
                        }, size),
                        SizedBox(height: size.height * 0.035),
                        buildTextField(
                          "Password",
                          Icon(
                            Icons.lock,
                            color: Color(0xFFF5A811),
                            size: 25,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.visibility,
                              color: Color(0xFFF5A811),
                              size: 25,
                            ),
                            onPressed: () {
                              if (passwordEye) {
                                setState(() {
                                  passwordEye = false;
                                });
                              } else {
                                setState(() {
                                  passwordEye = true;
                                });
                              }
                            },
                          ),
                          passwordController,
                          passwordEye,
                          (value) {
                            String _validator = passwordValidator(value);
                            if (_validator != "") {
                              return _validator;
                            }
                          },
                          size,
                        ),
                        SizedBox(height: size.height * 0.01),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xFF2F2E41),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetpassScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: size.height * 0.08),
                        SizedBox(
                          width: size.width,
                          child: buildElevatedButton("Log In",size, () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              getDataFromLocalStorage('fcm_token').then((value) async {
                                final response = await loginUser(emailController.text,passwordController.text,value!);
                                if (response['error']) {
                                  setState(() {
                                    _isLoading = false;
                                    setState(() {
                                      errorMsg="Email or Password is incorrect";
                                    });
                                  });
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  setDataToLocalStorage("authToken", response['data']['authToken']);
                                  setDataToLocalStorage("userDetails", jsonEncode(response['data']));
                                  Navigator.pushNamed(context, 'DashboardScreen');
                                }
                              });
                            }
                          }),
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //     shape: const RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.all(
                          //         Radius.circular(5),
                          //       ),
                          //     ),
                          //
                          //     // primary: Color(0xFFF5A811),
                          //     // onPrimary: Colors.white,
                          //     textStyle: const TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 20,
                          //       fontWeight: FontWeight.bold,
                          //       fontFamily: 'Poppins',
                          //     ),
                          //   ),
                          //   onPressed: () {},
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(10),
                          //     child: Text('Log In',style: TextStyle(color: Colors.white),),
                          //   ),
                          // ),
                        ),
                        SizedBox(height: size.height * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF2F2E41),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, 'SignupScreen');
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
                )
              ],
            ),
          ),
        ));
  }
}
