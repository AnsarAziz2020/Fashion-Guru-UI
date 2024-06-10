import 'package:dio/dio.dart';
import 'package:fashion_guru/constants/server_config.dart';

import '../components/toast_message.dart';

final dio = Dio();

String currentIp = ipAddress;

Future<Map<String, dynamic>> addOrderFromCart(Map<String, dynamic> formData,String authToken) async {
  try {
    dio.options.headers['authorization'] = authToken;
    var response = await dio.post('http://$currentIp/api/review/add', data: formData);
    Map<String, dynamic> responseData = response.data;
    showToast("Successfully Added Review");
    return {"data": responseData, "error": false};
  } catch (e) {
    showToast("Got Error While Adding Review");
    return {"error": true, "e": e};
  }
}