import 'package:dartz/dartz.dart';
import 'package:filehive/core/errors/api_failures.dart';
import 'package:filehive/features/upload_file/data/models/create_file_model.dart';
import 'package:filehive/features/upload_file/data/models/respone_upload_file.dart';

abstract class UploadFileRepo {
  Future<Either<DioFailure, ResposeUploadFile>> uploadNewFile(
      {required String accessToken, required CreateFileModel createFileModel});
}
