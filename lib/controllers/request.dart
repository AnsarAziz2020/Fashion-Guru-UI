import 'package:dio/dio.dart';
import 'package:fashion_guru/constants/server_config.dart';
final dio = Dio();

Future<Map<String,dynamic>> makePostRequestToServer(String url, dynamic data) async {
  try{
    dio.options.connectTimeout = Duration(seconds: 5); // milliseconds
    dio.options.receiveTimeout = Duration(seconds: 5);
    var response = await dio.post('http://$ipAddress/$url', data:data);// milliseconds
    Map<String, dynamic> responseData = response.data;
    return {"error":false,"data":responseData,"details":response};
  } catch(e) {
    print(e);
    return {"error":true,"e":"Server Not Responing","details":e};
  }
}

Future<Map<String,dynamic>> makeGetRequestToServer(String url) async {
  try{
    dio.options.connectTimeout = Duration(seconds: 5); // milliseconds
    dio.options.receiveTimeout = Duration(seconds: 5);
    var response = await dio.get('http://$ipAddress/api/auth/createuser');// milliseconds
    Map<String, dynamic> responseData = response.data;
    return {"error":false,"data":responseData,"details":response};
  } catch(e) {
    return {"error":true,"e":"Server Not Responing","details":e};
  }
}

