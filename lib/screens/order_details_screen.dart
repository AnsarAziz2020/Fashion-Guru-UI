
import 'package:fashion_guru/screens/order_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../components/elevatedbutton.dart';
import '../components/toast_message.dart';
import '../constants/server_config.dart';
import '../constants/textstyles.dart';
import '../controllers/order.dart';

class OrderDetailScreen extends StatefulWidget {
  final String id;
  const OrderDetailScreen({super.key, required this.id});


  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

  String deliveredText= "Delivered";
  String pendingText= "Pending";
  String acceptedText= "Accepted";
  String declinedText= "Declined";
  Color deliveredColor= Colors.green;
  Color pendingColor= Colors.grey;
  Color acceptedColor= Colors.green;
  Color declinedColor= Colors.red;
  Icon deliveredIcon = Icon(Icons.check);
  Icon pendingIcon = Icon(Icons.access_time_outlined);
  String deliveryStatusText = "";
  Color deliveryStatusColor = Colors.grey;
  Icon statusIcon = Icon(Icons.access_time_outlined);

  int quantity = 1;

  void getDeliveryStatus (String status){
  if(status == "Delivered")
    {
      setState(() {
        deliveryStatusText=deliveredText;
        deliveryStatusColor=deliveredColor;
        statusIcon = deliveredIcon;
      });
    }
  else if(status == "Pending")
    {
      setState(() {
        deliveryStatusText=pendingText;
        deliveryStatusColor=pendingColor;
        statusIcon=pendingIcon;
      });
    }
  else if(status == "Accepted")
    {
      setState(() {
        deliveryStatusText=acceptedText;
        deliveryStatusColor=acceptedColor;
        statusIcon=pendingIcon;
      });
    }
  else if(status == "Declined")
    {
      setState(() {
        deliveryStatusText=declinedText;
        deliveryStatusColor=declinedColor;
        statusIcon=pendingIcon;
      });
    }
  else
    {
      setState(() {
        deliveryStatusText="No Status";
        deliveryStatusColor=Colors.red;
      });
    }
  }
  Map<String, dynamic> loggedInUser = {};
  Map<String,dynamic> orderDetails={
    "id": '',
    "orderId": '',
    "timeAdded": '',
    "userId": '',
    "name": '',
    "email": '',
    "phone_no": '',
    "address": '',
    "product_id": '',
    "image": '',
    "color": '',
    "quantity": '0',
    "size": '',
    "price": '0',
    "product_name": '',
    "category": '',
    "status":''
  };
  List<dynamic> orderIds=[];
  Map<String,dynamic> orderTotalPrice={};

  @override
  void initState() {
    if(widget.id!=null){
      getOrderById(widget.id).then((result){
        
        if (result['error']) {
          showToast(result['e']);
        } else {
          setState(() {
            orderDetails=result['data']['order'];
            loggedInUser = result['data'];
            getDeliveryStatus('${orderDetails['status']}');
          });
        }
      });
    }


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
            'Order Details',
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
                      border: Border.all(color: Colors.grey.shade200, style: BorderStyle.solid,width: 1,),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.25), // Shadow color
                      //     spreadRadius: 2, // Spread radius
                      //     blurRadius: 10, // Blur radius
                      //     offset: Offset(0, 3), // Offset
                      //   ),
                      // ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 12, top: 10, right: 12, bottom: 10),
                          child: Text(
                            'Delivery Address',
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
                                Text(
                                  orderDetails['name'],
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black.withOpacity(0.5),
                                    // overflow: TextOverflow.clip
                                  ),
                                ),
                                Text(
                                  orderDetails['phone_no'],
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black.withOpacity(0.5),
                                    // overflow: TextOverflow.clip
                                  ),
                                ),
                                Text(
                                  orderDetails['email'],
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    color: Colors.black.withOpacity(0.5),
                                    // overflow: TextOverflow.clip
                                  ),
                                ),
                                Text(
                                  orderDetails['address'],
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
                      border: Border.all(color: Colors.grey.shade200, style: BorderStyle.solid,width: 1,),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.25), // Shadow color
                      //     spreadRadius: 2, // Spread radius
                      //     blurRadius: 10, // Blur radius
                      //     offset: Offset(0, 3), // Offset
                      //   ),
                      // ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 12, top: 10, right: 12, bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Order #${orderDetails['orderId']}',style: TextStyle(
                                    fontSize: size.width * 0.040,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3D3D3D),
                                  ),),
                                  Text('Placed on ${(orderDetails['timeAdded']!="")?formatDateString(orderDetails['timeAdded']):""}',style: TextStyle(
                                    fontSize: size.width * 0.035,
                                    color:
                                    Colors.black.withOpacity(0.5),
                                  ),),
                                  // Text('Paid on 21 Aug 2023 15:03:23',style: TextStyle(
                                  //   fontSize: size.width * 0.035,
                                  //   color:
                                  //   Colors.black.withOpacity(0.5),
                                  // ),),
                                ],
                              ),
                              // Text('Paid',style: TextStyle(
                              //     fontSize: size.width * 0.04,
                              //     fontStyle: FontStyle.italic,
                              //     color: primaryColor
                              //   // color: Colors.black.withOpacity(0.5),
                              // ),),
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
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16, top: 10, right: 16, bottom: 10),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            // width: size.width,
                            // width: size.width * 0.37,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              // color: primaryColor.withOpacity(0.15),
                              // color: Colors.grey.shade100,
                              border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                  style: BorderStyle.solid),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: (orderDetails['image']!="")?Image.network(
                                    'http://${ipAddress}/uploads/${orderDetails['image']}',
                                    width: size.width*0.25,
                                    // height: size.height * 0.1,
                                  ):null
                                ),
                                SizedBox(width: size.width*0.025,),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.005,
                                    ),
                                    Text(
                                      '${orderDetails['product_name']}',
                                      style: TextStyle(
                                        fontSize: size.width * 0.040,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF3D3D3D),
                                        overflow: TextOverflow.ellipsis,

                                      ),
                                    ),
                                    Text(
                                      '${orderDetails['category']}',
                                      style: TextStyle(
                                        fontSize: size.width * 0.037,
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
                                            fontSize: size.width * 0.037,
                                            color:
                                            Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                        Text(
                                          '${orderDetails['size']}',
                                          style: TextStyle(
                                            fontSize: size.width * 0.037,
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
                                            fontSize: size.width * 0.037,
                                            color:
                                            Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                        Container(
                                          // width: size.width * 0.2,
                                          child: Text(
                                            '${orderDetails['color']}',
                                            style: TextStyle(
                                              fontSize: size.width * 0.037,
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
                                            fontSize: size.width * 0.037,
                                            color:
                                            Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                        Text(
                                          '${orderDetails['quantity']}',
                                          style: TextStyle(
                                            fontSize: size.width * 0.037,
                                            color:
                                            Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        'Rs. ${orderDetails['price']}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: size.width * 0.045,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
                              left: 12, top: 10, right: 12, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Icon(
                              //   Icons.check,
                              //   color: Colors.green,
                              //   size: size.width * 0.045,
                              // ),
                              // getDeliveryStatus('${orderDetails['status']}')
                              Text(deliveryStatusText,style: TextStyle(
                                fontSize: size.width * 0.04,
                                fontStyle: FontStyle.italic,
                                color: deliveryStatusColor,
                                // color: Colors.black.withOpacity(0.5),
                              ),),
                            ],
                          ),),
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
                      border: Border.all(color: Colors.grey.shade200, style: BorderStyle.solid,width: 1,),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.25), // Shadow color
                      //     spreadRadius: 2, // Spread radius
                      //     blurRadius: 10, // Blur radius
                      //     offset: Offset(0, 3), // Offset
                      //   ),
                      // ],
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
                                          '${int.parse(orderDetails['price'])*int.parse(orderDetails['quantity'])}',
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
                                          '${int.parse(orderDetails['price'])+100}',
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
                              left: 12, top: 10, right: 12, bottom: 10),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text('Payed by Cash on Delivery',style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontStyle: FontStyle.italic,
                              color: Colors.black.withOpacity(0.5),
                              // color: Colors.black.withOpacity(0.5),
                            ),),
                          ),),
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
