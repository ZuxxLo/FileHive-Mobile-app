import 'package:filehive/core/utils/colors.dart';
import 'package:filehive/core/utils/images.dart';
import 'package:filehive/core/utils/other_constants.dart';
import 'package:filehive/core/utils/styles_text.dart';
import 'package:filehive/core/widgets/custom_error_widget.dart';
import 'package:filehive/features/home/presentation/manager/home_bloc/home_bloc.dart';
import 'package:filehive/features/home/data/models/file_model.dart';
import 'package:filehive/features/home/presentation/views/widgets/custom_staggered_grid.dart';
import 'package:filehive/features/home/presentation/views/widgets/home_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllSectionTBVB extends StatelessWidget {
  const AllSectionTBVB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Create a map to hold the categorized items
    Map<String, List<FileModel>> itemsByFileType = {};
    categorizeByFileType(List<FileModel> myFilesList) {
      itemsByFileType.clear();
      // Iterate over the list and categorize items by fileType
      for (var file in myFilesList) {
        if (file.fileType != null) {
          if (!itemsByFileType.containsKey(file.fileType)) {
            itemsByFileType[file.fileType!] = [];
          }
          itemsByFileType[file.fileType]!.add(file);
        }
      }

      // Print the map to verify the result
      itemsByFileType.forEach((fileType, fileList) {
        print('$fileType: ${fileList.length} items');
        for (var file in fileList) {
          print('  - ${file.title}');
        }
      });
    }

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          final myFilesList = state.myFiles;
          categorizeByFileType(myFilesList);
          print("--------------------------------");
          print(itemsByFileType.length);
          // Categorize files into broader categories
          if (itemsByFileType.isEmpty) {
            return SvgPicture.asset(
              noFilesImage1,
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              itemCount: itemsByFileType.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = itemsByFileType.entries.elementAt(index);
                return Card(
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                      borderRadius: generalBorderRadius10),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.key.toUpperCase(),
                              style: StylesText.textStyle16,
                            ),
                            TextButton(
                              style: const ButtonStyle(
                                  minimumSize:
                                      WidgetStatePropertyAll(Size.zero),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  padding:
                                      WidgetStatePropertyAll(EdgeInsets.zero),
                                  iconColor:
                                      WidgetStatePropertyAll(kPrimaryColor),
                                  backgroundColor:
                                      WidgetStatePropertyAll(transparentColor)),
                              child: Row(
                                children: [
                                  Text(
                                    "See All",
                                    style: StylesText.textStyle16
                                        .copyWith(color: kPrimaryColor),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: kPrimaryColor,
                                  ),
                                ],
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      CustomStaggeredGrid(
                        value: item,
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 15),
            );
          }
        } else if (state is HomeFailure) {
          return CustomErrorWidget(errMessage: state.errorMessage);
        } else {
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) => const HomeLoadingScreen(),
          );
        }
      },
    );
  }
}
