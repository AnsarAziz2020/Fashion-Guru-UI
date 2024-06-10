import 'package:dio/dio.dart';
import 'package:fashion_guru/constants/server_config.dart';

import '../components/toast_message.dart';

final dio = Dio();

String currentIp = ipAddress;

Future<Map<String, dynamic>> addOrderFromCart(
    Map<String, dynamic> formData) async {
  try {
    var response =
        await dio.post('http://$currentIp/api/order/addorder', data: formData);
    Map<String, dynamic> responseData = response.data;
    showToast("Successfully Added to Cart");
    return {"data": responseData, "error": false};
  } catch (e) {
    showToast("Got Error While Adding In Cart");
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> getOrderByUserId(String userId) async {
  try {
    var response = await dio
        .get('http://$currentIp/api/order/getorderbyuserid?userId=${userId}');
    Map<String, dynamic> responseData = response.data;
    return {"data": responseData, "error": false};
  } catch (e) {
    showToast("Error while getting orders");
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> getOrderById(String id) async {
  try {
    var response =
        await dio.get('http://$currentIp/api/order/getorderbyid?id=${id}');
    Map<String, dynamic> responseData = response.data;
    return {"data": responseData, "error": false};
  } catch (e) {
    showToast("Error while getting order details");
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> getVendorOrders(String authToken) async {
  try {
    dio.options.headers['authorization'] = authToken;
    var response = await dio.get('http://$currentIp/api/order/getvendororders');
    Map<String, dynamic> responseData = response.data;
    return {"data": responseData};
  } catch (e) {
    showToast("Error while getting orders");
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> getAdminOrders(String authToken) async {
  try {
    dio.options.headers['authorization'] = authToken;
    var response = await dio.get('http://$currentIp/api/order/getadminorders');
    Map<String, dynamic> responseData = response.data;
    return {"data": responseData};
  } catch (e) {
    showToast("Error while getting orders");
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> changeVendorOrderStatus(String authToken,String id,String status) async {
  try {
    dio.options.headers['authorization'] = authToken;
    // dio.options.headers['content-Type'] = 'application/json';
    var response = await dio.put('http://$currentIp/api/order/changevendororderstatus',data: {"order_id":id,"status":status});
    Map<String, dynamic> responseData = response.data;
    return {"data": responseData};
  } catch (e) {
    print(e);
    showToast("Error while getting orders");
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> addBargainOrder(Map<String, dynamic> formData,String authToken) async {
  try {
    dio.options.headers['authorization'] = authToken;
    var response = await dio.post('http://$currentIp/api/order/addbargainorder', data: formData);
    Map<String, dynamic> responseData = response.data;
    print(responseData);
    showToast(responseData['message']);
    return {"data": responseData, "error": false};
  } catch (e) {
    print(e);
    showToast("Got Error While Adding Bargain Order");
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> addProductReview(Map<String, dynamic> formData,String authToken) async {
  try {
    dio.options.headers['authorization'] = authToken;
    var response = await dio.post('http://$currentIp/api/review/add', data: formData);
    Map<String, dynamic> responseData = response.data;
    showToast(responseData['message']);
    return {"data": responseData, "error": false};
  } catch (e) {
    print(e);
    showToast("Got Error While Adding Review");
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> listProductReview(String productId) async {
  try {

    var response = await dio.get('http://$currentIp/api/review/list/${productId}');
    Map<String, dynamic> responseData = response.data;
    return {"data": responseData, "error": false};
  } catch (e) {
    showToast("Got Error While Getting Reviews");
    return {"error": true, "e": e};
  }
}

Future<Map<String, dynamic>> searchOrders(String orderId) async {
  try {

    var response = await dio.get('http://$currentIp/api/order/search/${orderId}');
    Map<String, dynamic> responseData = response.data;
    return {"data": responseData, "error": false};
  } catch (e) {
    showToast("Got Error While Getting Reviews");
    return {"error": true, "e": e};
  }
}
