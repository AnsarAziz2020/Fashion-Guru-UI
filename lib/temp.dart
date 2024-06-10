// import 'package:flutter/material.dart';
// import 'package:fashion_guru/components/elevatedbutton.dart';
// import 'package:fashion_guru/components/textfields.dart';
//
// class temp extends StatefulWidget {
//   const temp({super.key});
//
//   @override
//   State<temp> createState() => _tempState();
// }
//
// class _tempState extends State<temp> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController contactNoController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPassController = TextEditingController();
//   //Vendor Controllers
//   TextEditingController shopNameController = TextEditingController();
//   TextEditingController shopEmailController = TextEditingController();
//   TextEditingController shopContactNoController = TextEditingController();
//   TextEditingController shopAddressController = TextEditingController();
//   TextEditingController shopPasswordController = TextEditingController();
//   TextEditingController shopConfirmPassController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Color(0xFFF8F8F8),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(children: [
//           SizedBox(
//             height: size.height * 0.25,
//             child: Center(
//               child: Image.asset(
//                 'images/logo.png',
//                 width: 275,
//               ),
//             ),
//           ),
//           SingleChildScrollView(
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 40),
//               height: size.height * 0.75,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(75),
//                     topRight: Radius.circular(75),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 20,
//                       offset: Offset(0, -2),
//                       spreadRadius: -20,
//                     )
//                   ]),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: size.height * 0.03,
//                     ),
//                     Text(
//                       "SIGN UP",
//                       style: TextStyle(
//                           color: Color(0xFF3D3D3D),
//                           fontSize: 32,
//                           fontFamily: 'Poppins',
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: size.height * 0.03),
//                     Container(
//                       child: DefaultTabController(
//                           length: 2,
//                           child: Column(
//                             children: [
//                               TabBar(
//                                 tabs: [
//                                   Tab(
//                                     child: Text(
//                                       'User',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontFamily: 'Poppins',
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                   Tab(
//                                     child: Text(
//                                       'Vendor',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontFamily: 'Poppins',
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//
//                               Container(
//                                 // color: Colors.deepOrange,
//                                 height: size.height*0.55,
//                                 child: TabBarView(
//                                     children:[
//                                     SingleChildScrollView(
//                                       child: Column(
//                                         children: [
//                                           SizedBox(height: size.height * 0.03),
//
//                                           buildTextField(
//                                               "Name",
//                                               Icon(
//                                                 Icons.person,
//                                                 color: Color(0xFFF5A811),
//                                                 size: 25,
//                                               ),
//                                               IconButton(
//                                                 icon: Icon(null),
//                                                 onPressed: () {},
//                                               ),
//                                               nameController,
//                                               false),
//                                           SizedBox(height: size.height * 0.03),
//                                           buildTextField(
//                                               "Email",
//                                               Icon(
//                                                 Icons.email,
//                                                 color: Color(0xFFF5A811),
//                                                 size: 25,
//                                               ),
//                                               IconButton(
//                                                 icon: Icon(null),
//                                                 onPressed: () {},
//                                               ),
//                                               emailController,
//                                               false),
//                                           SizedBox(height: size.height * 0.03),
//                                           buildTextField(
//                                               "Contact No",
//                                               Icon(
//                                                 Icons.phone,
//                                                 color: Color(0xFFF5A811),
//                                                 size: 25,
//                                               ),
//                                               IconButton(
//                                                 icon: Icon(null),
//                                                 onPressed: () {},
//                                               ),
//                                               contactNoController,
//                                               false),
//                                           SizedBox(height: size.height * 0.03),
//                                           buildTextField(
//                                               "Address",
//                                               Icon(
//                                                 Icons.location_pin,
//                                                 color: Color(0xFFF5A811),
//                                                 size: 25,
//                                               ),
//                                               IconButton(
//                                                 icon: Icon(null),
//                                                 onPressed: () {},
//                                               ),
//                                               addressController,
//                                               false),
//                                           SizedBox(height: size.height * 0.03),
//                                           buildTextField(
//                                               "Password",
//                                               Icon(
//                                                 Icons.lock,
//                                                 color: Color(0xFFF5A811),
//                                                 size: 25,
//                                               ),
//                                               IconButton(
//                                                 icon: Icon(
//                                                   Icons.visibility,
//                                                   color: Color(0xFFF5A811),
//                                                   size: 25,
//                                                 ),
//                                                 onPressed: () {},
//                                               ),
//                                               passwordController,
//                                               true),
//                                           SizedBox(height: size.height * 0.03),
//                                           buildTextField(
//                                               "Confirm Password",
//                                               Icon(
//                                                 Icons.lock,
//                                                 color: Color(0xFFF5A811),
//                                                 size: 25,
//                                               ),
//                                               IconButton(
//                                                 icon: Icon(
//                                                   Icons.visibility,
//                                                   color: Color(0xFFF5A811),
//                                                   size: 25,
//                                                 ),
//                                                 onPressed: () {},
//                                               ),
//                                               confirmPassController,
//                                               true),
//                                           SizedBox(height: size.height * 0.08),
//                                           SizedBox(
//                                             width: size.width,
//                                             child: buildElevatedButton("Sign Up", () => null),
//                                           ),
//                                           SizedBox(height: size.height * 0.015),
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             children: [
//                                               Text('Already have an account?',
//                                                   style: TextStyle(
//                                                     fontSize: 15,
//                                                     fontFamily: 'Poppins',
//                                                   )),
//                                               SizedBox(
//                                                 width: 5,
//                                               ),
//                                               GestureDetector(
//                                                 child: Text(
//                                                   'Log In',
//                                                   style: TextStyle(
//                                                     fontSize: 16,
//                                                     color: Color(0xFF2F2E41),
//                                                     fontWeight: FontWeight.bold,
//                                                     fontFamily: 'Poppins',
//                                                   ),
//                                                 ),
//                                                 onTap: () {
//                                                   Navigator.pushNamed(context, 'LoginScreen');
//                                                 },
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(height: size.height * 0.04),
//
//
//                                         ],
//                                       ),
//                                     ),
//                                       SingleChildScrollView(
//                                         child: Column(
//                                           children: [
//                                             SizedBox(height: size.height * 0.03),
//
//                                             buildTextField(
//                                                 "Shop Name",
//                                                 Icon(
//                                                   Icons.person,
//                                                   color: Color(0xFFF5A811),
//                                                   size: 25,
//                                                 ),
//                                                 IconButton(
//                                                   icon: Icon(null),
//                                                   onPressed: () {},
//                                                 ),
//                                                 shopNameController,
//                                                 false),
//                                             SizedBox(height: size.height * 0.03),
//                                             buildTextField(
//                                                 "Email",
//                                                 Icon(
//                                                   Icons.email,
//                                                   color: Color(0xFFF5A811),
//                                                   size: 25,
//                                                 ),
//                                                 IconButton(
//                                                   icon: Icon(null),
//                                                   onPressed: () {},
//                                                 ),
//                                                 shopEmailController,
//                                                 false),
//                                             SizedBox(height: size.height * 0.03),
//                                             buildTextField(
//                                                 "Contact No",
//                                                 Icon(
//                                                   Icons.phone,
//                                                   color: Color(0xFFF5A811),
//                                                   size: 25,
//                                                 ),
//                                                 IconButton(
//                                                   icon: Icon(null),
//                                                   onPressed: () {},
//                                                 ),
//                                                 shopContactNoController,
//                                                 false),
//                                             SizedBox(height: size.height * 0.03),
//                                             buildTextField(
//                                                 "Shop Address",
//                                                 Icon(
//                                                   Icons.location_pin,
//                                                   color: Color(0xFFF5A811),
//                                                   size: 25,
//                                                 ),
//                                                 IconButton(
//                                                   icon: Icon(null),
//                                                   onPressed: () {},
//                                                 ),
//                                                 shopAddressController,
//                                                 false),
//                                             SizedBox(height: size.height * 0.03),
//                                             buildTextField(
//                                                 "Password",
//                                                 Icon(
//                                                   Icons.lock,
//                                                   color: Color(0xFFF5A811),
//                                                   size: 25,
//                                                 ),
//                                                 IconButton(
//                                                   icon: Icon(
//                                                     Icons.visibility,
//                                                     color: Color(0xFFF5A811),
//                                                     size: 25,
//                                                   ),
//                                                   onPressed: () {},
//                                                 ),
//                                                 shopPasswordController,
//                                                 true),
//                                             SizedBox(height: size.height * 0.03),
//                                             buildTextField(
//                                                 "Confirm Password",
//                                                 Icon(
//                                                   Icons.lock,
//                                                   color: Color(0xFFF5A811),
//                                                   size: 25,
//                                                 ),
//                                                 IconButton(
//                                                   icon: Icon(
//                                                     Icons.visibility,
//                                                     color: Color(0xFFF5A811),
//                                                     size: 25,
//                                                   ),
//                                                   onPressed: () {},
//                                                 ),
//                                                 shopConfirmPassController,
//                                                 true),
//                                             SizedBox(height: size.height * 0.08),
//                                             SizedBox(
//                                               width: size.width,
//                                               child: buildElevatedButton("Sign Up", () => null),
//                                             ),
//                                             SizedBox(height: size.height * 0.015),
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               children: [
//                                                 Text('Already have an account?',
//                                                     style: TextStyle(
//                                                       fontSize: 15,
//                                                       fontFamily: 'Poppins',
//                                                     )),
//                                                 SizedBox(
//                                                   width: 5,
//                                                 ),
//                                                 GestureDetector(
//                                                   child: Text(
//                                                     'Log In',
//                                                     style: TextStyle(
//                                                       fontSize: 16,
//                                                       color: Color(0xFF2F2E41),
//                                                       fontWeight: FontWeight.bold,
//                                                       fontFamily: 'Poppins',
//                                                     ),
//                                                   ),
//                                                   onTap: () {
//                                                     Navigator.pushNamed(context, 'LoginScreen');
//                                                   },
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(height: size.height * 0.04),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//
//                                 ),
//                               ),
//                             ],
//                           ),
//
//                         ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
