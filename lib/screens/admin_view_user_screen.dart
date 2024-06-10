import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/searchfield.dart';
import '../constants/server_config.dart';
import '../constants/textstyles.dart';
import '../controllers/users.dart';
import '../services/validators.dart';

const inactiveColor = Colors.white;
const activeEditColor = Color(0xFF3D3D3D);
const activeDeleteColor = Colors.red;
const activeContainerColor = Color(0xFFE3F2FE);

class ViewUserScreen extends StatefulWidget {
  const ViewUserScreen({super.key});

  @override
  State<ViewUserScreen> createState() => _ViewUserScreenState();
}

class _ViewUserScreenState extends State<ViewUserScreen> {
  TextEditingController searchController = TextEditingController();
  Color editIconColor = inactiveColor;
  Color deleteIconColor = inactiveColor;
  Color containerColor = inactiveColor;

  bool isSelected= false;
  List<dynamic> customers=[];
  List<dynamic> vendors=[];

  @override
  void initState() {
    getUsersByType("customer").then((response){
      setState(() {
        customers=response['data'];
      });
    });

    getUsersByType("vendor").then((response){
      print((response));
      setState(() {
        vendors=response['data'];
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
          'Users',
          style: screenHeading(size),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  child: buildSearchField(
                      "Search...",

                      IconButton(
                        icon: Icon(Icons.search,
                          // color: Colors.transparent,
                          size: size.width * 0.06,),
                        onPressed: () {},
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
                  height: size.height * 0.01,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Color(0xFF3D3D3D),
                          unselectedLabelColor:
                              Colors.black.withOpacity(0.5),
                          tabs: [
                            Tab(
                              child: Text(
                                'User',
                                style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Vendor',
                                style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8),
                          // color: Colors.deepOrange,
                          height: size.height * 0.75,
                          child: TabBarView(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: customers.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: containerColor,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.network(
                                              'http://${ipAddress}/uploads/${customers[index]['profile_pic']}',
                                              height: size.height * 0.08,
                                              width: size.width * 0.16,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
// SizedBox(
//   width: size.width * 0.025,
// ),
                                          Expanded(
// color: Colors.red,
// width: size.width*0.47,
// padding: EdgeInsets.only(left: 8),

                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(

                                                    children: [
                                                      Text(
                                                        'UID: ',
                                                        style: TextStyle(
                                                          fontSize: size.width *
                                                              0.032,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: textColor,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${customers[index]['id']}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  size.width *
                                                                      0.032,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              color: primaryColor,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '${customers[index]['name']}',
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.04,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xFF3D3D3D),
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  Text(
                                                    '${customers[index]['email']}',
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.width * 0.032,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: editIconColor,
                                                  size: size.width * 0.05,
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.025,
                                              ),
                                              GestureDetector(
                                                  child: Icon(
                                                Icons.delete,
                                                color: deleteIconColor,
                                                size: size.width * 0.05,
                                              )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    onLongPress: () {
                                      setState(() {
                                        editIconColor = activeEditColor;
                                        deleteIconColor = activeDeleteColor;
                                        containerColor = activeContainerColor;
                                      });
                                    },
                                    onTap: () {
                                      setState(() {
                                        editIconColor = inactiveColor;
                                        deleteIconColor = inactiveColor;
                                        containerColor = inactiveColor;
                                      });
                                    },
                                  );
                                },
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: vendors.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: containerColor,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            child: Image.network(
                                              'http://${ipAddress}/uploads/${vendors[index]['profile_pic']}',
                                              height: size.height * 0.08,
                                              width: size.width * 0.16,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
// SizedBox(
//   width: size.width * 0.025,
// ),
                                          Expanded(
// color: Colors.red,
// width: size.width*0.47,
// padding: EdgeInsets.only(left: 8),

                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(

                                                    children: [
                                                      Text(
                                                        'VID: ',
                                                        style: TextStyle(
                                                          fontSize: size.width *
                                                              0.032,
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          color: textColor,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          '${vendors[index]['id']}',
                                                          style: TextStyle(
                                                              fontSize:
                                                              size.width *
                                                                  0.032,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                              color: primaryColor,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '${vendors[index]['name']}',
                                                    style: TextStyle(
                                                        fontSize:
                                                        size.width * 0.04,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color:
                                                        Color(0xFF3D3D3D),
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  Text(
                                                    '${vendors[index]['email']}',
                                                    style: TextStyle(
                                                        fontSize:
                                                        size.width * 0.032,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: editIconColor,
                                                  size: size.width * 0.05,
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.025,
                                              ),
                                              GestureDetector(
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: deleteIconColor,
                                                    size: size.width * 0.05,
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      if(isSelected==true){
                                        setState(() {
                                          editIconColor = inactiveColor;
                                          deleteIconColor = inactiveColor;
                                          containerColor = inactiveColor;
                                        });
                                        isSelected= false;
                                      }
                                      else{
                                        Navigator.pushNamed(context, 'UserDetails');
                                      }
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        editIconColor = activeEditColor;
                                        deleteIconColor = activeDeleteColor;
                                        containerColor = activeContainerColor;
                                      });
                                      isSelected = true;
                                    },

                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

// ListView.builder(
// physics: NeverScrollableScrollPhysics(),
// shrinkWrap: true,
// itemCount: 15,
// itemBuilder: (context, index) {
// return GestureDetector(
// child: Container(
// margin: EdgeInsets.only(bottom: 5),
// padding: EdgeInsets.all(5),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(5),
// color: containerColor,
// ),
// child: Row(
// children: [
// ClipRRect(
// borderRadius: BorderRadius.circular(5),
// child: Image.asset(
// 'images/t-shirt.jpg',
// width: size.width * 0.2,
// ),
// ),
// // SizedBox(
// //   width: size.width * 0.025,
// // ),
// Expanded(
// // color: Colors.red,
// // width: size.width*0.47,
// // padding: EdgeInsets.only(left: 8),
//
// child: Padding(
// padding: const EdgeInsets.only(left: 8),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// // mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Row(
// children: [
// Text(
// 'PID: ',
// style: TextStyle(
// fontSize: size.width * 0.032,
// fontWeight: FontWeight.w600,
// color: textColor,
// ),
// ),
// Text(
// '1015646',
// style: TextStyle(
// fontSize: size.width * 0.032,
// fontWeight: FontWeight.w600,
// color: primaryColor,
// overflow: TextOverflow.ellipsis),
// ),
// ],
// ),
// Text(
// 'Round Neck',
// style: TextStyle(
// fontSize: size.width * 0.04,
// fontWeight: FontWeight.w600,
// color: Color(0xFF3D3D3D),
// overflow: TextOverflow.ellipsis),
// ),
// Text(
// 'T-shirt',
// style: TextStyle(
// fontSize: size.width * 0.032,
// color: Colors.black.withOpacity(0.5),
// ),
// ),
// Row(
// children: [
// Icon(
// Icons.star,
// color: Colors.amber,
// size: size.width * 0.04,
// ),
// Text(
// '4.5',
// style: TextStyle(
// fontSize: size.width * 0.027,
// color:
// Colors.black.withOpacity(0.5),
// ),
// ),
// ],
// )
// ],
// ),
// ),
// ),
// Container(
// width: size.width * 0.22,
// // color: Colors.yellow,
// child: Column(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// // crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// GestureDetector(
// child: Icon(
// Icons.edit,
// color: editIconColor,
// size: size.width * 0.05,
// ),
// ),
// SizedBox(
// width: size.width * 0.025,
// ),
// GestureDetector(
// child: Icon(
// Icons.delete,
// color: deleteIconColor,
// size: size.width * 0.05,
// )),
// ],
// ),
// SizedBox(
// height: size.height * 0.04,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Text(
// 'Rs ',
// style: TextStyle(
// fontSize: size.width * 0.04,
// fontWeight: FontWeight.w600,
// color: Color(0xFFF5A811),
// overflow: TextOverflow.ellipsis),
// ),
// Text(
// '50000',
// style: TextStyle(
// fontSize: size.width * 0.04,
// fontWeight: FontWeight.w600,
// color: Color(0xFFF5A811),
// overflow: TextOverflow.ellipsis),
// ),
// ],
// )
// ],
// ),
// )
// ],
// ),
// ),
// onLongPress: () {
// setState(() {
// editIconColor = activeEditColor;
// deleteIconColor = activeDeleteColor;
// containerColor = activeContainerColor;
// });
// },
// onTap: () {
// setState(() {
// editIconColor = inactiveColor;
// deleteIconColor = inactiveColor;
// containerColor = inactiveColor;
// });
// },
// );
// },
// ),
