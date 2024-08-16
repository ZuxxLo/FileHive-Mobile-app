import 'dart:io';

class CreateFileModel {
  File? _file;
  String? _fileName;
  String? _originalFileName;

  File? get file => _file;
  String? get fileName => _fileName;
  String? get originalFileName => _originalFileName;

  setFile({File? file, String? fileName, String? originalFileName}) async {
    String? originalFileNameNoExtension;

    if (originalFileName != null) {
      int? dotIndex = originalFileName.lastIndexOf('.');
      if (dotIndex != -1) {
        originalFileNameNoExtension = originalFileName.substring(0, dotIndex);
      }
    }

    _file = file ?? _file;

    if (fileName != null) {
      _fileName = fileName;
    } else if (_fileName == _originalFileName || _fileName == "") {
      _fileName = originalFileNameNoExtension ?? _originalFileName;
    } else {
      _fileName = _fileName; // This line keeps _fileName unchanged
    }
    // _fileName = fileName ??
    //     (_fileName == _originalFileName
    //         ? originalFileNameNoExtension ?? _originalFileName
    //         : _fileName);
    _originalFileName = originalFileNameNoExtension ?? _originalFileName;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = _fileName;

    return data;
  }
}
