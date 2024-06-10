import 'package:fashion_guru/controllers/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../components/bottom_navigation_bar.dart';
import '../components/toast_message.dart';
import '../constants/server_config.dart';
import '../constants/textstyles.dart';
import '../components/elevatedbutton.dart';
import '../controllers/session.dart';

const inactiveColor = Colors.white;
const activeEditColor = Color(0xFF3D3D3D);
const activeDeleteColor = Colors.red;
const activeContainerColor = Color(0xFFE3F2FE);

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  Color deleteIconColor = inactiveColor;
  Color containerColor = inactiveColor;
  List<dynamic> productList=[];
  Map<String, dynamic>loggedInUser={};
  int totalPrice=0;
  Map<String,dynamic> productQuantity={};

  @override
  void initState() {
    getUserFromSession().then((response) {
      if (response['error']) {
        showToast(response['e']);
      } else {
        getCartProducts(response['data']['id']).then((results){

          totalPrice=0;
          results['data']['cart'].forEach((cartItem) {
            if(cartItem['price']!=null) {
              num myPrice=cartItem['price'];
              totalPrice+=myPrice.toInt()*int.parse(cartItem['quantity']);
              productQuantity[cartItem['id']]=int.parse(cartItem['quantity']);
            }
          });

          setState(() {
            loggedInUser = response['data'];
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
      children: [Scaffold(
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
            'My Cart',
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
          child:SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: size.width,
                          margin: EdgeInsets.only(bottom: 5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  'http://${ipAddress}/uploads/${productList[index]['image']}',
                                  height: size.height * 0.085,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${productList[index]['product_name']}',
                                            style: TextStyle(
                                                fontSize: size.width * 0.04,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF3D3D3D),
                                                overflow: TextOverflow.ellipsis),
                                          ),
                                          InkWell(
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.black.withOpacity(0.4),
                                              size: size.width * 0.05,
                                            ),
                                            onTap: () => showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: const Text('Confirm Delete'),
                                                content: Text(
                                                    'Are you sure you want to delete?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(
                                                        context, 'Cancel'),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      productQuantity.remove(productList[index]['id']);
                                                      DeleteCartProduct(productList[index]['id']).then((value){
                                                        getCartProducts(loggedInUser['id']).then((results){

                                                          totalPrice=0;
                                                          results['data']['cart'].forEach((cartItem) {
                                                            if(cartItem['price']!=null) {
                                                              num myPrice=cartItem['price'];
                                                              totalPrice+=myPrice.toInt()*int.parse(cartItem['quantity']);
                                                              productQuantity[cartItem['id']]=int.parse(cartItem['quantity']);
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
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: size.height*0.005,),
                                      Text(
                                        '${productList[index]['category']}',
                                        style: TextStyle(
                                          fontSize: size.width * 0.032,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                      SizedBox(height: size.height*0.005,),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Rs ',
                                                style: TextStyle(
                                                    fontSize: size.width * 0.04,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFF5A811),
                                                    overflow: TextOverflow.ellipsis),
                                              ),
                                              Text(
                                                '${productList[index]['price']}',
                                                style: TextStyle(
                                                    fontSize: size.width * 0.04,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFF5A811),
                                                    overflow: TextOverflow.ellipsis),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    totalPrice=0;
                                                    (productQuantity[productList[index]['id']]>0)?productQuantity[productList[index]['id']]--:0;
                                                    productList.forEach((product) {
                                                      num myPrice=product['price'];
                                                      num myQuantity=productQuantity[product['id']];
                                                      totalPrice+=myPrice.toInt()*myQuantity.toInt();
                                                    });
                                                    });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(0),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: size.width * 0.05,
                                                  ),),
                                                  // color: primaryColor,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(3),
                                                      color: primaryColor),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                child: Text(
                                                  "${productQuantity[productList[index]['id']].toString()}",
                                                  style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: size.width * 0.045,
                                                    // fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                  onTap: (){
                                                    setState(() {
                                                    totalPrice=0;
                                                    (productQuantity[productList[index]['id']]>0)?productQuantity[productList[index]['id']]++:0;
                                                      productList.forEach((product) {
                                                      num myPrice=product['price'];
                                                      num myQuantity=productQuantity[product['id']];
                                                      totalPrice+=myPrice.toInt()*myQuantity.toInt();
                                                    });
                                                    });
                                                  },
                                                child: Container(
                                                  padding: EdgeInsets.all(0),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: size.width * 0.05,
                                                  )),
                                                  // color: primaryColor,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(3),
                                                      color: primaryColor),
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
                        );
                      },
                    ),
                    SizedBox(
                      height: size.height*0.1,
                    ),
                  ],
                ),
              ),
            ),


        ),
        bottomNavigationBar: Custom_Navigator(selectedIndex: 1),
      ),
        Positioned(
          bottom: 56,
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
                              fontWeight: FontWeight.w600,
                              color: textColor,
                              // overflow: TextOverflow.ellipsis
                            ),
                        ),
                        Text(
                          '${totalPrice.toString()}',
                          style: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.w600,
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
                    child: buildElevatedButton("Checkout", size, (){
                      UpdateQuantityInCart(productQuantity).then((value){
                        Navigator.pushNamed(context, 'CheckoutScreen');
                      });
                    }))
              ],
            ),
          ),
        ),
    ],);
  }
}
