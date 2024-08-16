import 'package:filehive/core/utils/helper/allowed_extensions.dart';
import 'package:filehive/core/utils/images.dart';
import 'package:filehive/core/widgets/custom_circular_progress.dart';
import 'package:filehive/core/widgets/custom_error_widget.dart';
import 'package:filehive/features/home/presentation/manager/home_bloc/home_bloc.dart';
import 'package:filehive/features/home/data/models/file_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'file_type_card.dart';
import 'image_display.dart';

class OthersBuilderSectionTBVB extends StatelessWidget {
  const OthersBuilderSectionTBVB({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    Future<void> openFile(String url) async {
      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $url';
      }
    }

    Future<dynamic> showImage(
      BuildContext context,
      String fileUrl,
    ) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ImageDisplay(imageUrl: fileUrl),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () => openFile(fileUrl),
                    icon: Container(
                        padding: const EdgeInsets.all(4.0),
                        margin: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 0),
                                  color: Colors.black.withOpacity(0.4))
                            ],
                            border: Border.all(color: Colors.white),
                            shape: BoxShape.circle),
                        child: const Icon(
                          Icons.download,
                          color: Colors.white,
                        )),
                  ),
                )
              ],
            ),
          );
        },
      );
    }

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          List<FileModel>? myFilesCategoriezed = state.myFilesCategoriezed?[
              AllowedExtensions.categories.keys.toList()[index]];

          if (myFilesCategoriezed!.isEmpty) {
            return SvgPicture.asset(
              noFilesImage1,
            );
          } else {
            return GridView.builder( padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: myFilesCategoriezed.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1),
              itemBuilder: (context, index) {
                final fileType =
                    myFilesCategoriezed[index].fileType?.toLowerCase();
                final title =
                    "${myFilesCategoriezed[index].title!}.${myFilesCategoriezed[index].fileType!}";
                final fileUrl = myFilesCategoriezed[index].file.toString();
                return InkWell(
                  onTap: () async {
                    if (AllowedExtensions.imagesTypes
                        .contains(fileType!.toLowerCase())) {
                      showImage(context, fileUrl);
                    } else {
                      openFile(myFilesCategoriezed[index].file!);
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.all(2),
                    color: Colors.white,
                    child: Builder(
                      builder: (context) {
                        if (AllowedExtensions.imagesTypes.contains(fileType)) {
                          return ImageDisplay(imageUrl: fileUrl);
                        } else if (AllowedExtensions.documentsTypes
                            .contains(fileType)) {
                          return FileTypeCard(iconPath: pdfIcon, title: title);
                        } else if (AllowedExtensions.archivesTypes
                            .contains(fileType)) {
                          return FileTypeCard(
                              iconPath: archiveIcon, title: title);
                        } else if (AllowedExtensions.executablesTypes
                            .contains(fileType)) {
                          return FileTypeCard(iconPath: exeIcon, title: title);
                        }

                        // Return a default widget or an empty container if the type doesn't match
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                );
              },
            );
          }
        } else if (state is HomeFailure) {
          return CustomErrorWidget(errMessage: state.errorMessage);
        }
        return const CustomCircularProgressIndicator();
      },
    );
  }
}
