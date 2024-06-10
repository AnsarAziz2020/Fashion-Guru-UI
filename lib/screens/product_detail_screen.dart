import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fashion_guru/constants/textstyles.dart';
import 'package:fashion_guru/controllers/cart.dart';
import 'package:fashion_guru/controllers/order.dart';
import 'package:fashion_guru/controllers/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/add_product_fields.dart';
import '../components/color_elevated_button.dart';
import '../components/delivery_address_fields.dart';
import '../components/elevatedbutton.dart';
import '../components/toast_message.dart';
import '../constants/server_config.dart';
import '../services/validators.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String,dynamic> productDetails;
  const ProductDetailScreen({super.key, required this.productDetails});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<String> otherImages=[];
  List<String> sizes=[];
  List<String> colors=[];
  String activeImage='';
  String selectedImage="";
  String selectedSize="";
  String selectedColor="";
  Map<String, dynamic> loggedInUser = {};
  int reviewShown=5;
  List<dynamic> reviews = [];

  final _formKey = GlobalKey<FormState>();
  TextEditingController priceController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();

  @override
  void initState() {
    otherImages=widget.productDetails['other_images'].split(",");
    sizes=widget.productDetails['size'].split(",");
    colors=widget.productDetails['colors'].split(",");
    activeImage='http://${ipAddress}/uploads/${widget.productDetails['thumbnail_image']}';

    getUserFromSession().then((response) async {
      if (response['error']) {
        showToast(response['e']);
      } else {
        // print(widget.productDetails['id']);
        Map<String, dynamic> reviewList = await listProductReview(widget.productDetails['id']);
        setState(() {
          this.reviews = reviewList['data']['reviews'];
          loggedInUser = response['data'];
          print(this.reviews);
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
        // appBar: AppBar(
        //   leading: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: Icon(
        //       CupertinoIcons.left_chevron,
        //       size: size.width * 0.065,
        //     ),
        //   ),
        //   actions: [
        //     Icon(
        //       CupertinoIcons.ellipsis_vertical,
        //       size: size.width * 0.065,
        //     ),
        //   ],
        //   centerTitle: true,
        //   elevation: 0,
        //   backgroundColor: Color(0xFFF8F8F8),
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: size.width,
                            height: size.width,
                            child: Image.network(
                              activeImage,
                              // width: size.width,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                child: Icon(
                                  CupertinoIcons.left_chevron,
                                  color: Colors.white,
                                  size: size.width * 0.065,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: size.height * 0.1,
                        padding: EdgeInsets.only(
                            left: 15, top: 8, right: 15, bottom: 8),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: otherImages.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  activeImage='http://${ipAddress}/uploads/${otherImages[index]}';
                                  selectedImage=otherImages[index];
                                });
                              },
                              child: Container(
                                width: size.width * 0.17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: (selectedImage==otherImages[index])?primaryColor:Colors.transparent,
                                    width: 2,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                margin: EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    "http://${ipAddress}/uploads/${otherImages[index]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.productDetails['product_name']}',
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF3D3D3D),
                              ),
                        ),
                        Text(
                          '${widget.productDetails['description']}',
                          style: TextStyle(
                            fontSize: size.width * 0.035,
                            color: Colors.black.withOpacity(0.75),
                            // overflow: TextOverflow.clip
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Rs. ',
                              style: TextStyle(
                                fontSize: size.width * 0.045,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                // overflow: TextOverflow.clip
                              ),
                            ),
                            Text(
                              '${widget.productDetails['price']}',
                              style: TextStyle(
                                  fontSize: size.width * 0.065,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 15),
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Size',
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: size.height * 0.03,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sizes.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  setState(() {
                                    selectedSize=sizes[index];
                                  });
                                },
                                child: Container(
                                  width: size.width*0.13,
                                  padding: EdgeInsets.only(left: 5,top: 3,right: 5,bottom: 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: (selectedSize==sizes[index])?primaryColor:Colors.transparent,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                    color: (selectedSize==sizes[index])?primaryColor.withOpacity(0.1):Colors.black.withOpacity(0.1),
                                  ),
                                  margin: EdgeInsets.only(right: 10),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('${sizes[index]}',style: TextStyle(
                                      fontSize: size.width * 0.033,
                                      color: textColor,
                                    ),),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height*0.01,
                        ),
                        Divider(thickness: 1,),
                        Text(
                          'Color',
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(height: 5),
                        Container(
                          height: size.height * 0.035,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: colors.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedColor = colors[index];
                                  });
                                },
                                child: Container(
                                  width: size.width * 0.16,
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: (selectedColor == colors[index])
                                          ? primaryColor
                                          : Colors.transparent,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                    color: (selectedColor == colors[index])
                                        ? primaryColor.withOpacity(0.1)
                                        : Colors.black.withOpacity(0.1),
                                  ),
                                  margin: EdgeInsets.only(right: 10),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${colors[index]}',
                                      style: TextStyle(
                                        fontSize: size.width * 0.033,
                                        color: textColor,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        (reviews.length>0)?Column(children: [
                          Divider(
                            thickness: 1,
                          ),
                          Text(
                            'Review & Rating',
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),

                          SizedBox(height: 8),
                          Column(
                            children: [
                              Container(
                                // height: size.height * 0.5,
                                child: ListView.builder(
                                  // physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: (reviews.length>reviewShown)?reviewShown:reviews.length,
                                  itemBuilder: (context, index) {
                                    Map <String,dynamic> item = reviews[index];
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['name'],
                                            style: TextStyle(
                                                fontSize: size.width * 0.035,
                                                color: textColor,
                                                fontWeight: FontWeight.w600,
                                                overflow: TextOverflow.ellipsis),
                                          ),
                                          Row(
                                            children: List.generate(5, (index) {
                                              return Icon(
                                                index < item['rating']
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                color: Colors.yellow,
                                                size: size.width * 0.045,
                                              );
                                            }),
                                          ),
                                          Text(
                                            item['review'],
                                            style: TextStyle(
                                              fontSize: size.width * 0.032,
                                              color: textColor.withOpacity(0.7),
                                              // overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // SizedBox(
                              //   height: size.height*0.005,
                              // ),
                              (reviews.length>reviewShown)?InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('View More',style: TextStyle(color: primaryColor),),
                                      Icon(Icons.keyboard_double_arrow_down,color: primaryColor,size: size.width*0.04,),
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      reviewShown+=5;
                                    });
                                  }
                              ):Column(children: [],)
                            ],
                          )
                        ],)
                        :Column(children: [],),

                        SizedBox(height: 60),
                        // SizedBox(
                        //     width: size.width*1,
                        //     child: buildElevatedButton("Add To Cart", size, (){
                        //       print(selectedImage.isNotEmpty);
                        //       if(selectedImage.isNotEmpty && selectedSize.isNotEmpty && colors.isNotEmpty){
                        //         Map<String, dynamic> productCart={
                        //           "product_id":widget.productDetails['id'],
                        //           "image":selectedImage,
                        //           "size":selectedSize,
                        //           "color":selectedColor,
                        //           "quantity":"1",
                        //           "price":widget.productDetails['price'],
                        //           "userId":loggedInUser['id']
                        //         };
                        //         addProductToCart(productCart).then((value){
                        //           showToast("Product Added To Cart");
                        //         }).catchError((onError){
                        //         });
                        //       } else {
                        //         showToast("You Must Select Image, Size & Color");
                        //       }
                        //     })),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: EdgeInsets.all(15),
            width: size.width,
            // height: size.height*0.1,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: size.width*0.42,
                    child: buildElevatedButton("Bargain", size, (){
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(
                              title: const Text('Bargain Price'),
                              content: SizedBox(
                                height: size.height*0.205,
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          'Enter the price you want to bargain at?'),
                                      SizedBox(
                                        height: size.height*0.01,
                                      ),
                                      buildDeliveryAddressField(
                                          'Enter the price',
                                          1,
                                          1,
                                          size,
                                          priceController, (value) {
                                        String _validator = onlyNumeric(value);
                                        if (_validator != "") {
                                          return _validator;
                                        }
                                      }),
                                      SizedBox(
                                        height: size.height*0.01,
                                      ),
                                      buildDeliveryAddressField(
                                          'Enter the quantity',
                                          1,
                                          1,
                                          size,
                                          quantityController, (value) {
                                        String _validator = onlyNumeric(value);
                                        if (_validator != "") {
                                          return _validator;
                                        }
                                      }),
                                    ],
                                  ),
                                ),
                              ),

                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(
                                      context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Map<String,dynamic> sessionUser = await getUserFromSession();
                                    if(!sessionUser['error']){
                                      Map<String,dynamic> user = sessionUser['data'];
                                      Map<String,dynamic> orderDetails = {
                                        "name":"${user['name']}",
                                        "email":"${user['email']}",
                                        "phone_no":"${user['phone_no']}",
                                        "address":"${user['address']}",
                                        "product_id":"${widget.productDetails['id']}",
                                        "image":"${selectedImage}",
                                        "color":"${selectedColor}",
                                        "quantity":"${quantityController.text}",
                                        "size":"${selectedSize}",
                                        "price":"${priceController.text}"
                                      };
                                      addBargainOrder(orderDetails, user['authToken']).then((value){
                                        Navigator.pop(context);
                                      });
                                    }
                                  },
                                  child: const Text('Send'),
                                ),
                              ],
                            ),
                      );

                    })),
                SizedBox(
                    width: size.width*0.42,
                    child: buildColorElevatedButton("Add To Cart", size, Colors.black,(){
                      print(selectedImage.isNotEmpty);
                      if(selectedImage.isNotEmpty && selectedSize.isNotEmpty && colors.isNotEmpty){
                        Map<String, dynamic> productCart={
                          "product_id":widget.productDetails['id'],
                          "image":selectedImage,
                          "size":selectedSize,
                          "color":selectedColor,
                          "quantity":"1",
                          "price":widget.productDetails['price'],
                          "userId":loggedInUser['id']
                        };
                        addProductToCart(productCart).then((value){
                          showToast("Product Added To Cart");
                        }).catchError((onError){
                        });
                      } else {
                        showToast("You Must Select Image, Size & Color");
                      }
                    })),
              ],
            ),
          ),
        ),

    ]
    );

  }
}
