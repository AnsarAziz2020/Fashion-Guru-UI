import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fashion_guru/constants/server_config.dart';

import '../components/toast_message.dart';

final dio = Dio();

String currentIp = ipAddress;

Future<Map<String, dynamic>> addProductToCart(Map<String,dynamic> formData) async {
  try {
    var response = await dio.post('http://$currentIp/api/cart/addtocart',data: formData);
    Map<String, dynamic> responseData = response.data;
    return {"data": responseData, "error": false};
  } catch (e) {
    showToast("Got Error While Adding In Cart");
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> getCartProducts(String userId) async {
  try {
    var response = await dio.get('http://$currentIp/api/cart/getcartproducts?userId=$userId');
    Map<String, dynamic> responseData = response.data;
    return {"data": responseData, "error": false};
  } catch (e) {
    showToast("Got Error While Getting Products From Cart");
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> DeleteCartProduct(String cartId) async {
  try {
    var response = await dio.delete('http://$currentIp/api/cart/deletecartproduct',data: {"cartId":cartId});
    Map<String, dynamic> responseData = response.data;
    return {"data": responseData, "error": false};
  } catch (e) {
    showToast("Got Error While Deleting Products From Cart");
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> UpdateQuantityInCart(Map<String,dynamic> formData) async {
  try {
    var response = await dio.put('http://$currentIp/api/cart/updatecartquantity',data: {"cartList":formData});
    Map<String, dynamic> responseData = response.data;
    return {"data": responseData, "error": false};
  } catch (e) {
    showToast("Got Error While Updating Quantity From Cart");
    return {"error": true, "e": e};
  }
}