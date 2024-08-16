import 'package:filehive/features/home/data/models/file_model.dart';

class ResposeUploadFile {
  int? statusCode;
  FileModel? file;
  String? message;
  bool? error;

  ResposeUploadFile({this.statusCode, this.file, this.message, this.error});

  ResposeUploadFile.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    file = json['data'] != null ? FileModel.fromJson(json['data']) : null;
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    if (file != null) {
      data['data'] = file!.toJson();
    }
    data['message'] = message;
    data['error'] = error;
    return data;
  }
}
