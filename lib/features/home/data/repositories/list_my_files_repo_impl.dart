import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:filehive/core/errors/api_failures.dart';
import 'package:filehive/core/utils/api/api_links.dart';
import 'package:filehive/core/utils/api/api_service.dart';
import 'package:filehive/features/home/data/models/response_list_my_files.dart';
import 'package:filehive/features/home/data/repositories/list_my_files_repo.dart';

class ListMyFilesRepoImpl extends ListMyFilesRepo {
  final ApiService apiService;

  ListMyFilesRepoImpl(this.apiService);

  @override
  Future<Either<DioFailure, ResponseListMyFiles>> listMyfiles(
      {required String accessToken}) async {
    try {
      var data = await apiService.get(
          endPoint: ApiLinks.listMyfiles, accessToken: accessToken);

      ResponseListMyFiles responseListMyFiles =
          ResponseListMyFiles.fromJson(data);

      return right(responseListMyFiles);
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
