import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fashion_guru/constants/server_config.dart';

final dio = Dio();

String currentIp = ipAddress;

Future<Map<String, dynamic>> getAllCategories() async {
  try {
    var response = await dio.get('http://$currentIp/api/category/getcategories');
    Map<String, dynamic> responseData = response.data;

    return {"data": responseData, "error": false};
  } catch (e) {
    return {"error": true, "e": e};
  }
}
