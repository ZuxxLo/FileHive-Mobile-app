import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:filehive/core/utils/colors.dart';
import 'package:filehive/core/utils/helper/allowed_extensions.dart';
import 'package:filehive/core/utils/helper/helper_functions.dart';
import 'package:filehive/core/utils/images.dart';
import 'package:filehive/core/utils/service_locator.dart';
import 'package:filehive/core/utils/styles_text.dart';
import 'package:filehive/core/widgets/shake_widget.dart';
import 'package:filehive/core/widgets/simple_back_app_bar.dart';
import 'package:filehive/features/home/data/models/file_model.dart';
import 'package:filehive/features/home/presentation/manager/home_bloc/home_bloc.dart';
import 'package:filehive/features/home/presentation/views/widgets/file_type_card.dart';
import 'package:filehive/features/home/presentation/views/widgets/image_display.dart';
import 'package:filehive/features/upload_file/presentation/manager/file_upload_bloc/file_upload_bloc.dart';

import 'widgets/file_upload_section.dart';
import 'widgets/title_text_field.dart';

class UploadFile extends StatelessWidget {
  const UploadFile({super.key});

  @override
  Widget build(BuildContext context) {
    print("UploadFile Widget build");
    FileUploadBloc fileUploadBloc = BlocProvider.of<FileUploadBloc>(context);

    Color fillColor = kSecondaryColor.withOpacity(0.1);
    final formKey = GlobalKey<FormState>();
    final textFieldShakeKey = GlobalKey<ShakeWidgetState>();
    final fileShakeKey = GlobalKey<ShakeWidgetState>();
    void onPressedButton(BuildContext context) {
      FocusManager.instance.primaryFocus?.unfocus();

      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        FocusManager.instance.primaryFocus?.unfocus();
      } else {
        textFieldShakeKey.currentState?.shake();
      }

      if (fileUploadBloc.selectedFile.file != null) {
      } else {
        fileShakeKey.currentState?.shake();
      }

      fileUploadBloc.add(UploadFileEvent());
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => onPressedButton(context),
        icon: const Text('Upload file'),
        label: const Icon(Icons.file_upload_outlined),
        // icon: Icon(Icons.file_upload_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: const SimpleBackAppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: BlocListener<FileUploadBloc, FileUploadState>(
        listener: (context, state) {
          if (state is FileUploadLoading) {
            HelperFunctions.showdDialog(
                context: context, loading: true, message: "Uploading...");
          } else if (state is FileUploadFailure) {
            HelperFunctions.showSnackBar(
                context: context, message: state.errorMessage);
          } else if (state is FileUploadSuccess) {
            Navigator.of(context).pop();
            ServiceLocator.getIt.get<HomeBloc>().add(LoadMyFilesEvent());
            HelperFunctions.showSnackBar(
                context: context, message: state.message, color: Colors.green);
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Card(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "File name",
                          style: StylesText.textStyle16,
                        ),
                        TitleTextField(
                            formKey: formKey,
                            textFieldShakeKey: textFieldShakeKey,
                            fillColor: fillColor),
                        const SizedBox(height: 10),
                        FileUploadSection(
                            fileShakeKey: fileShakeKey, fillColor: fillColor),
                        const SizedBox(height: 10),
                      ]),
                ),
              ),
            ),
            BlocBuilder<FileUploadBloc, FileUploadState>(
              builder: (context, state) {
                return SliverToBoxAdapter(
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Recent uploads",
                            style: StylesText.textStyle16,
                          ),
                          const SizedBox(height: 10),
                          if (fileUploadBloc.uploadedFiles.isEmpty)
                            Center(
                              child: Column(
                                children: [
                                  NoFilesUploadedYet(fillColor: fillColor),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "You haven't uploaded any files yet.",
                                    style: StylesText.textHint16,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: fileUploadBloc.uploadedFiles.length,
                              itemBuilder: (context, index) {
                                FileModel uploadedFile =
                                    fileUploadBloc.uploadedFiles[index]!;
                                return Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  clipBehavior: Clip.hardEdge,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: fillColor,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        color: kSecondaryColor,
                                        child: FileDisplay(file: uploadedFile),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "${uploadedFile.title!}.${uploadedFile.fileType!}",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
          ],
        ),
      ),
    );
  }
}

class NoFilesUploadedYet extends StatelessWidget {
  const NoFilesUploadedYet({
    super.key,
    required this.fillColor,
  });
  final Color fillColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: 220,
      child: SvgPicture.asset(noFilesImage),
    );
  }
}

class FileDisplay extends StatelessWidget {
  final FileModel file;

  const FileDisplay({
    super.key,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (AllowedExtensions.imagesTypes.contains(file.fileType!.toLowerCase())) {
      content = ImageDisplay(imageUrl: file.file!);
    } else if (AllowedExtensions.documentsTypes
        .contains(file.fileType!.toLowerCase())) {
      content = FileTypeCard(iconPath: pdfIcon, title: null);
    } else if (AllowedExtensions.executablesTypes
        .contains(file.fileType!.toLowerCase())) {
      content = FileTypeCard(iconPath: exeIcon, title: null);
    } else if (AllowedExtensions.archivesTypes
        .contains(file.fileType!.toLowerCase())) {
      content = FileTypeCard(iconPath: archiveIcon, title: null);
    } else {
      content = const SizedBox.shrink();
    }

    return content;
  }
}
