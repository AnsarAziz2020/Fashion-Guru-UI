import 'package:fashion_guru/components/searchfield.dart';
import 'package:fashion_guru/controllers/order.dart';
import 'package:fashion_guru/screens/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../components/bottom_navigation_bar.dart';
import '../components/delivery_address_fields.dart';
import '../components/toast_message.dart';
import '../constants/server_config.dart';
import '../constants/textstyles.dart';
import '../controllers/session.dart';
import '../services/validators.dart';
import '../controllers/order.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'admin_order_detail_screen.dart';

class AdminViewOrderScreen extends StatefulWidget {
  const AdminViewOrderScreen({super.key});

  @override
  State<AdminViewOrderScreen> createState() => _AdminViewOrderScreenState();
}

class _AdminViewOrderScreenState extends State<AdminViewOrderScreen> {

  int quantity = 1;
  Map<String, dynamic> loggedInUser = {};
  List<dynamic> orderList = [];
  List<dynamic> orderIds = [];
  int orderListLength = 0;
  Map<String, dynamic> orderTotalPrice = {};

  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> getDeliveryStatus = {
    "Bargain" : {
      "icon" : Icons.handshake_outlined,
      "text" : "Bargain",
      "color" : Colors.orange
    },
    "Pending" : {
      "icon" : Icons.access_time_outlined,
      "text" : "Pending",
      "color" : Colors.grey
    },
    "Accepted" : {
      "icon" : Icons.check,
      "text" : "Accepted",
      "color" : Colors.green
    },
    "Delivered" : {
      "icon" : Icons.delivery_dining,
      "text" : "Delivered",
      "color" : Colors.green
    },
    "Declined" : {
      "icon" : Icons.close,
      "text" : "Declined",
      "color" : Colors.red
    },
  };

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {

    getUserFromSession().then((response) {
      if (response['error']) {
        showToast(response['e']);
      } else {
        getAdminOrders(response['data']['authToken']).then((result) {
          if (response['error']) {
            showToast(response['e']);
          } else {
            setState(() {
              orderList = result['data']['order'];
              orderListLength = orderList.length;
              loggedInUser = response['data'];
            });
          }
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
          'All Orders',
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
                  child: buildSearchField(
                      "Search...",

                      IconButton(
                        icon: Icon(
                          Icons.search,
                          // color: Colors.transparent,
                          size: size.width * 0.06,
                        ),
                        onPressed: () async {
                          Map<String,dynamic> orders = await searchOrders(searchController.text);
                          setState(() {
                            orderList = orders['data']['results'];
                            orderListLength = orderList.length;
                          });
                        },
                      ),
                      searchController,
                      false, (value) {
                    String _validator = emailValidate(value);
                    if (_validator != "") {
                      return _validator;
                    }
                  }, size),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: orderListLength,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AdminOrderDetailScreen(
                                  orderDetails: orderList[index],loggedInUser: loggedInUser,);
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: size.width,
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.shade200,
                              style: BorderStyle.solid,
                              width: 1,
                            )
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.25), // Shadow color
                          //     spreadRadius: 3, // Spread radius
                          //     blurRadius: 8, // Blur radius
                          //     offset: Offset(0, 3), // Offset
                          //   ),
                          // ],
                        ),
                        child: Column(
                          children: [

                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order #${orderList[index]['orderId']}',
                                        style: TextStyle(
                                          fontSize: size.width * 0.040,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF3D3D3D),
                                        ),
                                      ),
                                      Text(
                                        'Placed on ${formatDateString(orderList[index]['timeAdded'])}',
                                        style: TextStyle(
                                          fontSize: size.width * 0.035,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 8, right: 12, bottom: 8),
                              child: Divider(
                                height: 1,
                                color: Colors.grey.shade300,
                                thickness: 1,
                              ),
                            ),
                            Container(
                              width: size.width,
                              padding: EdgeInsets.only(
                                  left: 12, top: 8, right: 12, bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        child: Image.network(
                                          'http://${ipAddress}/uploads/${orderList[index]['image']}',
                                          width: size.width * 0.25,
                                          height: size.height * 0.1,
                                        ),
                                        // color: primaryColor,
                                      )),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '${orderList[index]['product_name']}',
                                            style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF3D3D3D),
                                              // overflow: TextOverflow.ellipsis),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: size.height*0.005,
                                          // ),
                                          Text(
                                            '${orderList[index]['category']}',
                                            style: TextStyle(
                                              fontSize: size.width * 0.035,
                                              color:
                                              Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: size.height*0.005,
                                          // ),
                                          Row(
                                            children: [
                                              Text(
                                                'Quantity: ',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.035,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                              Text(
                                                '${orderList[index]['quantity']}',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.035,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: size.height * 0.005,
                                          ),
                                          Text(
                                            'Rs. ${orderList[index]['price']}',
                                            style: TextStyle(
                                                fontSize: size.width * 0.045,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFFF5A811),
                                                overflow:
                                                TextOverflow.ellipsis),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 0, right: 12, bottom: 8),
                              child: Divider(
                                height: 1,
                                color: Colors.grey.shade300,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        getDeliveryStatus[orderList[index]['status']]['icon'],
                                        color: getDeliveryStatus[orderList[index]['status']]['color'],
                                        size: size.width * 0.045,
                                      ),
                                      Text(
                                        '${getDeliveryStatus[orderList[index]['status']]['text']}',
                                        style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          fontStyle: FontStyle.italic,
                                          color: getDeliveryStatus[orderList[index]['status']]['color'],
                                          // color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Total:  ',
                                        style: TextStyle(
                                          fontSize: size.width * 0.045,
                                          color: textColor,
                                        ),
                                      ),
                                      Text(
                                        'Rs. ${int.parse(orderList[index]['price']) * int.parse(orderList[index]['quantity'])} ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.width * 0.05,
                                          color: primaryColor,
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Custom_Navigator(selectedIndex: 2),
    );
  }
}


String formatDateString(String dateString) {
  List<String> parts = dateString.split('T');
  String datePart = parts[0];
  String timePart = parts[1];

  List<String> dateComponents = datePart.split('-');
  List<String> timeComponents = timePart.split(':');

  String year = dateComponents[0];
  String month = dateComponents[1];
  String day = dateComponents[2];

  String hour = timeComponents[0];
  String minute = timeComponents[1];
  String second = timeComponents[2].split(".")[0];
  return '$day ${monthNoToMonth(month)} $year $hour:$minute:$second';
}

String monthNoToMonth(String monthNo) {
  Map<String, dynamic> months = {
    "01": "Jan",
    "02": "Feb",
    "03": "Mar",
    "04": "Apr",
    "05": "May",
    "06": "Jun",
    "07": "Jul",
    "08": "Aug",
    "09": "Sep",
    "10": "Oct",
    "11": "Nov",
    "12": "Dec",
  };
  return months[monthNo];
}
