import 'package:fashion_guru/constants/textstyles.dart';
import 'package:fashion_guru/screens/admin_order_detail_screen.dart';
import 'package:fashion_guru/screens/admin_view_order_screen.dart';
import 'package:fashion_guru/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashion_guru/components/toast_message.dart';
import 'package:fashion_guru/controllers/session.dart';

import '../components/admin_option.dart';
import '../components/bottom_navigation_bar.dart';
import '../components/profile_option.dart';

class AdminPortal extends StatefulWidget {
  const AdminPortal({super.key});

  @override
  State<AdminPortal> createState() => _AdminPortalState();
}

class _AdminPortalState extends State<AdminPortal> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: [
                Image.asset("images/admin_portal.png", width: 300,),
                SizedBox(
                  height: size.height*0.025,
                ),
                Text(
                  "Admin Portal",
                  style: mainHeading(size),
                ),
                SizedBox(height: size.height * 0.025),
                Column(
                  children: [
                    buildAdminOption(
                        Icon(
                          Icons.person_outlined,
                          size: size.width * 0.06,
                          color: Colors.white,
                        ),
                        'View Users',
                        size,
                            () {
                          Navigator.pushNamed(context, 'ViewUsers');
                            }),
                    SizedBox(
                      height: size.height * 0.0025,
                    ),
                    buildAdminOption(
                        Icon(
                          Icons.list_rounded,
                          size: size.width * 0.06,
                          color: Colors.white,
                        ),
                        'View Products',
                        size,
                            () {
                          Navigator.pushNamed(context, 'AdminViewProduct');
                            }),
                    SizedBox(
                      height: size.height * 0.0025,
                    ),
                    buildAdminOption(
                        Icon(
                          Icons.list_alt_rounded,
                          size: size.width * 0.06,
                          color: Colors.white,
                        ),
                        'View Orders',
                        size,
                            () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  AdminViewOrderScreen()));
                            }),

                    SizedBox(
                      height: size.height * 0.0025,
                    ),
                    buildAdminOption(
                        Icon(
                          Icons.logout,
                          size: size.width * 0.06,
                          color: Colors.white,
                        ),
                        'Log Out',
                        size,
                            () {
                              logoutUser().then((result){
                                if(result['error']){
                                  showToast("Error In Logout");
                                } else {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()
                                      ),
                                      ModalRoute.withName("/Login")
                                  );
                                }
                              });
                            }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Custom_Navigator(selectedIndex: 3),
    );
  }
}
