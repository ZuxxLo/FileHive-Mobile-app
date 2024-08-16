import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:filehive/core/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:filehive/core/utils/colors.dart';
import 'package:filehive/core/utils/helper/allowed_extensions.dart';
import 'package:filehive/core/utils/other_constants.dart';
import 'package:filehive/core/widgets/dashed_border_painter.dart';
import 'package:filehive/core/widgets/shake_widget.dart';
import 'package:filehive/features/upload_file/presentation/manager/file_upload_bloc/file_upload_bloc.dart';

import 'file_upload_content.dart';
import 'file_validator_message.dart';

class FileUploadSection extends StatelessWidget {
  const FileUploadSection({
    super.key,
    required this.fileShakeKey,
    required this.fillColor,
  });

  final GlobalKey<ShakeWidgetState> fileShakeKey;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    Future<void> onTapChooseFile() async {
      final FileUploadBloc fileUploadBloc =
          BlocProvider.of<FileUploadBloc>(context);

      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: [
            ...AllowedExtensions.imagesTypes,
            ...AllowedExtensions.documentsTypes,
            ...AllowedExtensions.archivesTypes,
            ...AllowedExtensions.executablesTypes,
          ],
        );

        if (result != null) {
          File file = File(result.files.single.path!);
          String ogfileName = result.files.single.name;

          fileUploadBloc.selectedFile.setFile(
            file: file,
            originalFileName: ogfileName,
          );
          fileUploadBloc.add(SelectFileEvent());
        } else {
          print("No file selected");
          if (context.mounted && fileUploadBloc.selectedFile.file == null) {
            HelperFunctions.showSnackBar(
                context: context, message: "No file was selected");
          }
        }
      } catch (e) {

        print(e);
      }
    }

    return ShakeWidget(
      key: fileShakeKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<FileUploadBloc, FileUploadState>(
            builder: (context, state) {
              bool fileUploadErr = false;
              if (state is FileSelectedFailure) {
                fileUploadErr = true;
              } else if (state is FileSelectedSuccess) {
                fileUploadErr = false;
              }

              return CustomPaint(
                foregroundPainter: DashedBorderPainter(
                    color: fileUploadErr ? redColor : kSecondaryColor),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: fillColor, borderRadius: generalBorderRadius10),
                  height: 170,
                  child: InkWell(
                    borderRadius: generalBorderRadius10,
                    onTap: () async {
                      onTapChooseFile();
                    },
                    child: FileUploadContent(
                      fillColor: fillColor,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 5),
          const FileValidatorMessage()
        ],
      ),
    );
  }
}
