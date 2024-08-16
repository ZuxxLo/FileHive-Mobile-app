import 'package:filehive/core/utils/helper/allowed_extensions.dart';
import 'package:filehive/features/authentication/presentation/manager/user_bloc/user_bloc.dart';
import 'package:filehive/features/home/data/repositories/list_my_files_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:filehive/features/home/data/models/file_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ListMyFilesRepoImpl listMyFilesRepo;

  final UserBloc userBloc;

  HomeBloc(this.listMyFilesRepo, this.userBloc) : super(HomeInitial()) {
    on<LoadMyFilesEvent>((event, emit) async {
      emit(HomeLoading());

      var response = await listMyFilesRepo.listMyfiles(
          accessToken: userBloc.userRepository.accessToken!);

      response.fold(
        (failure) {
          emit(HomeFailure(errorMessage: failure.errMessage));
        },
        (responseListMyFiles) {
          for (var element in responseListMyFiles.files!) {
              print(element.toJson());
            }

          emit(HomeSuccess(
              myFiles: responseListMyFiles.files ?? [],
              myFilesCategoriezed:
                  categorizeFiles(responseListMyFiles.files ?? [])));
        },
      );
    });
  }

  Map<String, List<FileModel>> categorizeFiles(List<FileModel> files) {
    // Get the categories from AllowedExtensions
    Map<String, List<String>> categories = AllowedExtensions.categories;
    // Create a map to hold the categorized items
    Map<String, List<FileModel>> categorizedFiles = {
      for (var category in categories.keys) category: [],
    };
    // Iterate over the list and categorize items
    for (var file in files) {
      if (file.fileType != null) {
        String fileType = file.fileType!.toLowerCase();
        categories.forEach((category, types) {
          if (types.contains(fileType)) {
            categorizedFiles[category]!.add(file);
          }
        });
      }
    }
    return categorizedFiles;
  }

  ScrollController scrollController = ScrollController();
  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
