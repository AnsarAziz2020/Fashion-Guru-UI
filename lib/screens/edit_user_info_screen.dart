import 'dart:convert';

import 'package:fashion_guru/controllers/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/delivery_address_fields.dart';
import '../components/elevatedbutton.dart';
import '../constants/textstyles.dart';
import '../controllers/session.dart';
import '../services/validators.dart';

enum Type {
 name,email,phone_no,addres
}

extension TypeExtension on Type {
  Map<String,dynamic> get details {
    switch (this) {
      case Type.name:
        return {'name':"Full Name",'field':"name","validator":aplhaCharacter};
      case Type.email:
        return {'name':"Email",'field':"email","validator":emailValidate};
      case Type.phone_no:
        return {'name':"Phone Number",'field':"phone_no","validator":phoneNoValidator};
      case Type.addres:
        return {'name':"Address",'field':"address","validator":isNotEmpty};
    }
  }
}

class EditInfoScreen extends StatefulWidget {
  final Type type;
  final Map<String, dynamic> loggedInUser;
  const EditInfoScreen({super.key, required this.type, required this.loggedInUser});

  @override
  State<EditInfoScreen> createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  TextEditingController nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
nameController.text=widget.loggedInUser[widget.type.details['field']];
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
          'Edit ${widget.type.details['name']}',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.type.details['name']}',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3D3D3D),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      buildDeliveryAddressField(
                          'Enter Your ${widget.type.details['name']}', 1, 1, size, nameController,
                          (value) {
                            var typeValidator = widget.type.details['validator'] as String? Function(String);
                        String? _validator = typeValidator(value);
                        print(typeValidator(value));
                        if (_validator != "") {
                          return _validator;
                        }
                      }),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width*0.4,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(color: Colors.grey.withOpacity(0.8),), // Border color and width
                                primary: Color(0xFFF8F8F8), // Button background color
                                onPrimary: Colors.grey.withOpacity(0.8),
                                elevation: 0,// Text color
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width*0.02,
                          ),
                          SizedBox(
                            width: size.width*0.4,
                            child: ElevatedButton(
                              onPressed: () {
                                if(_formKey.currentState!.validate()){
                                  widget.loggedInUser[widget.type.details['field']]=nameController.text;

                                  changeProfile(widget.type.details['field'], nameController.text,widget.loggedInUser['authToken']).then((value) {
                                    if(!value['error']){
                                      setDataToLocalStorage('userDetails', jsonEncode(widget.loggedInUser));
                                      Navigator.pop(context);
                                    }
                                  });

                                }
                              },
                              child: Text('Save'),
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(color: primaryColor), // Border color and width
                                primary: Color(0xFFF8F8F8), // Button background color
                                onPrimary: primaryColor,
                                elevation: 0,// Text color
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
