 import 'dart:io';

import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get(
      {required String endPoint, String? accessToken}) async {
    Map<String, dynamic> headers = {};
    if (accessToken != null) {
      headers['Authorization'] = "Bearer $accessToken";
    }
    var response = await _dio.get(
      endPoint,
      options: Options(headers: headers),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint,
      required Map<String, dynamic> data,
      File? file,
      String? fileName,
      String? accessToken}) async {
    Map<String, dynamic> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    
    };
    if (accessToken != null) {
      headers['Authorization'] = "Bearer $accessToken";
    }
    FormData formData = FormData.fromMap(data);

    if (file != null) {
      int length = await file.length();

      formData.files.add(
        MapEntry(
            "file",
            await MultipartFile.fromFile(
              file.path,
              filename: fileName,
            )),
        // MapEntry(
        //     'file',
        //     MultipartFile.fromStream(file.openRead, length,
        //         filename: fileName)),
      );
    }

    var response = await _dio.post(
      endPoint,
      data: formData,
      options: Options(
        headers: headers,
      ),
    );
    //dio.post(url, data: formData, options: Options(headers:useOldHeaders, contentType: Headers.formUrlEncodedContentType,listFormat: ListFormat.multiCompatible))

    print(response.headers);
    return response.data;
  }
}
