import 'package:fashion_guru/controllers/products.dart';
import 'package:fashion_guru/screens/add_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/searchfield.dart';
import '../components/toast_message.dart';
import '../constants/server_config.dart';
import '../constants/textstyles.dart';
import '../controllers/session.dart';
import '../services/validators.dart';

const inactiveColor = Colors.white;
const activeEditColor = Color(0xFF3D3D3D);
const activeDeleteColor = Colors.red;
const activeContainerColor = Color(0xFFE3F2FE);

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({super.key});

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  Map<String, dynamic>loggedInUser={};
  List<dynamic> products=[];
  int selectedProductsIndex=-1;

  TextEditingController searchController = TextEditingController();

  Color editIconColor = inactiveColor;
  Color deleteIconColor = inactiveColor;
  Color containerColor = inactiveColor;

  @override
  void initState() {

    getUserFromSession().then((response){
      if(response['error']){
        showToast(response['e']);
      } else {
        setState(() {
          loggedInUser=response['data'];
        });

        getVendorProducts(loggedInUser['id']).then((response){
          if(response['error']){
            showToast(response['e']);
          } else {
            setState(() {
              products=response['data']['products'];
              print(products);
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
        // leading: GestureDetector(
        //   child: Icon(
        //     CupertinoIcons.left_chevron,
        //     size: size.width * 0.065,
        //   ),
        //   onTap: () {Navigator.pop(context);},
        // ),
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
          'Products',
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
                  height: size.height * 0.03,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: (selectedProductsIndex==index)?activeContainerColor:inactiveColor,
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                'http://${ipAddress}/uploads/${products[index]['thumbnail_image']}',
                                height: size.height * 0.07,


                              ),
                            ),
                            // SizedBox(
                            //   width: size.width * 0.025,
                            // ),
                            Expanded(
                              flex: 3,
                              // color: Colors.red,
                              // width: size.width*0.5,
                              // padding: EdgeInsets.only(left: 8),

                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      products[index]['product_name'],
                                      style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF3D3D3D),
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    Text(
                                      products[index]['category_name'],
                                      style: TextStyle(
                                        fontSize: size.width * 0.032,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: size.width * 0.04,
                                        ),
                                        Text(
                                          '4.5',
                                          style: TextStyle(
                                            fontSize: size.width * 0.027,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              // width: size.width*0.22,
                              // color: Colors.yellow,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        child: Icon(
                                          Icons.edit,
                                          color: (selectedProductsIndex==index)?activeEditColor:inactiveColor,
                                          size: size.width * 0.05,
                                        ),
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct(isUpdateProduct: products[index]['id'])));
                                        },
                                      ),
                                      SizedBox(
                                        width: size.width * 0.025,
                                      ),
                                      GestureDetector(
                                          child: Icon(
                                        Icons.delete,
                                        color: (selectedProductsIndex==index)?activeDeleteColor:inactiveColor,
                                        size: size.width * 0.05,
                                      ),
                                        onTap: ()=>showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                            title: const Text('Confirm Delete'),
                                            content: Text('Are You Sure You want to delete ${products[selectedProductsIndex]['product_name']}'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  deleteProduct(products[index]['id']).then((response){
                                                    if(!response['error']){
                                                      getVendorProducts(loggedInUser['id']).then((response){
                                                        if(response['error']){
                                                          showToast(response['e']);
                                                        } else {
                                                          setState(() {
                                                            products=response['data']['products'];
                                                          });
                                                        }
                                                      });
                                                      Navigator.pop(context, 'OK');
                                                    }
                                                  });
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        ),                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Rs ',
                                        style: TextStyle(
                                            fontSize: size.width * 0.04,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFFF5A811),
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Expanded(
                                        child: Text(
                                          products[index]['price'].toString(),
                                          style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFFF5A811),
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      onLongPress: () {
                        setState(() {
                          selectedProductsIndex=index;
                        });
                      },
                      onTap: () {
                        setState(() {
                          selectedProductsIndex=-1;
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
