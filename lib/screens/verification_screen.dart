import 'package:email_otp/email_otp.dart';
import 'package:fashion_guru/screens/change_pass_screen.dart';
import 'package:fashion_guru/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/elevatedbutton.dart';
import '../components/textfields.dart';
import '../controllers/users.dart';

class VerificationScreen extends StatefulWidget {
  final String userEmail;
  final String userPassword;
  final Map<String, dynamic>userDetails;
  final bool isAddUser;
  final EmailOTP myAuth;


  const VerificationScreen(
      {super.key,
        required this.userEmail,
        required this.myAuth,
        required this.userPassword,
        required this.userDetails, required this.isAddUser});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController otpCode = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String errors = "";

  void changeErrors(String Error){
    setState(() {
      errors=Error;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 40, left: 40, right: 40),
          child: Form(
            key: _formKey,
            child: ListView(children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset("images/otp_verify.png", width: 300,),
                        SizedBox(
                          height: size.height*0.05,
                        ),
                        Text(
                          "OTP Verification",
                          style: TextStyle(
                              color: Color(0xFF3D3D3D),
                              fontSize: 30,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: size.height * 0.05),

                        Text(
                          errors+"",
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        buildTextField(
                            "OTP CODE",
                            Icon(
                              Icons.verified_user,
                              // color: Color(0xFFF5A811),
                              size: 25,
                            ),
                            IconButton(
                              icon: Icon(null),
                              onPressed: () {},
                            ),
                            otpCode,
                            false, (value) {
                          String _validator = onlyNumeric(value);
                          if (_validator != "") {
                            return _validator;
                          }
                          if (value.length != 4) {
                            // print("hello");
                            return "OTP Must Have 4 Digits";
                          }
                        },size,),
                        SizedBox(height: size.height * 0.01),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            child: Text(
                              'Resend OTP',
                              style: TextStyle(
                                color: Color(0xFFF5A811),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        SizedBox(
                          width: size.width,

                          child: buildElevatedButton("Verify OTP",size, () async {
                            if (_formKey.currentState!.validate()) {
                              bool OTP_results = await widget.myAuth.verifyOTP(otp: otpCode.text);
                              if (OTP_results) {
                                try {
                                  (widget.isAddUser)?addUser(context):checkOTP(context);
                                } catch (e) {
                                  changeErrors("Server Error Try Again");
                                }
                              } else {
                                changeErrors("Invalid Code");
                              }
                            }
                          },),
                        ),
                      ],
                    ),
                  ]),
            ]),
          )),
    );

  }

  void addUser(BuildContext context) {
    userRegisterDetails(widget.userDetails).then((result) {
      print(result['code']);
      if ((result['code']) != "ER_DUP_ENTRY") {
        Navigator.pushNamed(context, 'LoginScreen');
      } else {
        changeErrors("This Email is already in use");
      }
    });
  }

  void checkOTP(BuildContext context) {
    print(checkOTP);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassScreen(email: widget.userEmail)));
  }
}