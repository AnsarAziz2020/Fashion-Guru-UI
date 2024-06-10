import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_guru/components/toast_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fashion_guru/constants/server_config.dart';
final dio = Dio();


String currentIp = ipAddress;

Future<Map<String,dynamic>> userRegisterDetails(Map<String, dynamic> details) async {
  try {
    var response = await dio.post('http://$currentIp/api/auth/createuser', data: details);
    print(response.data);
    if(!(response.data['authToken'].isEmpty)){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', response.data['authToken']);
    }
    Map<String, dynamic> responseData = response.data;
    return responseData;
  } catch (e) {
    // print(e);
    return {"error":e};
  }
}

Future<Map<String,dynamic>> getCurrentUser(token) async{

  try{
    dio.options.connectTimeout = Duration(seconds: 5); // milliseconds
    dio.options.receiveTimeout = Duration(seconds: 5); // milliseconds
    var response = await dio.post('http://$currentIp/api/auth/getuser', data: {'authToken': token});
    return {"error":false,"data":response.data};
  }
  catch(e){
    return {"error":true,"e":"Server Not Responding","details":e};
  }
}

Future<Map<String,dynamic>> getUsersByType(String type) async{

  try{
    dio.options.connectTimeout = Duration(seconds: 5); // milliseconds
    dio.options.receiveTimeout = Duration(seconds: 5); // milliseconds
    var response = await dio.post('http://$currentIp/api/auth/getuserbytype', data: {'type': type});
    return {"error":false,"data":response.data};
  }
  catch(e){
    return {"error":true,"e":"Server Not Responding","details":e};
  }
}

Future<Map<String,dynamic>> loginUser(String email, String password, String fcmToken) async {
  try {
    var response = await dio.post('http://$currentIp/api/auth/login', data: {"email":email,"password":password, 'fcm_token':fcmToken});
    if(!(response.data['authToken'].isEmpty)){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', response.data['authToken']);
    }
    Map<String, dynamic> responseData = response.data;
    return {"error":false,"data":responseData};
  } catch (e) {
    return {"error":true,"e":"Server Not Responding","details":e};
  }
}

Future<Map<String,dynamic>> uploadProfilePic(FormData formData) async {
  try{
    var response = await dio.post('http://$currentIp/api/auth/uploadprofilepic', data: formData);
    print(response);
    return {"error":false,"data":response.data};
  } catch(e) {
    print(e);
    return ({"error":true,"e":e});
  }
}

Future<Map<String,dynamic>> forgetPassword(String email,String password) async {
  try{
    var response = await dio.post('http://$currentIp/api/auth/forgetpassword', data: {"email":email,"password":password});
    print(response.data);
    return response.data;
  } catch(e) {
    return ({"e":e});
  }
}

Future<Map<String,dynamic>> duplicateCheck(String email,String contact_no) async {
  try{
    var response = await dio.post('http://$currentIp/api/auth/duplicatecheck', data: {"email":email,"contact_no":contact_no});
    print(response.data);
    return {"error":false,"data":response.data};
  } on DioException catch(e){
    showToast(e.response?.data['message']);
    return ({"error":true,"e":e});
  }
  catch(e) {
    return ({"error":true,"e":e});
  }
}

Future<Map<String,dynamic>> changeProfile(String type,String value,String authToken) async {
  try{
    dio.options.headers['authorization'] = authToken;
    print("$type $value");
    var response = await dio.post('http://$currentIp/api/auth/change/profile', data: {"type":type,"value":value});
    print(response);
    return {"error":false,"data":response.data};
  } on DioException catch(e){
    showToast(e.response?.data['message']);
    return ({"error":true,"e":e});
  }
  catch(e) {
    print(e);
    return ({"error":true,"e":e});
  }
}