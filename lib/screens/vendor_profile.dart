import 'package:fashion_guru/components/profile_option.dart';
import 'package:fashion_guru/components/toast_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:fashion_guru/controllers/session.dart';
import 'package:fashion_guru/constants/server_config.dart';
import '../components/bottom_navigation_bar.dart';
import '../constants/textstyles.dart';
import 'package:file_picker/file_picker.dart';

import '../controllers/users.dart';
import 'edit_user_info_screen.dart';
import 'login_screen.dart';

class VendorProfile extends StatefulWidget {
  const VendorProfile({super.key});

  @override
  State<VendorProfile> createState() => _VendorProfileState();
}

class _VendorProfileState extends State<VendorProfile> {
  Map<String, dynamic>loggedInUser={
    "name":"Loading",
    "email":"Loading",
    "profile_pic":"loading.png",
  };
  bool isVendor=false;

  @override
  void initState() {
    getUserFromSession().then((response){
      if(response['error']){
        showToast(response['e']);
      } else {
        setState(() {
          loggedInUser=response['data'];
          isVendor=(loggedInUser['type']=='vendor')?true:false;
        });
      }
    });

    // TODO: implement initState
    super.initState();
  }

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
          'Account',
          style: screenHeading(size),
        ),
        actions: [
          Icon(
            CupertinoIcons.ellipsis_vertical,
            size: size.width * 0.065,
          ),
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20,bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 80,backgroundColor: primaryColor,
                    child:CircleAvatar(
                      radius: 76.5,backgroundImage:NetworkImage("http://${ipAddress}/uploads/${loggedInUser['profile_pic']}"),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(100),
                    //   child: Image.asset("images/t-shirt.jpg",fit: BoxFit.cover,width: size.width*0.45,),

                    // ),
                    ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
                          if(result!=""){
                            File selectedFile=File(result!.files.single.path!);
                            FormData formData = FormData.fromMap({
                              'file': await MultipartFile.fromFile(
                                selectedFile!.path,
                                filename: selectedFile!.path.split('/').last,
                              ),
                              'id':loggedInUser['id'],
                            });
                            print("test");
                            uploadProfilePic(formData).then((response){

                              updateUserFromSession().then((value){
                                setState(() {
                                  loggedInUser=value['data'];
                                });
                              });
                            });
                          }

                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFF8F8F8),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: size.width * 0.055,
                            color: Color(0xFFF5A811),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: size.height*0.005,),
                Text(
                  loggedInUser['name'],
                  style: profileNameStyle(size),
                ),
                Text(loggedInUser['email'], style: profileEmailStyle(size)),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Visibility(
                  visible: isVendor,
                  child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  padding: EdgeInsets.all(8),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: Column(
                          children: [
                            Icon(
                              Icons.playlist_add_rounded,
                              size: size.width * 0.055,
                              color: Color(0xFF2F2E41),
                            ),
                            SizedBox(
                              height: size.height * 0.005,
                            ),
                            Text('Add Products',
                                style: profileCardTextStyle(size)),
                          ],
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, 'AddProduct');
                        },
                      ),
                      InkWell(
                        child: Column(
                          children: [
                            Icon(
                              Icons.list_rounded,
                              size: size.width * 0.055,
                              color: Color(0xFF2F2E41),
                            ),
                            SizedBox(
                              height: size.height * 0.005,
                            ),
                            Text('View Products',
                                style: profileCardTextStyle(size)),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, 'ViewProduct');
                        },
                      ),
                      InkWell(
                        child: Column(
                          children: [
                            Icon(
                              Icons.list_alt_rounded,
                              size: size.width * 0.055,
                              color: Color(0xFF2F2E41),
                            ),
                            SizedBox(
                              height: size.height * 0.005,
                            ),
                            Text('View Orders',
                                style: profileCardTextStyle(size)),

                          ],
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, 'ViewOrder');
                        },
                      ),
                    ],
                  ),
                ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Column(
                  children: [
                    buildProfileOption(
                        Icon(
                          Icons.person,
                          size: size.width * 0.06,
                          color: Color(0xFF2F2E41),
                        ),
                        'Name',
                        size,
                        () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditInfoScreen(type: Type.name,loggedInUser: this.loggedInUser,)));
                        }),
                    SizedBox(
                      height: size.height * 0.0025,
                    ),
                    buildProfileOption(
                        Icon(
                          Icons.mail,
                          size: size.width * 0.06,
                          color: Color(0xFF2F2E41),
                        ),
                        'E-mail',
                        size,
                        () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditInfoScreen(type: Type.email, loggedInUser: this.loggedInUser,)));
                        }),
                    SizedBox(
                      height: size.height * 0.0025,
                    ),
                    buildProfileOption(
                        Icon(
                          Icons.phone,
                          size: size.width * 0.06,
                          color: Color(0xFF2F2E41),
                        ),
                        'Contact No',
                        size,
                            () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditInfoScreen(type: Type.phone_no,loggedInUser: this.loggedInUser,)));
                            }),
                    SizedBox(
                      height: size.height * 0.0025,
                    ),
                    buildProfileOption(
                        Icon(
                          Icons.location_pin,
                          size: size.width * 0.06,
                          color: Color(0xFF2F2E41),
                        ),
                        'Address',
                        size,
                        () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditInfoScreen(type: Type.addres,loggedInUser: this.loggedInUser,)));
                        }),
                    SizedBox(
                      height: size.height * 0.0025,
                    ),
                    // buildProfileOption(
                    //     Icon(
                    //       Icons.light_mode,
                    //       size: size.width * 0.06,
                    //       color: Color(0xFF2F2E41),
                    //     ),
                    //     'Theme',
                    //     size,
                    //     () {}),
                    // SizedBox(
                    //   height: size.height * 0.0025,
                    // ),
                    buildProfileOption(
                        Icon(
                          CupertinoIcons.lock_fill,
                          size: size.width * 0.06,
                          color: Color(0xFF2F2E41),
                        ),
                        'Change Password',
                        size,
                        () {}),
                    SizedBox(
                      height: size.height * 0.0025,
                    ),
                    buildProfileOption(
                        Icon(
                          Icons.logout,
                          size: size.width * 0.06,
                          color: Color(0xFF2F2E41),
                        ),
                        'Log Out',
                        size,
                        () {
                          logoutUser().then((result){
                            print(result);
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


// Container(
//   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white,),
//   padding: EdgeInsets.only(left: 10,right: 10,top:12,bottom: 12),
//   child: Row(
//     children: [
//       Icon(CupertinoIcons.person_fill,size: size.width*0.06,color: Color(0xFF2F2E41),),
//       SizedBox(width: size.width*0.03,),
//       Expanded(child: Text('Name',style: p_45_wcolor(size),),),
//       Icon(CupertinoIcons.chevron_right,size: size.width*0.06,color: Color(0xFFF5A811),),
//     ],
//   ),
// ),