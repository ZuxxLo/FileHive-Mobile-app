import 'package:filehive/features/authentication/presentation/manager/user_bloc/user_bloc.dart';
import 'package:filehive/features/home/data/models/file_model.dart';
import 'package:filehive/features/upload_file/data/models/create_file_model.dart';
import 'package:filehive/features/upload_file/data/repositories/repositories/upload_file_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'file_upload_event.dart';
part 'file_upload_state.dart';

class FileUploadBloc extends Bloc<FileUploadEvent, FileUploadState> {
  final UploadFileRepoImpl uploadFileRepo;
  final UserBloc userBloc;

  FileUploadBloc({required this.uploadFileRepo, required this.userBloc})
      : super(FileUploadInitial()) {
    on<SelectFileEvent>(
      (event, emit) {
        emit(FileSelectedSuccess(
          selectedFile: selectedFile,
        ));
      },
    );

    on<UploadFileEvent>(
      (event, emit) async {
        if (selectedFile.file != null) {
          emit(FileUploadLoading());

          var response = await uploadFileRepo.uploadNewFile(
              accessToken: userBloc.userRepository.accessToken!,
              createFileModel: selectedFile);

          response.fold(
            (failure) {
              print(failure.errMessage);
              emit(FileUploadFailure(errorMessage: failure.errMessage));
            },
            (resposeUploadFile) {
              print(resposeUploadFile);
              uploadedFiles.add(resposeUploadFile.file);

              selectedFile = CreateFileModel();

              emit(FileUploadSuccess(
                  file: selectedFile, message: resposeUploadFile.message!));
            },
          );
        } else {
          emit(FileSelectedFailure(errorMessage: "Please select a file"));
        }
      },
    );
  }
  CreateFileModel selectedFile = CreateFileModel();
  List<FileModel?> uploadedFiles = <FileModel>[];

  onChangedFileName(String value) {
    selectedFile.setFile(fileName: value);
  }
}
