import 'dart:io';
import 'package:fashion_guru/components/add_product_fields.dart';
import 'package:fashion_guru/components/elevatedbutton.dart';
import 'package:fashion_guru/controllers/image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';
import '../components/toast_message.dart';
import '../constants/server_config.dart';
import '../constants/textstyles.dart';
import '../controllers/categories.dart';
import '../controllers/products.dart';
import '../controllers/session.dart';
import 'package:multiselect/multiselect.dart';

import '../services/validators.dart';

class AddProduct extends StatefulWidget {
  final String isUpdateProduct;
  const AddProduct({super.key, required this.isUpdateProduct});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Map<String, dynamic> loggedInUser = {};
  List<dynamic> categories = [];

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController colorsController = new TextEditingController();
  TextEditingController sizeController = new TextEditingController();
  String categorySelectedValue = "";
  List<File> selectedFile = [];
  List<String> selectedSizes = [];

  @override
  void initState() {
    getUserFromSession().then((response) {
      if (response['error']) {
        showToast(response['e']);
      } else {
        setState(() {
          loggedInUser = response['data'];
        });
      }
    });

    getAllCategories().then((response) {
      if (response['error']) {
        showToast(response['e']);
      } else {
        setState(() {
          categories = response['data']['categories'];
          print(categories);
        });
      }
    });

    if (widget.isUpdateProduct.isNotEmpty) {
      getProduct(widget.isUpdateProduct).then((response) => {
            if (response['error'])
              {showToast(response['e'])}
            else
              {
                setState(() {
                  nameController.text =
                      response['data']['products']['product_name'];
                  descriptionController.text =
                      response['data']['products']['description'];
                  priceController.text =
                      toString(response['data']['products']['price']);
                  colorsController.text =
                      response['data']['products']['colors'];
                  categorySelectedValue =
                      response['data']['products']['category'];
                  selectedSizes =
                      response['data']['products']['size'].split(",");
                  // other images
                  for (var i in response['data']['products']['other_images']
                      .split(",")) {
                    fetchImages(i).then((value) {
                      setState(() {
                        selectedFile.add(value);
                      });
                    });
                  }
                })
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
          '${(widget.isUpdateProduct.isEmpty) ? "Add" : "Update"} Product',
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
            padding: EdgeInsets.only(left: 25, right: 25, top: 20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.grey[150],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Upload Images",
                          style: subHeading(size),
                        ),
                        // InkWell(
                        //   onTap: () async {
                        //     FilePickerResult? result = await FilePicker.platform
                        //         .pickFiles(type: FileType.image);
                        //
                        //     if (result != null) {
                        //       setState(() {
                        //         selectedFile.add(File(result.files.single.path!));
                        //       });
                        //     }
                        //   },
                        //   child: Icon(
                        //         Icons.add_a_photo,
                        //         size: size.width * 0.06,
                        //         color: primaryColor,
                        //       ),
                        //
                        //
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.0,
                  ),
                  Stack(
                    children: [
                      Container(
                        color: Colors.grey[200],
                        height: size.height * 0.2,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedFile.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 5, top: 5, right: 5, bottom: 5),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 120,
                                    height: size.height,
                                    child: Image.file(
                                      selectedFile[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 3,
                                    right: 3,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedFile.removeAt(index);
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black.withOpacity(0.25),
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          size: size.width * 0.04,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: InkWell(
                          onTap: () async {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(
                                    type: FileType.image, allowMultiple: true);

                            if (result != null) {
                              print(result);
                              setState(() {
                                for (var values in result.files) {
                                  selectedFile.add(File(values.path!));
                                }
                              });
                            }
                          },
                          child: Icon(
                            Icons.add_a_photo,
                            size: size.width * 0.065,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildAddProductField(
                            'Name',
                            'Enter Name of the Product',
                            1,
                            1,
                            size,
                            nameController, (value) {
                          String _validator = aplhaCharacter(value);
                          if (_validator != "") {
                            return _validator;
                          }
                        }),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        buildAddProductField(
                            'Description',
                            'Enter Description of the Product',
                            1,
                            8,
                            size,
                            descriptionController, (value) {
                          String _validator = alphaNumeric(value);
                          if (_validator != "") {
                            return _validator;
                          }
                        }),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        buildAddProductField(
                            'Price',
                            'Enter Price of the Product',
                            1,
                            1,
                            size,
                            priceController, (value) {
                          String _validator = onlyNumeric(value);
                          if (_validator != "") {
                            return _validator;
                          }
                        }),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        buildAddProductField('Colors', 'Enter Available Colors',
                            1, 1, size, colorsController, (value) {
                          String _validator = alphaNumeric(value);
                          if (_validator != "") {
                            return _validator;
                          }
                        }),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        // buildAddProductField('Size', 'Enter Available Sizes', 1,
                        //     1, size, sizeController),
                        // SizedBox(
                        //   height: size.height * 0.02,
                        // ),
                        DropdownButton<String>(
                          autofocus: true,
                          focusColor: primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          borderRadius: BorderRadius.circular(8),
                          isExpanded: true,
                          value: categorySelectedValue,

                          items: [
                            DropdownMenuItem<String>(
                              value: "",
                              child: Text(
                                'Select Category',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: size.width * 0.04,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              enabled: false,
                            ),
                            for (Map<String, dynamic> category in categories)
                              DropdownMenuItem<String>(
                                value: category['id'],
                                child: Text(
                                  category['category'],
                                  style: TextStyle(
                                    color: textColor.withOpacity(0.7),
                                    fontSize: size.width * 0.04,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                          ],
                          onChanged: (String? value) {
                            print(value);
                            setState(() {
                              categorySelectedValue = value!;
                            });
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        DropDownMultiSelect(
                          // decoration: InputDecoration(
                          //   border: UnderlineInputBorder(
                          //     borderSide: BorderSide(width: 1,color: Colors.grey.withOpacity(0.2)),
                          //   ),
                          // ),
                          selected_values_style: TextStyle(
                            color: textColor,
                            fontSize: size.width * 0.04,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          onChanged: (List<String> x) {
                            setState(() {
                              selectedSizes = x;
                            });
                          },
                          options: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
                          selectedValues: selectedSizes,
                          whenEmpty: 'Select Available Sizes',
                        ),

                        SizedBox(
                          height: size.height * 0.035,
                        ),
                        SizedBox(
                          width: size.width,
                          child: buildElevatedButton(
                              '${(widget.isUpdateProduct.isEmpty) ? "Submit" : "Update"}',
                              size, () async {
                            if (_formKey.currentState!.validate() && selectedFile.length>0 && selectedSizes!="" && categorySelectedValue!="") {
                              final formData = FormData();
                              // files
                              for (int i = 0; i < selectedFile.length; i++) {
                                formData.files.add(
                                  MapEntry(
                                    'file',
                                    await MultipartFile.fromFile(
                                      selectedFile[i].path,
                                      filename:
                                          selectedFile[i].path.split('/').last,
                                    ),
                                  ),
                                );
                              }

                              formData.fields.addAll({
                                MapEntry("id", widget.isUpdateProduct),
                                MapEntry("name", nameController.text),
                                MapEntry(
                                    "description", descriptionController.text),
                                MapEntry("price", priceController.text),
                                MapEntry("colors", colorsController.text),
                                MapEntry("size", selectedSizes.join(",")),
                                MapEntry("category", categorySelectedValue),
                                MapEntry("userId", loggedInUser['id']),
                              });

                              if (widget.isUpdateProduct.isEmpty) {
                                addProduct(formData).then((response) async {
                                  Navigator.pushNamed(
                                      context, 'DashboardScreen');
                                });
                              } else {
                                updateProduct(formData).then((value) {
                                  Navigator.pushNamed(context, 'ViewProduct');
                                });
                              }
                            } else {
                              showToast("Fill all the information");
                            }
                          }),
                        )
                      ],
                    ),
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
