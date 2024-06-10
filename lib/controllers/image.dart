import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/server_config.dart';

Dio dio = Dio();

Future<File> fetchImages(String url) async {
  print(url);
  try {
    var response = await dio.get('http://$ipAddress/uploads/$url', options: Options(responseType: ResponseType.bytes));

    if (response.statusCode == 200) {
      // Cache the image locally
      final appDir = await getApplicationDocumentsDirectory();
      final localPath = '${appDir.path}/$url';
      final localFile = File(localPath);
      await localFile.writeAsBytes(response.data!);

      return localFile;
    } else {
      throw Exception('Failed to fetch image');
    }
  } catch (e) {
    throw Exception('Failed to fetch image: $e');
  }
}
