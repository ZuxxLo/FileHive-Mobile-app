import 'package:filehive/core/utils/colors.dart';
import 'package:filehive/core/utils/styles_text.dart';
import 'package:filehive/features/upload_file/presentation/manager/file_upload_bloc/file_upload_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileValidatorMessage extends StatelessWidget {
  const FileValidatorMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: BlocBuilder<FileUploadBloc, FileUploadState>(
        builder: (context, state) {
          if (state is FileSelectedFailure) {
            return Text(
              state.errorMessage,
              style: StylesText.textStyle14.copyWith(color: redColor),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
