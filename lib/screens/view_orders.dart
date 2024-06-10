import 'package:fashion_guru/controllers/order.dart';
import 'package:fashion_guru/screens/order_details_screen.dart';
import 'package:fashion_guru/screens/order_history_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashion_guru/components/color_elevated_button.dart';

import '../components/toast_message.dart';
import '../constants/server_config.dart';
import '../constants/textstyles.dart';
import '../controllers/session.dart';

class ViewOrders extends StatefulWidget {
  const ViewOrders({super.key});

  @override
  State<ViewOrders> createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
  Map<String, dynamic> loggedInUser = {};
  Map<String, dynamic> ordersList = {};
  Map<String, dynamic> getDeliveryStatus = {
    "Pending" : {
      "icon" : Icons.access_time_outlined,
      "text" : "Pending",
      "color" : Colors.grey
    },
    "Bargain" : {
      "icon" : Icons.handshake_outlined,
      "text" : "Bargain",
      "color" : Colors.orange
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserFromSession().then((response) {
      if (response['error']) {
        showToast(response['e']);
      } else {
        getVendorOrders(response['data']['authToken']).then((value) {
          setState(() {
            loggedInUser = response['data'];
            ordersList['pendingOrder'] = value['data']['pendingOrder'];
            ordersList['acceptedOrder'] = value['data']['acceptedOrder'];
            ordersList['deliveredOrder'] = value['data']['deliveredOrder'];
            ordersList['declinedOrder'] = value['data']['declinedOrder'];
          });
        });
        // ordersList=;
      }
    });
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
          'View Orders',
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
            padding: EdgeInsets.only(left: 0, right: 0, top: 10),
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Color(0xFF3D3D3D),
                    unselectedLabelColor: Colors.black.withOpacity(0.5),
                    tabs: [
                      Tab(
                        child: Text(
                          'Pending',
                          style: TextStyle(
                            fontSize: size.width * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Accepted',
                          style: TextStyle(
                            fontSize: size.width * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Delivered',
                          style: TextStyle(
                            fontSize: size.width * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Declined',
                          style: TextStyle(
                            fontSize: size.width * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.only(top: 8, left: 10, right: 10),
                    // color: Colors.deepOrange,
                    height: size.height * 0.8,
                    child: TabBarView(children: [
                      // Pending List
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: (ordersList['pendingOrder'] != null)
                            ? ordersList['pendingOrder']!.length
                            : 0,
                        itemBuilder: (context, index) {
                          final item = ordersList['pendingOrder']?[index];
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(id: item['id'])));
                            },
                            child: Container(
                                width: size.width,
                                margin: EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      style: BorderStyle.solid,
                                      width: 1,
                                    )),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
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
                                                'Order #${item['orderId']}',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.04,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF3D3D3D),
                                                ),
                                              ),
                                              Text(
                                                'Added on ${formatDateString(item['timeAdded'])}',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.035,
                                                  color:
                                                  Colors.black.withOpacity(0.5),
                                                ),
                                              ),
                                              // For After Paid Date
                                              // Text('',style: TextStyle(
                                              //   fontSize: size.width * 0.035,
                                              //   color:
                                              //   Colors.black.withOpacity(0.5),
                                              // ),),
                                            ],
                                          ),
                                          // For After Paid Date
                                          // Text('Unpaid',style: TextStyle(
                                          //     fontSize: size.width * 0.03,
                                          //     fontStyle: FontStyle.italic,
                                          //     color: Colors.grey
                                          //   // color: Colors.black.withOpacity(0.5),
                                          // ),),
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              child: Container(
                                                child: Image.network(
                                                  'http://${ipAddress}/uploads/${item['image']}',
                                                  width: size.width * 0.25,
                                                  height: size.height * 0.1,
                                                ),
                                                // color: primaryColor,
                                              )),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(left: 8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    item['product_name'],
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
                                                    item['category'],
                                                    style: TextStyle(
                                                      fontSize: size.width * 0.035,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
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
                                                          fontSize:
                                                          size.width * 0.035,
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                        ),
                                                      ),
                                                      Text(
                                                        item['quantity'],
                                                        style: TextStyle(
                                                          fontSize:
                                                          size.width * 0.035,
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
                                                    'Rs. ${item['price']}',
                                                    style: TextStyle(
                                                        fontSize:
                                                        size.width * 0.045,
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
                                          left: 12, top: 8, right: 12, bottom: 8),
                                      child: Divider(
                                        height: 1,
                                        color: Colors.grey.shade300,
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                getDeliveryStatus[item['status']]['icon'],
                                                color: getDeliveryStatus[item['status']]['color'],
                                                size: size.width * 0.045,
                                              ),
                                              Text(
                                                '${getDeliveryStatus[item['status']]['text']}',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.04,
                                                  fontStyle: FontStyle.italic,
                                                  color: getDeliveryStatus[item['status']]['color'],
                                                  // color: Colors.black.withOpacity(0.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Total:  ',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.04,
                                                  color: textColor,
                                                ),
                                              ),
                                              Text(
                                                'Rs. ${int.parse(item['price']) * int.parse(item['quantity'])}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: size.width * 0.045,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: size.width * 0.42,
                                                child: buildColorElevatedButton(
                                                    "Accept", size, Colors.green,
                                                        () {
                                                      changeVendorOrderStatus(
                                                          loggedInUser['authToken'],
                                                          item['id'],
                                                          'Accepted')
                                                          .then((response) {
                                                        setState(() {
                                                          ordersList = response['data'];
                                                        });
                                                      });
                                                    }),
                                              ),
                                              // SizedBox(
                                              //   width: size.width*0.03,
                                              // ),
                                              SizedBox(
                                                width: size.width * 0.42,
                                                child: buildColorElevatedButton(
                                                    "Decline", size, Colors.red,
                                                        () {
                                                      changeVendorOrderStatus(
                                                          loggedInUser['authToken'],
                                                          item['id'],
                                                          'Declined')
                                                          .then((response) {
                                                        setState(() {
                                                          ordersList = response['data'];
                                                        });
                                                      });
                                                    }),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          )
                          );
                        },
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: (ordersList['acceptedOrder'] != null)
                            ? ordersList['acceptedOrder']!.length
                            : 0,
                        itemBuilder: (context, index) {
                          final item = ordersList['acceptedOrder'][index];
                          // final value = orderList[key];
                          return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(id: item['id'])));
                              },
                              child:Container(
                            width: size.width,
                            margin: EdgeInsets.only(bottom: 12),
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  style: BorderStyle.solid,
                                  width: 1,
                                )),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
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
                                            'Order #${item['orderId']}',
                                            style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF3D3D3D),
                                            ),
                                          ),
                                          Text(
                                            'Placed on ${formatDateString(item['timeAdded'])}',
                                            style: TextStyle(
                                              fontSize: size.width * 0.035,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          // For After Paid Date
                                          // Text('',style: TextStyle(
                                          //   fontSize: size.width * 0.035,
                                          //   color:
                                          //   Colors.black.withOpacity(0.5),
                                          // ),),
                                        ],
                                      ),
                                      // For After Paid Date
                                      // Text('Unpaid',style: TextStyle(
                                      //     fontSize: size.width * 0.03,
                                      //     fontStyle: FontStyle.italic,
                                      //     color: Colors.grey
                                      //   // color: Colors.black.withOpacity(0.5),
                                      // ),),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                            child: Image.network(
                                              'http://${ipAddress}/uploads/${item['image']}',
                                              width: size.width * 0.25,
                                              height: size.height * 0.1,
                                            ),
                                            // color: primaryColor,
                                          )),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                '${item['product_name']}',
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
                                                '${item['category']}',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.035,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
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
                                                      fontSize:
                                                          size.width * 0.035,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${item['quantity']}',
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.035,
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
                                                'Rs. ${item['price']}',
                                                style: TextStyle(
                                                    fontSize:
                                                        size.width * 0.045,
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
                                      left: 12, top: 8, right: 12, bottom: 8),
                                  child: Divider(
                                    height: 1,
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.4,
                                        child: buildColorElevatedButton(
                                            "Delivered", size, Colors.green, () {
                                          changeVendorOrderStatus(
                                                  loggedInUser['authToken'],
                                                  item['id'],
                                                  'Delivered')
                                              .then((response) {
                                            setState(() {
                                              ordersList = response['data'];
                                            });
                                          });
                                        }),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Accepted',
                                            style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.green,
                                              // color: Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.access_time_outlined,
                                                color: Colors.grey,
                                                size: size.width * 0.045,
                                              ),
                                              Text(
                                                'In Process',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.04,
                                                  fontStyle: FontStyle.italic,
                                                  color: Colors.grey,
                                                  // color: Colors.black.withOpacity(0.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Total:  ',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.04,
                                                  color: textColor,
                                                ),
                                              ),
                                              Text(
                                                'Rs. ${int.parse(item['price']) * int.parse(item['quantity'])}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: size.width * 0.045,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
                        },
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: (ordersList['deliveredOrder'] != null)
                            ? ordersList['deliveredOrder']!.length
                            : 0,
                        itemBuilder: (context, index) {
                          final item = ordersList['deliveredOrder'][index];
                          // final value = orderList[key];
                          return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(id: item['id'])));
                              },
                              child:Container(
                            width: size.width,
                            margin: EdgeInsets.only(bottom: 12),
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  style: BorderStyle.solid,
                                  width: 1,
                                )),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
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
                                            'Order #${item['orderId']}',
                                            style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF3D3D3D),
                                            ),
                                          ),
                                          Text(
                                            'Placed on ${formatDateString(item['timeAdded'])}',
                                            style: TextStyle(
                                              fontSize: size.width * 0.035,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          // Text(
                                          //   'Paid on 12 Nov 2023',
                                          //   style: TextStyle(
                                          //     fontSize: size.width * 0.035,
                                          //     color:
                                          //         Colors.black.withOpacity(0.5),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      Text(
                                        'Paid',
                                        style: TextStyle(
                                          fontSize: size.width * 0.03,
                                          fontStyle: FontStyle.italic,
                                          color: primaryColor,
                                          // color: Colors.black.withOpacity(0.5),
                                        ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                            child: Image.network(
                                              'http://${ipAddress}/uploads/${item['image']}',
                                              width: size.width * 0.25,
                                              height: size.height * 0.1,
                                            ),
                                            // color: primaryColor,
                                          )),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                '${item['product_name']}',
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
                                                '${item['category']}',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.035,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
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
                                                      fontSize:
                                                          size.width * 0.035,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${item['quantity']}',
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.035,
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
                                                'Rs. ${item['price']}',
                                                style: TextStyle(
                                                    fontSize:
                                                        size.width * 0.045,
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
                                      left: 12, top: 8, right: 12, bottom: 8),
                                  child: Divider(
                                    height: 1,
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.check,
                                            color: Colors.green,
                                            size: size.width * 0.045,
                                          ),
                                          Text(
                                            'Delivered',
                                            style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.green,
                                              // color: Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Total:  ',
                                            style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              color: textColor,
                                            ),
                                          ),
                                          Text(
                                            'Rs. ${int.parse(item['price'])*int.parse(item['quantity'])}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: size.width * 0.045,
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
                          ));
                        },
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: (ordersList['declinedOrder'] != null)
                            ? ordersList['declinedOrder']!.length
                            : 0,
                        itemBuilder: (context, index) {
                          final item = ordersList['declinedOrder'][index];
                          // final value = orderList[key];
                          return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailScreen(id: item['id'])));
                              },
                              child:Container(
                            width: size.width,
                            margin: EdgeInsets.only(bottom: 12),
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  style: BorderStyle.solid,
                                  width: 1,
                                )),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
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
                                            'Order #${item['orderId']}',
                                            style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF3D3D3D),
                                            ),
                                          ),
                                          Text(
                                            'Requested on ${formatDateString(item['timeAdded'])}',
                                            style: TextStyle(
                                              fontSize: size.width * 0.035,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                          // For After Paid Date
                                          // Text('',style: TextStyle(
                                          //   fontSize: size.width * 0.035,
                                          //   color:
                                          //   Colors.black.withOpacity(0.5),
                                          // ),),
                                        ],
                                      ),
                                      // For After Paid Date
                                      // Text('Unpaid',style: TextStyle(
                                      //     fontSize: size.width * 0.03,
                                      //     fontStyle: FontStyle.italic,
                                      //     color: Colors.grey
                                      //   // color: Colors.black.withOpacity(0.5),
                                      // ),),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                            child: Image.network(
                                              'http://${ipAddress}/uploads/${item['image']}',
                                              width: size.width * 0.25,
                                              height: size.height * 0.1,
                                            ),
                                            // color: primaryColor,
                                          )),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                '${item['product_name']}',
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
                                                '${item['category']}',
                                                style: TextStyle(
                                                  fontSize: size.width * 0.035,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
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
                                                      fontSize:
                                                          size.width * 0.035,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${item['quantity']}',
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.035,
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
                                                'Rs. ${item['price']}',
                                                style: TextStyle(
                                                    fontSize:
                                                        size.width * 0.045,
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
                                      left: 12, top: 8, right: 12, bottom: 8),
                                  child: Divider(
                                    height: 1,
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Declined',
                                        style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.red,
                                          // color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Total:  ',
                                            style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              color: textColor,
                                            ),
                                          ),
                                          Text(
                                            'Rs. ${int.parse(item['price'])*int.parse(item['quantity'])}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: size.width * 0.045,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: size.width * 0.42,
                                        child: buildColorElevatedButton(
                                            "Accept",
                                            size,
                                            Colors.green,
                                            () => null),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
                        },
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
