import 'package:email_otp/email_otp.dart';
import 'package:fashion_guru/components/elevatedbutton.dart';
import 'package:fashion_guru/components/textfields.dart';
import 'package:fashion_guru/controllers/users.dart';
import 'package:fashion_guru/screens/verification_screen.dart';
import 'package:fashion_guru/services/email_otp.dart';
import 'package:fashion_guru/services/validators.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool passwordEye = true;
  bool confirmPasswordEye = true;
  final _formKey = GlobalKey<FormState>();

  //Vendor Controllers
  TextEditingController shopNameController = TextEditingController();
  TextEditingController vendorNameController = TextEditingController();
  TextEditingController shopEmailController = TextEditingController();
  TextEditingController shopContactNoController = TextEditingController();
  TextEditingController shopAddressController = TextEditingController();
  TextEditingController shopPasswordController = TextEditingController();
  TextEditingController shopConfirmPassController = TextEditingController();
  bool shopPasswordEye = true;
  bool shopConfirmPasswordEye = true;
  final _shopFormKey = GlobalKey<FormState>();
  EmailOTP myAuth = EmailOTP();

  String error = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          SizedBox(
            height: size.height * 0.25,
            child: Center(
              child: Image.asset(
                'images/logo.png',
                width: 275,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              height: size.height * 0.75,
              width: double.infinity,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      "SIGN UP",
                      style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 32,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                    // SizedBox(height: size.height * 0.03),
                    Text(
                      "$error",
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            TabBar(
                              tabs: [
                                Tab(
                                  child: Text(
                                    'User',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Vendor',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              // color: Colors.deepOrange,
                              height: size.height * 0.55,
                              child: TabBarView(
                                children: [
                                  SingleChildScrollView(
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          SizedBox(height: size.height * 0.03),
                                          buildTextField(
                                              "Name",
                                              Icon(
                                                Icons.person,
                                                color: Color(0xFFF5A811),
                                                size: 25,
                                              ),
                                              IconButton(
                                                icon: Icon(null),
                                                onPressed: () {},
                                              ),
                                              nameController,
                                              false, (value) {
                                            String _validator =
                                                aplhaCharacter(value);
                                            if (_validator != "") {
                                              return _validator;
                                            }
                                          },size,),
                                          SizedBox(height: size.height * 0.03),
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
                                            String _validator =
                                                emailValidate(value);
                                            if (_validator != "") {
                                              return _validator;
                                            }
                                          },size,),
                                          SizedBox(height: size.height * 0.03),
                                          buildTextField(
                                              "Contact No",
                                              Icon(
                                                Icons.phone,
                                                color: Color(0xFFF5A811),
                                                size: 25,
                                              ),
                                              IconButton(
                                                icon: Icon(null),
                                                onPressed: () {},
                                              ),
                                              contactNoController,
                                              false, (value) {
                                            String _validator =
                                                phoneNoValidator(value);
                                            if (_validator != "") {
                                              return _validator;
                                            }
                                          },size,),
                                          SizedBox(height: size.height * 0.03),
                                          buildTextField(
                                              "Address",
                                              Icon(
                                                Icons.location_pin,
                                                color: Color(0xFFF5A811),
                                                size: 25,
                                              ),
                                              IconButton(
                                                icon: Icon(null),
                                                onPressed: () {},
                                              ),
                                              addressController,
                                              false, (value) {
                                            String _validator =
                                                isNotEmpty(value);
                                            if (_validator != "") {
                                              return _validator;
                                            }
                                          },size,),
                                          SizedBox(height: size.height * 0.03),
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
                                                  if (confirmPasswordEye) {
                                                    setState(() {
                                                      confirmPasswordEye =
                                                          false;
                                                    });
                                                  } else {
                                                    setState(() {
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
                                          SizedBox(height: size.height * 0.08),
                                          SizedBox(
                                            width: size.width,
                                            child: buildElevatedButton(
                                                "Sign Up", size,() async {
                                              if (_formKey.currentState!.validate()) {
                                                Map<String, dynamic>
                                                    userDetails = {
                                                  "name": nameController.text,
                                                  "email": emailController.text,
                                                  "phone_no":
                                                      contactNoController.text,
                                                  "address":
                                                      addressController.text,
                                                  "password":
                                                      passwordController.text,
                                                  "verified_email": false,
                                                  "verified_contact_no": false,
                                                  "type": "customer"
                                                };

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
                                                print("test");
                                                var template =
                                                    'Thank you for choosing {{app_name}}. Your OTP is {{otp}}.';
                                                myAuth.setTemplate(
                                                    render: template);
                                                duplicateCheck(emailController.text, contactNoController.text).then((response) async {
                                                  print(response);
                                                  if(!response['error']){
                                                    await myAuth.sendOTP();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return VerificationScreen(
                                                            userEmail:
                                                            emailController
                                                                .text,
                                                            userPassword:
                                                            passwordController
                                                                .text,
                                                            userDetails:
                                                            userDetails,
                                                            myAuth: myAuth,
                                                            isAddUser: true,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  }
                                                });

                                              }
                                            }),
                                          ),
                                          SizedBox(height: size.height * 0.015),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Already have an account?',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                  )),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              GestureDetector(
                                                child: Text(
                                                  'Log In',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF2F2E41),
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, 'LoginScreen');
                                                },
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: size.height * 0.04),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //Vendor SignUp
                                  SingleChildScrollView(
                                    child: Form(
                                      key: _shopFormKey,
                                      child: Column(
                                        children: [
                                          SizedBox(height: size.height * 0.03),
                                          buildTextField(
                                              "Vendor Name",
                                              Icon(
                                                Icons.person,
                                                color: Color(0xFFF5A811),
                                                size: 25,
                                              ),
                                              IconButton(
                                                icon: Icon(null),
                                                onPressed: () {},
                                              ),
                                              vendorNameController,
                                              false, (value) {
                                            String _validator =
                                                aplhaCharacter(value);
                                            if (_validator != "") {
                                              return _validator;
                                            }
                                          },size,),
                                          SizedBox(height: size.height * 0.03),
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
                                              shopEmailController,
                                              false, (value) {
                                            String _validator =
                                                emailValidate(value);
                                            if (_validator != "") {
                                              return _validator;
                                            }
                                          },size,),
                                          SizedBox(height: size.height * 0.03),
                                          buildTextField(
                                              "Contact No",
                                              Icon(
                                                Icons.phone,
                                                color: Color(0xFFF5A811),
                                                size: 25,
                                              ),
                                              IconButton(
                                                icon: Icon(null),
                                                onPressed: () {},
                                              ),
                                              shopContactNoController,
                                              false, (value) {
                                            String _validator =
                                                phoneNoValidator(value);
                                            if (_validator != "") {
                                              return _validator;
                                            }
                                          },size,),
                                          SizedBox(height: size.height * 0.03),
                                          buildTextField(
                                              "Shop Name",
                                              Icon(
                                                Icons.store,
                                                color: Color(0xFFF5A811),
                                                size: 25,
                                              ),
                                              IconButton(
                                                icon: Icon(null),
                                                onPressed: () {},
                                              ),
                                              shopNameController,
                                              false, (value) {
                                            String _validator =
                                                aplhaCharacter(value);
                                            if (_validator != "") {
                                              return _validator;
                                            }
                                          },size,),
                                          SizedBox(height: size.height * 0.03),
                                          buildTextField(
                                              "Shop Address",
                                              Icon(
                                                Icons.location_pin,
                                                color: Color(0xFFF5A811),
                                                size: 25,
                                              ),
                                              IconButton(
                                                icon: Icon(null),
                                                onPressed: () {},
                                              ),
                                              shopAddressController,
                                              false, (value) {
                                            String _validator =
                                                isNotEmpty(value);
                                            if (_validator != "") {
                                              return _validator;
                                            }
                                          },size,),
                                          SizedBox(height: size.height * 0.03),
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
                                                  if (shopPasswordEye) {
                                                    setState(() {
                                                      shopPasswordEye = false;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      shopPasswordEye = true;
                                                    });
                                                  }
                                                },
                                              ),
                                              shopPasswordController,
                                              shopPasswordEye, (value) {
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
                                                  if (shopConfirmPasswordEye) {
                                                    setState(() {
                                                      shopConfirmPasswordEye =
                                                          false;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      shopConfirmPasswordEye =
                                                          true;
                                                    });
                                                  }
                                                },
                                              ),
                                              shopConfirmPassController,
                                              shopConfirmPasswordEye, (value) {
                                            if (shopPasswordController.text !=
                                                shopConfirmPassController
                                                    .text) {
                                              return "Password Doesn't Match";
                                            }
                                          },size,),
                                          SizedBox(height: size.height * 0.08),
                                          SizedBox(
                                            width: size.width,
                                            child: buildElevatedButton(
                                                "Sign Up", size,() async {
                                              if (_shopFormKey.currentState!
                                                  .validate()) {
                                                Map<String, dynamic>
                                                    userDetails = {
                                                  "name":
                                                  vendorNameController.text,
                                                  "email":
                                                      shopEmailController.text,
                                                  "phone_no":
                                                      shopContactNoController
                                                          .text,
                                                  "address":
                                                      shopAddressController
                                                          .text,
                                                  "shop_name":
                                                      shopNameController.text,
                                                  "password":
                                                      shopPasswordController
                                                          .text,
                                                  "verified_email": false,
                                                  "verified_contact_no": false,
                                                  "type": "vendor"
                                                };

                                                myAuth.setConfig(
                                                    appEmail:
                                                        "ansaraziz2016@gmail.com",
                                                    appName:
                                                        "Fashion Guru ~ Email OTP",
                                                    userEmail:
                                                        shopEmailController
                                                            .text,
                                                    otpLength: 4,
                                                    otpType:
                                                        OTPType.digitsOnly);

                                                var template =
                                                    'Thank you for choosing {{app_name}}. Your OTP is {{otp}}.';
                                                myAuth.setTemplate(
                                                    render: template);
                                                await myAuth.sendOTP();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return VerificationScreen(
                                                        userEmail:
                                                            shopEmailController
                                                                .text,
                                                        userPassword:
                                                            shopPasswordController
                                                                .text,
                                                        userDetails:
                                                            userDetails,
                                                        myAuth: myAuth,
                                                        isAddUser: true,
                                                      );
                                                    },
                                                  ),
                                                );
                                              }
                                            }),
                                          ),
                                          SizedBox(height: size.height * 0.015),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Already have an account?',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                  )),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              GestureDetector(
                                                child: Text(
                                                  'Log In',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF2F2E41),
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                                onTap: () {},
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: size.height * 0.04),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
