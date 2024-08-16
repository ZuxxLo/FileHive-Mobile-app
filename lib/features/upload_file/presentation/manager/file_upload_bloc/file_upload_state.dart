part of 'file_upload_bloc.dart';

@immutable
sealed class FileUploadState {}

final class FileUploadInitial extends FileUploadState {}

final class FileUploadLoading extends FileUploadState {}

final class FileUploadFailure extends FileUploadState {
  final String errorMessage;

  FileUploadFailure({required this.errorMessage});
}

final class FileUploadSuccess extends FileUploadState {
  final CreateFileModel file;
  final String message;

  FileUploadSuccess({required this.file, required this.message});
}

final class FileSelectedSuccess extends FileUploadState {
  final CreateFileModel selectedFile;

  FileSelectedSuccess({required this.selectedFile});
}

final class FileSelectedFailure extends FileUploadState {
  final String errorMessage;

  FileSelectedFailure({required this.errorMessage});
}
