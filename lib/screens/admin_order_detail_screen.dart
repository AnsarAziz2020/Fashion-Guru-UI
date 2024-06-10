import 'package:fashion_guru/screens/admin_view_order_screen.dart';
import 'package:fashion_guru/screens/order_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../components/color_elevated_button.dart';
import '../components/elevatedbutton.dart';
import '../components/toast_message.dart';
import '../constants/server_config.dart';
import '../constants/textstyles.dart';
import '../controllers/order.dart';

class AdminOrderDetailScreen extends StatefulWidget {
  final Map<String, dynamic> orderDetails;
  final Map<String, dynamic> loggedInUser;
  const AdminOrderDetailScreen({super.key, required this.orderDetails, required this.loggedInUser});

  @override
  State<AdminOrderDetailScreen> createState() => _AdminOrderDetailScreenState();
}

class _AdminOrderDetailScreenState extends State<AdminOrderDetailScreen> {
  String _selectedStatus = "Pending";
  List<String> statusOptions = ['Pending', 'Accepted', 'Delivered', 'Declined','Bargain'];
  Map<String, Color> statusColors = {
    'Declined': Colors.red,
    'Accepted': Colors.green,
    'Pending': Colors.grey,
    'Delivered': Colors.green,
    'Bargain' : Colors.orange
  };

  // Map<String, dynamic> widget.orderDetails = {};
  List<dynamic> orderIds = [];
  Map<String, dynamic> orderTotalPrice = {};

  @override
  void initState() {
    _selectedStatus = widget.orderDetails['status'];

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
                    border: Border.all(
                      color: Colors.grey.shade200,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
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
                                widget.orderDetails['name'],
                                style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  color: Colors.black.withOpacity(0.5),
                                  // overflow: TextOverflow.clip
                                ),
                              ),
                              Text(
                                widget.orderDetails['phone_no'],
                                style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  color: Colors.black.withOpacity(0.5),
                                  // overflow: TextOverflow.clip
                                ),
                              ),
                              Text(
                                widget.orderDetails['email'],
                                style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  color: Colors.black.withOpacity(0.5),
                                  // overflow: TextOverflow.clip
                                ),
                              ),
                              Text(
                                widget.orderDetails['address'],
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
                    border: Border.all(
                      color: Colors.grey.shade200,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
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
                                Text(
                                  'Order #${widget.orderDetails['orderId']}',
                                  style: TextStyle(
                                    fontSize: size.width * 0.040,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3D3D3D),
                                  ),
                                ),
                                Text(
                                  'Placed on ${(widget.orderDetails['timeAdded'] != "") ? formatDateString(widget.orderDetails['timeAdded']) : ""}',
                                  style: TextStyle(
                                    fontSize: size.width * 0.035,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
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
                                child: Image.network(
                                  'http://${ipAddress}/uploads/${widget.orderDetails['image']}',
                                  width: size.width * 0.25,
                                  // height: size.height * 0.1,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.025,
                              ),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.005,
                                  ),
                                  Text(
                                    '${widget.orderDetails['product_name']}',
                                    style: TextStyle(
                                      fontSize: size.width * 0.040,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF3D3D3D),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    '${widget.orderDetails['category']}',
                                    style: TextStyle(
                                      fontSize: size.width * 0.037,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Size: ',
                                        style: TextStyle(
                                          fontSize: size.width * 0.037,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                      Text(
                                        '${widget.orderDetails['size']}',
                                        style: TextStyle(
                                          fontSize: size.width * 0.037,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Colors: ',
                                        style: TextStyle(
                                          fontSize: size.width * 0.037,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                      Container(
                                        // width: size.width * 0.2,
                                        child: Text(
                                          '${widget.orderDetails['color']}',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Quantity: ',
                                        style: TextStyle(
                                          fontSize: size.width * 0.037,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                      Text(
                                        '${widget.orderDetails['quantity']}',
                                        style: TextStyle(
                                          fontSize: size.width * 0.037,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      'Rs. ${widget.orderDetails['price']}',
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
                            DropdownButton<String>(
                              underline: Container(
                                height: 0,
                              ),
                              icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                              value: _selectedStatus,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedStatus = newValue!;
                                });
                              },
                              items: statusOptions
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      fontStyle: FontStyle.italic,
                                      color: statusColors[value],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
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
                    border: Border.all(
                      color: Colors.grey.shade200,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        '${int.parse(widget.orderDetails['price']) * int.parse(widget.orderDetails['quantity'])}',
                                        style: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: textColor,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        '${int.parse(widget.orderDetails['price'])*int.parse(widget.orderDetails['quantity']) + 100}',
                                        style: TextStyle(
                                            fontSize: size.width * 0.04,
                                            color: textColor,
                                            overflow: TextOverflow.ellipsis),
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
                          child: Text(
                            'Payed by Cash on Delivery',
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontStyle: FontStyle.italic,
                              color: Colors.black.withOpacity(0.5),
                              // color: Colors.black.withOpacity(0.5),
                            ),
                          ),
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        width: size.width,
        // height: size.height*0.1,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            SizedBox(
                width: size.width * 0.4,
                child: buildColorElevatedButton(
                    "Cancel", size, Colors.grey.shade400, () {}),),
            SizedBox(
              width: size.width * 0.4,
              child: buildElevatedButton("Save", size, () {
                changeVendorOrderStatus(widget.loggedInUser['authToken'], widget.orderDetails['id'], _selectedStatus).then((value){

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AdminViewOrderScreen();
                  }));
                });
              }),),
          ],
        ),
      ),
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

