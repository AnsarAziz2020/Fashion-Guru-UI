import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fashion_guru/constants/server_config.dart';

final dio = Dio();

String currentIp = ipAddress;

// Future<Map<String, dynamic>> getAllProducts() async {
//   try {
//     var response = await dio.get('http://$currentIp/api/product/getproducts');
//     Map<String, dynamic> responseData = response.data;
//
//     return {"data": responseData, "error": false};
//   } catch (e) {
//     return {"error": true, "e": e};
//   }
// }

Future<Map<String, dynamic>> getAllProducts(String category,String productname) async {
  try {
    var response = await dio.get('http://$ipAddress/api/product/getproducts?category=${category}&product_name=${productname}');
    Map<String, dynamic> responseData = response.data;
    return {"data": responseData, "error": false};
  } catch (e) {
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> getProduct(String id) async {
  try {
    var response = await dio.get('http://$ipAddress/api/product/getproduct?id=${id}');
    Map<String, dynamic> responseData = response.data;
    return {"data": responseData, "error": false};
  } catch (e) {
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> getVendorProducts(String userId) async {
  try {
    var response = await dio.get('http://$ipAddress/api/product/getvendorproducts?userId=${userId}');
    Map<String, dynamic> responseData = response.data;
    return {"data": responseData, "error": false};
  } catch (e) {
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> addProduct(FormData formData) async {
  try {

    var response = await dio.post('http://$currentIp/api/product/addproduct',data: formData);
    Map<String, dynamic> responseData = response.data;

    return {"data": responseData, "error": false};
  } catch (e) {
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> updateProduct(FormData formData) async {
  try {
    var response = await dio.post('http://$currentIp/api/product/updateproduct',data: formData);
    Map<String, dynamic> responseData = response.data;

    return {"data": responseData, "error": false};
  } catch (e) {
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> deleteProduct(String id) async {
  try {

    var response = await dio.get('http://$currentIp/api/product/deleteproductbyid?id=${id}');
    Map<String, dynamic> responseData = response.data;

    return {"data": responseData, "error": false};
  } catch (e) {
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> searchProductByImage(File image) async {
  try {
    final formData = FormData();
    formData.files.add(MapEntry(
      'file',
      await MultipartFile.fromFile(
        image.path,
        filename:image.path.split('/').last,
      ),
    ),);

    var response = await dio.post('http://$currentIp/api/product/searchproductbyimage',data: formData);
    Map<String, dynamic> responseData = response.data;

    return {"data": responseData, "error": false};
  } catch (e) {
    return {"error": true, "e": e};
  }
}



