import 'dart:convert';

import 'package:fashion_guru/controllers/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../components/elevatedbutton.dart';
import '../components/toast_message.dart';
import '../constants/server_config.dart';
import '../constants/textstyles.dart';
import '../controllers/cart.dart';
import '../controllers/session.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  Map<String,dynamic> deliveryDetails = {
    "name":"",
    "phone_no":"",
    "email":"",
    "address":"",
  };
  Map<String, dynamic>loggedInUser={};
  int totalPrice=0;
  List<dynamic> productList=[];

  @override
  void initState() {

    getUserFromSession().then((response) {
      if (response['error']) {
        showToast(response['e']);
      } else {
        getDataFromLocalStorage("deliveryDetails").then((result){
          setState(() {
            loggedInUser = response['data'];
            if(result!=null){
              Map<String,dynamic> sessionDeliveryDetails=jsonDecode(result!);
              deliveryDetails['name']=sessionDeliveryDetails['name'];
              deliveryDetails['email']=sessionDeliveryDetails['email'];
              deliveryDetails['phone_no']=sessionDeliveryDetails['phone_no'];
              deliveryDetails['address']=sessionDeliveryDetails['address'];
            } else {
              deliveryDetails['name']=loggedInUser['name'];
              deliveryDetails['email']=loggedInUser['email'];
              deliveryDetails['phone_no']=loggedInUser['phone_no'];
              deliveryDetails['address']=loggedInUser['address'];
            }
          });
        });
        getCartProducts(response['data']['id']).then((results){
          totalPrice=0;
          results['data']['cart'].forEach((cartItem) {
            if(cartItem['price']!=null) {
              num myPrice=cartItem['price'];
              totalPrice+=myPrice.toInt()*int.parse(cartItem['quantity']);
            }
          });

          setState(() {
            productList=results['data']['cart'];
          });
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
      children:[ Scaffold(
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
            'Checkout',
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
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                children: [
                  Container(
                    // padding: EdgeInsets.all(8),
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 10, // Blur radius
                          offset: Offset(0, 3), // Offset
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 12, top: 10, right: 12, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delivery Address',
                                style: TextStyle(
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3D3D3D),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setDataToLocalStorage("deliveryDetails", jsonEncode(deliveryDetails)).then((value){
                                    Navigator.pushNamed(context, 'DeliveryAddress');
                                  });

                                },
                                child: Icon(
                                  Icons.edit,
                                  size: size.width * 0.05,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Divider(
                            height: 1,
                            color: Colors.grey.shade400,
                            thickness: 1,
                          ),
                        ),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // color: Colors.grey.withOpacity(0.15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16, top: 10, right: 16, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${deliveryDetails['name']}',
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black.withOpacity(0.5),
                                    // overflow: TextOverflow.clip
                                  ),
                                ),
                                Text(
                                  '${deliveryDetails['phone_no']}',
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black.withOpacity(0.5),
                                    // overflow: TextOverflow.clip
                                  ),
                                ),
                                Text(
                                  '${deliveryDetails['email']}',
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black.withOpacity(0.5),
                                    // overflow: TextOverflow.clip
                                  ),
                                ),
                                Text(
                                  '${deliveryDetails['address']}',
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black.withOpacity(0.5),
                                    // overflow: TextOverflow.clip
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    // padding: EdgeInsets.all(8),
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 10, // Blur radius
                          offset: Offset(0, 3), // Offset
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 12, top: 10, right: 12, bottom: 10),
                          child: Text(
                            'Your Products',
                            style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3D3D3D),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Divider(
                            height: 1,
                            color: Colors.grey.shade400,
                            thickness: 1,
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: 310,
                          // height: size.height * 0.37,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // color: Colors.grey.withOpacity(0.15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16, top: 10, right: 0, bottom: 16),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: productList.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [Container(
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.only(right: 12, top: 8),
                                    width: 150,
                                    // width: size.width * 0.37,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // color: primaryColor.withOpacity(0.15),
                                      color: Colors.grey.shade50,
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 1,
                                          style: BorderStyle.solid),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(5),
                                          child: Image.network(
                                            'http://${ipAddress}/uploads/${productList[index]['image']}',

                                            height: size.height * 0.175
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.005,
                                        ),
                                        Text(
                                          '${productList[index]['product_name']}',
                                          style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF3D3D3D),
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        Text(
                                          '${productList[index]['category']}',
                                          style: TextStyle(
                                            fontSize: size.width * 0.033,
                                            color: Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Size: ',
                                              style: TextStyle(
                                                fontSize: size.width * 0.03,
                                                color:
                                                    Colors.black.withOpacity(0.5),
                                              ),
                                            ),
                                            Text(
                                              '${productList[index]['size']}',
                                              style: TextStyle(
                                                fontSize: size.width * 0.03,
                                                color:
                                                    Colors.black.withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Colors: ',
                                              style: TextStyle(
                                                fontSize: size.width * 0.03,
                                                color:
                                                    Colors.black.withOpacity(0.5),
                                              ),
                                            ),
                                            Container(
                                              // width: size.width * 0.2,
                                              child: Text(
                                                '${productList[index]['color']}',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.03,
                                                  color:
                                                      Colors.black.withOpacity(0.5),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Quantity: ',
                                              style: TextStyle(
                                                fontSize: size.width * 0.03,
                                                color:
                                                    Colors.black.withOpacity(0.5),
                                              ),
                                            ),
                                            Text(
                                              '${productList[index]['quantity']}',
                                              style: TextStyle(
                                                fontSize: size.width * 0.03,
                                                color:
                                                    Colors.black.withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Rs. ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: size.width * 0.04,
                                                color: primaryColor,
                                              ),
                                            ),
                                            Text(
                                              '${productList[index]['price']}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: size.width * 0.04,
                                                color: primaryColor,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                    Positioned(
                                      top: 0,
                                      right: 5,
                                      child: InkWell(
                                        onTap: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: const Text('Confirm Delete'),
                                                  content: Text(
                                                      'Are you sure you want to remove this item?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () => Navigator.pop(
                                                          context, 'Cancel'),
                                                      child: const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        DeleteCartProduct(productList[index]['id']).then((value){
                                                          getCartProducts(loggedInUser['id']).then((results){
                                                            totalPrice=0;
                                                            results['data']['cart'].forEach((cartItem) {
                                                              if(cartItem['price']!=null) {
                                                                num myPrice=cartItem['price'];
                                                                totalPrice+=myPrice.toInt()*int.parse(cartItem['quantity']);
                                                              }
                                                            });

                                                            setState(() {
                                                              productList=results['data']['cart'];
                                                            });
                                                          });

                                                        });
                                                        Navigator.pop(context, 'OK');
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                ),
                                          );
                                        },
                                        child: Icon(
                                          Icons.cancel_outlined,
                                          size: size.width * 0.055,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ),
                                ]
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    // padding: EdgeInsets.all(8),
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 10, // Blur radius
                          offset: Offset(0, 3), // Offset
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 12, top: 10, right: 12, bottom: 10),
                          child: Text(
                            'Payment Method',
                            style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3D3D3D),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Divider(
                            height: 1,
                            color: Colors.grey.shade400,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16, top: 10, right: 16, bottom: 10),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 12, top: 8, right: 12, bottom: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: primaryColor.withOpacity(0.1),
                              border: Border.all(
                                  color: primaryColor,
                                  width: 1,
                                  style: BorderStyle.solid),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      size: size.width * 0.05,
                                      color: primaryColor,
                                    ),
                                    SizedBox(width: size.width*0.01,),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cash On Delivery',
                                          style: TextStyle(
                                            fontSize: size.width * 0.045,
                                            color: textColor,
                                            fontWeight: FontWeight.bold,
                                            // overflow: TextOverflow.clip
                                          ),
                                        ),
                                        Text(
                                          '${totalPrice}',
                                          style: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: primaryColor,
                                            // overflow: TextOverflow.clip
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.025,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    'Pay when you receive',
                                    style: TextStyle(
                                      fontSize: size.width * 0.037,
                                      color: textColor,
                                      // overflow: TextOverflow.clip
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    // padding: EdgeInsets.all(8),
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25), // Shadow color
                          spreadRadius: 2, // Spread radius
                          blurRadius: 10, // Blur radius
                          offset: Offset(0, 3), // Offset
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 12, top: 10, right: 12, bottom: 10),
                          child: Text(
                            'Order Summary',
                            style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3D3D3D),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Divider(
                            height: 1,
                            color: Colors.grey.shade400,
                            thickness: 1,
                          ),
                        ),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // color: Colors.grey.withOpacity(0.15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16, top: 10, right: 16, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Items Total',
                                      style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: textColor,
                                        // overflow: TextOverflow.clip
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Rs. ',
                                          style: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: textColor,
                                            // overflow: TextOverflow.clip
                                          ),
                                        ),
                                        Text(
                                          '$totalPrice',
                                          style: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: textColor,
                                            overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height*0.005,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Delivery Fee',
                                      style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: textColor,
                                        // overflow: TextOverflow.clip
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Rs. ',
                                          style: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: textColor,
                                            // overflow: TextOverflow.clip
                                          ),
                                        ),
                                        Text(
                                          '100',
                                          style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              color: textColor,
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height*0.005,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Payment',
                                      style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: textColor,
                                        // overflow: TextOverflow.clip
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Rs. ',
                                          style: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: textColor,
                                            // overflow: TextOverflow.clip
                                          ),
                                        ),
                                        Text(
                                          '${totalPrice+100}',
                                          style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              color: textColor,
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
        Positioned(
          bottom: 50,
          child: Container(
            padding: EdgeInsets.all(15),
            width: size.width,
            // height: size.height*0.1,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Price',
                      style: TextStyle(
                        fontSize: size.width * 0.037,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.5),
                        // overflow: TextOverflow.ellipsis
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Rs ',
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            // overflow: TextOverflow.ellipsis
                          ),
                        ),
                        Text(
                          '$totalPrice',
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                    width: size.width*0.5,
                    child: buildElevatedButton("Place Order", size, (){
                      Map<String,dynamic> formData={
                        "name":deliveryDetails['name'],
                        "address":deliveryDetails['address'],
                        "email":deliveryDetails['email'],
                        "phone_no":deliveryDetails['phone_no'],
                        "userId":loggedInUser['id'],
                        "cartDetails":productList.map((item) => item['id']).toList()
                      };

                      addOrderFromCart(formData).then((value){
                        Navigator.pushNamedAndRemoveUntil(context, 'OrderHistory',ModalRoute.withName('MyCart'));
                      });

                    }))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
