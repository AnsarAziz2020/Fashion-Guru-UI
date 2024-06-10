import 'package:email_otp/email_otp.dart';
import 'package:fashion_guru/screens/verification_screen.dart';
import 'package:fashion_guru/services/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/elevatedbutton.dart';
import '../components/textfields.dart';

class ForgetpassScreen extends StatefulWidget {
  const ForgetpassScreen({super.key});

  @override
  State<ForgetpassScreen> createState() => _ForgetpassScreenState();
}

class _ForgetpassScreenState extends State<ForgetpassScreen> {
  TextEditingController emailController = TextEditingController();
  EmailOTP myAuth = EmailOTP();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        
          padding: EdgeInsets.only(top: 60, left: 40, right: 40),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset("images/forgotpass.png", width: 400,),
                  SizedBox(
                    height: size.height*0.05,
                  ),
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                        color: Color(0xFF3D3D3D),
                        fontSize: 30,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.05),

                  // Text(
                  //   errors+"",
                  //   style: TextStyle(
                  //       color: Colors.red,
                  //       fontFamily: 'Poppins',
                  //       fontWeight: FontWeight.bold),
                  // ),
                  buildTextField(
                      "Enter your Email",
                      Icon(
                        Icons.email,
                        // color: Color(0xFFF5A811),
                        size: 25,
                      ),
                      IconButton(
                        icon: Icon(null),
                        onPressed: () {},
                      ),
                      emailController,
                      false,  (value) {
                    String _validator=emailValidate(value);
                    if(_validator!=""){
                      return _validator;
                    }
                  },size,),
                  SizedBox(height: size.height * 0.01),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: GestureDetector(
                  //     child: Text(
                  //       'Resend OTP',
                  //       style: TextStyle(
                  //         color: Color(0xFFF5A811),
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w600,
                  //         fontFamily: 'Poppins',
                  //       ),
                  //     ),
                  //     onTap: () {},
                  //   ),
                  // ),
                  SizedBox(height: size.height * 0.05),
                  SizedBox(
                    width: size.width,

                    child: buildElevatedButton("Submit",size,() async {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic>
                        userDetails = {};

                        myAuth.setConfig(
                            appEmail:
                            "ansaraziz2016@gmail.com",
                            appName:
                            "Fashion Guru ~ Email OTP",
                            userEmail:
                            emailController.text,
                            otpLength: 4,
                            otpType:
                            OTPType.digitsOnly);

                        var template ='Thank you for choosing {{app_name}}. Your OTP is {{otp}}.';
                        myAuth.setTemplate(render: template);
                        await myAuth.sendOTP();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return VerificationScreen(
                                userEmail:
                                emailController.text,
                                userPassword:"",
                                userDetails:userDetails,
                                myAuth: myAuth,
                                isAddUser: false,
                              );
                            },
                          ),
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),),
    );
  }
}
