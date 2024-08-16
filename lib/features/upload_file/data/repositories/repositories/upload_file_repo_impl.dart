import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:filehive/core/errors/api_failures.dart';
import 'package:filehive/core/utils/api/api_links.dart';
import 'package:filehive/core/utils/api/api_service.dart';
import 'package:filehive/features/upload_file/data/models/create_file_model.dart';
import 'package:filehive/features/upload_file/data/models/respone_upload_file.dart';
import 'package:filehive/features/upload_file/data/repositories/repositories/upload_file_repo.dart';

class UploadFileRepoImpl extends UploadFileRepo {
  final ApiService apiService;

  UploadFileRepoImpl(this.apiService);

  @override
  Future<Either<DioFailure, ResposeUploadFile>> uploadNewFile(
      {required String accessToken,
      required CreateFileModel createFileModel}) async {
    try {
      var data = await apiService.post(
          endPoint: ApiLinks.uploadFile,
          accessToken: accessToken,
          fileName: createFileModel.fileName,
          data: createFileModel.toJson(),
          file: createFileModel.file);

      ResposeUploadFile resposeUploadFile = ResposeUploadFile.fromJson(data);

      return right(resposeUploadFile);
    } catch (e) {
      print("***************");
      print(e);
      print("***************");

      if (e is DioException) {
        return left(
          ApiFailures.fromDioError(e),
        );
      }
      return left(
        ApiFailures(
          errMessage: e.toString(),
        ),
      );
    }
  }
}
