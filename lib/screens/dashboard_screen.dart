import 'dart:io';

import 'package:fashion_guru/components/category_card.dart';
import 'package:fashion_guru/components/toast_message.dart';
import 'package:fashion_guru/constants/server_config.dart';
import 'package:fashion_guru/constants/textstyles.dart';
import 'package:fashion_guru/controllers/session.dart';
import 'package:fashion_guru/controllers/categories.dart';
import 'package:fashion_guru/controllers/products.dart';
import 'package:fashion_guru/screens/product_detail_screen.dart';
import 'package:fashion_guru/screens/resulted_products.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashion_guru/components/bottom_navigation_bar.dart';

import '../components/searchfield.dart';
import '../services/validators.dart';

const inactiveCardColor = Colors.white;
const activeCardColor = Color(0xFFF5A811);
const inactiveCardTextColor = Colors.black;
const activeCardTextColor = Colors.white;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>loggedInUser={};
  List<dynamic> categories=[];
  List<dynamic> products=[];

  String selectedCategory="";

  TextEditingController searchController = TextEditingController();

  void updateCategory(index){
    selectedCategory=index;

    getAllProducts(selectedCategory,searchController.text).then((data){
      if(!data['error']){
        setState(() {
          products=data['data']['products'];
        });
      }
    });
  }
  @override
  void initState() {
    getUserFromSession().then((response){
      if(response['error']){
        showToast(response['e']);
      } else {
        loggedInUser=response['data'];
      }
    });

    getAllCategories().then((data){
      if(!data['error']){
        setState(() {categories=data['data']['categories'];});
      }
    });
    // Passing Category and productname
    getAllProducts(selectedCategory,searchController.text).then((data){
      if(!data['error']){
        setState(() {
          products=data['data']['products'];
        });
      }
    });
    // TODO: implement initState
    super.initState();

  }
  // bool allCard = true;
  // bool shirtCard = true;
  // bool tShirtCard = true;
  // bool jeansCard = true;
  Color allCardColor = activeCardColor;
  Color shirtCardColor = inactiveCardColor;
  Color tShirtCardColor = inactiveCardColor;
  Color jeansCardColor = inactiveCardColor;

  Color allCardTextColor = activeCardTextColor;
  Color shirtCardTextColor = inactiveCardTextColor;
  Color tShirtCardTextColor = inactiveCardTextColor;
  Color jeansCardTextColor = inactiveCardTextColor;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        leading: Image.asset(
          'images/logo_design.png',
          // width: size.width * 0.03,
        ),
        title: Text(
          'Home',
          style: screenHeading(size),
        ),
        // title: Image.asset(
        //   'images/logo_text.png',
        //   width: size.width*0.9,
        // ),
        actions: [
          Icon(
            CupertinoIcons.ellipsis_vertical,
            size: size.width * 0.065,
          ),
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFFF8F8F8),
      ),
      body: SafeArea(
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
                          updateCategory(selectedCategory);
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
                    'Categories',
                    style: subHeading(size),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(

                    children:[
                      buildCategoryCard(
                          "All",
                          (selectedCategory!='')?inactiveCardTextColor:activeCardTextColor,
                          (selectedCategory!='')?inactiveCardColor:activeCardColor,
                          'http://${ipAddress}/uploads/all_icon.png',
                          size,
                              () {
                            setState(()=>updateCategory(''));
                          }),
                      for(Map<String,dynamic> category in categories)
                        buildCategoryCard(
                            category['category'],
                            (selectedCategory!=category['id'])?inactiveCardTextColor:activeCardTextColor,
                            (selectedCategory!=category['id'])?inactiveCardColor:activeCardColor,
                            'http://${ipAddress}/uploads/${category['category_image']}',
                            size,
                                () {
                              setState(()=>updateCategory(category['id']));
                            }),

                    ],
                  )
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                GridView.builder(
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
                              child: Image.network('http://${ipAddress}/uploads/${products[index]['thumbnail_image']}',width: size.width * 0.45,height: size.height * 0.20,fit: BoxFit.fitWidth)
                          ),
                          SizedBox(
                            height: size.height * 0.005,
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
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add your action here
          print('Floating Action Button pressed!');
          FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
          print(result?.files.single.path);
          // File(result.single.path!);
          if(result?.files.single.path != null){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ResultedProducts( searchImage: File(result!.files.single.path!))));
          }

        },
        tooltip: 'Take a photo',
        child: Icon(Icons.camera_alt,color: Colors.white,),
      ),
      bottomNavigationBar: Custom_Navigator(selectedIndex: 0),
    );
  }
}
