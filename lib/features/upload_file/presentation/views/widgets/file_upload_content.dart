import 'dart:io';
import 'package:filehive/core/utils/colors.dart';
import 'package:filehive/core/utils/helper/allowed_extensions.dart';
import 'package:filehive/core/utils/styles_text.dart';
import 'package:filehive/core/widgets/import_icon.dart';
import 'package:filehive/features/upload_file/presentation/manager/file_upload_bloc/file_upload_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileUploadContent extends StatelessWidget {
  const FileUploadContent({
    super.key,
    required this.fillColor,
  });
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    bool selectOther = false;

    final FileUploadBloc fileUploadBloc =
        BlocProvider.of<FileUploadBloc>(context);

    if (fileUploadBloc.selectedFile.file != null) {
      File selectedFile = fileUploadBloc.selectedFile.file!;
      String selectedFileName = fileUploadBloc.selectedFile.originalFileName!;
      selectOther = true;
      bool isImage = AllowedExtensions.imagesTypes.contains(
        selectedFile.path.split('.').last.toLowerCase(),
      );

      return Stack(
        alignment: Alignment.center,
        children: [
          if (isImage)
            Image.file(
              File(selectedFile.path),
              fit: BoxFit.cover,
              width: double.maxFinite,
            )
          else
            const Icon(
              Icons.insert_drive_file,
              size: 70,
              color: kPrimaryColor,
            ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 38),
            alignment: Alignment.bottomCenter,
            child: Text(
              selectedFileName,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 12, color: Colors.white, shadows: [
                Shadow(
                    // bottomLeft
                    offset: Offset(-0.7, -0.7),
                    color: Colors.black),
                Shadow(
                    // bottomRight
                    offset: Offset(0.7, -0.7),
                    color: Colors.black),
                Shadow(
                    // topRight
                    offset: Offset(0.7, 0.7),
                    color: Colors.black),
                Shadow(
                    // topLeft
                    offset: Offset(-0.7, 0.7),
                    color: Colors.black),
              ]),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Visibility(
                visible: selectOther,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 0),
                            color: fillColor.withOpacity(0.4))
                      ],
                      border: Border.all(color: Colors.white),
                      shape: BoxShape.circle),
                  child: const ImportIcon(
                    color: Colors.white,
                  ),
                )),
          )
        ],
      );
    }

    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.file_upload_outlined,
            color: kPrimaryColor,
            size: 60,
          ),
          const SizedBox(height: 5),
          const Text(
            'Click to choose a file',
            style: StylesText.textHint16,
          ),
          Text(
            'Browse',
            style: StylesText.textStyle16.copyWith(
              color: kPrimaryColor,
              decoration: TextDecoration.underline,
              decorationColor: kPrimaryColor,
              decorationThickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
