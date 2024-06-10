import 'dart:convert';

import 'package:fashion_guru/controllers/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getDataFromLocalStorage(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.getString(key);
}

Future<dynamic> setDataToLocalStorage(String key, String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString(key, value);
}

Future<Map<String, dynamic>> getUserFromSession() async {
  try{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDetails = await prefs.getString("userDetails");
    if (userDetails == null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = await prefs.getString("authToken");
      if (authToken == null) {
        return {"error": true, "e": "Token Not Found"};
      } else {
        Map<String, dynamic> getUserDetails = await getCurrentUser(authToken);
        setDataToLocalStorage("userDetails", jsonEncode(getUserDetails['data']));
        return {"error": false, "data":getUserDetails['data']};
      }
    } else {
      return {"error": false, "data":jsonDecode(userDetails)};
    }
  } catch(e){
    return {"error":true,"e":"Failed to retrieve user","details":e};
  }

}

Future<Map<String, dynamic>> updateUserFromSession() async {
  try{
    String? getAuthToken = await getDataFromLocalStorage("authToken");
    print(getAuthToken);
    Map<String, dynamic> getUserDetails = await getCurrentUser(getAuthToken);
    setDataToLocalStorage("userDetails", jsonEncode(getUserDetails['data']));
    return {"error": false, "data":getUserDetails['data']};
  } catch(e){
    return {"error":true,"e":"Failed to retrieve user","details":e};
  }
}

Future<Map<String, dynamic>> logoutUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isAuthTokenDeleted=await prefs.setString("authToken", "");
  bool isUserDetailsDeleted=await prefs.setString("userDetails", "");
  if(isAuthTokenDeleted&&isUserDetailsDeleted){
    return {"error":false};
  } else {
    return {"error":true,"e":{isAuthTokenDeleted,isUserDetailsDeleted}};
  }

}