import 'dart:io';

import 'package:fashion_guru/screens/product_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/searchfield.dart';
import '../constants/server_config.dart';
import '../constants/textstyles.dart';
import '../controllers/products.dart';
import '../services/validators.dart';

class ResultedProducts extends StatefulWidget {
  final File searchImage;
  const ResultedProducts({super.key, required this.searchImage});

  @override
  State<ResultedProducts> createState() => _ResultedProductsState();
}

class _ResultedProductsState extends State<ResultedProducts> {
  TextEditingController searchController = TextEditingController();
  List <dynamic> products = [];
  bool _loading=true;

  @override
  void initState() {
    searchProductByImage(widget.searchImage).then((response){
      setState(() {
        _loading=false;
        products = response['data']['result'];
      });
    });
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

        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFFF8F8F8),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _loading,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
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
                          onPressed: () {

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
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Results',
                      style: subHeading(size),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  (_loading)?Container():(products.isNotEmpty)?GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    // padding: EdgeInsets.only(bottom: size.width*0.085),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.78,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        crossAxisCount: 2),
                    itemCount: products.length,

                    itemBuilder: (context, index) {

                      return GestureDetector(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network('http://${ipAddress}/uploads/${products[index]['image']}',width: size.width * 0.45,height: size.height * 0.20,fit: BoxFit.fitWidth)
                            ),
                            SizedBox(
                              height: size.height * 0.005,
                            ),
                            Text(
                              'product name',
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF3D3D3D),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Text(
                              '${products[index]['category']}',
                              style: TextStyle(
                                fontSize: size.width * 0.033,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(productDetails: products[index])));
                        },
                      );
                    },
                  ):Text('No Products Found',style: TextStyle(color: Colors.red),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


