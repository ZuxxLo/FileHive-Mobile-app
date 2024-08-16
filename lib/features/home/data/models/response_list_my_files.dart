import 'file_model.dart';

class ResponseListMyFiles {
  int? statusCode;
  List<FileModel>? files;
  String? message;
  bool? error;

  ResponseListMyFiles({this.statusCode, this.files, this.message, this.error});

  ResponseListMyFiles.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      files = <FileModel>[];
      json['data'].forEach((v) {
        files!.add(FileModel.fromJson(v));
      });
    }
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    if (files != null) {
      data['data'] = files!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['error'] = error;
    return data;
  }
}
