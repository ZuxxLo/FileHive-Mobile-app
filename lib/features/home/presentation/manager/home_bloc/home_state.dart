part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeFailure extends HomeState {
  final String errorMessage;

  HomeFailure({required this.errorMessage});
}

final class HomeSuccess extends HomeState {
  final List<FileModel> myFiles;
  final Map<String, List<FileModel>>? myFilesCategoriezed;

  HomeSuccess({required this.myFiles, this.myFilesCategoriezed});
}
