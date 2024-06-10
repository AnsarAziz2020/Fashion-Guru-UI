import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/searchfield.dart';
import '../constants/server_config.dart';
import '../constants/textstyles.dart';
import '../controllers/products.dart';
import '../services/validators.dart';
import 'add_product_screen.dart';

const inactiveColor = Colors.white;
const activeEditColor = Color(0xFF3D3D3D);
const activeDeleteColor = Colors.red;
const activeContainerColor = Color(0xFFE3F2FE);

class AdminViewProductScreen extends StatefulWidget {
  const AdminViewProductScreen({super.key});

  @override
  State<AdminViewProductScreen> createState() => _AdminViewProductScreenState();
}

class _AdminViewProductScreenState extends State<AdminViewProductScreen> {
  TextEditingController searchController = TextEditingController();
  Color editIconColor = inactiveColor;
  Color deleteIconColor = inactiveColor;
  Color containerColor = inactiveColor;
  List<dynamic> products=[];

  @override
  void initState() {
    getAllProducts("",searchController.text).then((data){
      if(!data['error']){
        setState(() {
          products=data['data']['products'];
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
                        onPressed: () {
                          getAllProducts("",searchController.text).then((data){
                            if(!data['error']){
                              setState(() {
                                products=data['data']['products'];
                              });
                            }
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
                          color: containerColor,
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                'http://${ipAddress}/uploads/${products[index]['thumbnail_image']}',
                                height: size.height * 0.08,
                                width: size.width * 0.16,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            // SizedBox(
                            //   width: size.width * 0.025,
                            // ),
                            Expanded(
                              flex: 3,
                              // color: Colors.red,
                              // width: size.width*0.47,
                              // padding: EdgeInsets.only(left: 8),

                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'PID: ',
                                          style: TextStyle(
                                            fontSize: size.width * 0.032,
                                            fontWeight: FontWeight.w600,
                                            color: textColor,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '${products[index]['id']}',
                                            style: TextStyle(
                                                fontSize: size.width * 0.032,
                                                fontWeight: FontWeight.w600,
                                                color: primaryColor,
                                                overflow: TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${products[index]['product_name']}',
                                      style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF3D3D3D),
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    Text(
                                      '${products[index]['category_name']}',
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
                              // width: size.width * 0.22,
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
                                          color: editIconColor,
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
                                        color: deleteIconColor,
                                        size: size.width * 0.05,
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.04,
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
                                          '${products[index]['price']}',
                                          style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFFF5A811),
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
