import 'dart:convert';

import 'package:fashion_guru/controllers/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../components/add_product_fields.dart';
import '../components/delivery_address_fields.dart';
import '../components/elevatedbutton.dart';
import '../constants/textstyles.dart';
import '../services/validators.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key});

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = new TextEditingController();
  TextEditingController contactNoController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  Map<String, dynamic> deliveryDetails = {};
  @override
  void initState() {
    getDataFromLocalStorage("deliveryDetails").then((response) {
      setState(() {
        deliveryDetails = jsonDecode(response!);
        fullNameController.text = deliveryDetails['name'];
        contactNoController.text = deliveryDetails['phone_no'];
        emailController.text = deliveryDetails['email'];
        addressController.text = deliveryDetails['address'];
      });
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
          'Delivery Address',
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
                    children: [
                      Text(
                        'Full Name',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3D3D3D),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      buildDeliveryAddressField(
                          'Enter your fullname', 1, 1, size, fullNameController,
                          (value) {
                        String _validator = aplhaCharacter(value);
                        if (_validator != "") {
                          return _validator;
                        }
                      }),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        'Contact No.',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3D3D3D),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      buildDeliveryAddressField('Enter your contact number', 1,
                          1, size, contactNoController, (value) {
                        String _validator = phoneNoValidator(value);
                        if (_validator != "") {
                          return _validator;
                        }
                      }),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        'E-mail Address',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3D3D3D),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      buildDeliveryAddressField('Enter your email address', 1,
                          1, size, emailController, (value) {
                        String _validator = emailValidate(value);
                        if (_validator != "") {
                          return _validator;
                        }
                      }),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        'Address',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3D3D3D),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.005,
                      ),
                      buildDeliveryAddressField('Enter your delivery address',
                          5, 5, size, addressController, (value) {
                        String _validator = isNotEmpty(value);
                        if (_validator != "") {
                          return _validator;
                        }
                      }),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      SizedBox(
                        height: size.height * 0.035,
                      ),
                      SizedBox(
                        width: size.width,
                        child: buildElevatedButton(
                          'Save',
                          size,
                          () {
                            if (_formKey.currentState!.validate()) {
                              deliveryDetails['name']=fullNameController.text;
                              deliveryDetails['phone_no']=contactNoController.text;
                              deliveryDetails['email']=emailController.text;
                              deliveryDetails['address']=addressController.text;

                              setDataToLocalStorage("deliveryDetails",
                                      jsonEncode(deliveryDetails))
                                  .then((value) {
                                Navigator.pop(context);
                              });
                            }
                          },
                        ),
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
