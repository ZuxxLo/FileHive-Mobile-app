import 'package:filehive/core/utils/api/api_links.dart';

class FileModel {
  int? id;
  String? title;
  String? file;
  String? fileType;
  String? dateCreated;
  String? updatedDate;
  String? fileSize;

  FileModel(
      {this.id,
      this.title,
      this.file,
      this.fileType,
      this.dateCreated,
      this.updatedDate,
      this.fileSize});

  FileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    file = ApiLinks.linkServerName + json['file'];
    fileType = json['file_type'];
    dateCreated = json['date_created'];
    updatedDate = json['updated_date'];
    fileSize = json['file_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['file'] = file;
    data['file_type'] = fileType;
    data['date_created'] = dateCreated;
    data['updated_date'] = updatedDate;
    data['file_size'] = fileSize;
    return data;
  }
}
