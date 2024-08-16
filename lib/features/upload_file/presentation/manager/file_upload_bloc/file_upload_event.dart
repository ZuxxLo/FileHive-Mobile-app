part of 'file_upload_bloc.dart';

@immutable
sealed class FileUploadEvent {}

class UploadFileEvent extends FileUploadEvent {
  UploadFileEvent();
}

class SelectFileEvent extends FileUploadEvent {
  SelectFileEvent();
}
