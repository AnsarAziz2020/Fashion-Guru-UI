import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../constants/textstyles.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
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
            padding: EdgeInsets.only(left: 15, right: 15, top: 0),
            child: Center(
              child: Container(
                height: size.height*0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 80,
                    ),
                    SizedBox(height: size.height*0.005,),
                    Text(
                      'Ansar',
                      style: profileNameStyle(size),
                    ),
                    // Text('ansar@gmail.com', style: profileEmailStyle(size)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mail_outline,size: size.width*0.04,color: textColor,),
                        SizedBox(width: size.width*0.01,),
                        Text('ansar@gmail.com', style: profileEmailStyle(size)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone_outlined,size: size.width*0.04,color: textColor,),
                        SizedBox(width: size.width*0.01,),
                        Text('03123456789', style: profileEmailStyle(size)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_outlined,size: size.width*0.04,color: textColor,),
                        SizedBox(width: size.width*0.01,),
                        Text('Karachi,Pakistan', style: profileEmailStyle(size)),
                      ],
                    ),

                    // SizedBox(
                    //   height: size.height * 0.02,
                    // ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
