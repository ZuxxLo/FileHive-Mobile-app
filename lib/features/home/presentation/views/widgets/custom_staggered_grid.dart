import 'package:filehive/core/utils/helper/allowed_extensions.dart';
import 'package:filehive/core/utils/images.dart';
import 'package:filehive/core/utils/other_constants.dart';
import 'package:filehive/features/home/data/models/file_model.dart';
import 'package:filehive/features/home/presentation/views/widgets/image_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'file_type_card.dart';
import 'plus_value_display.dart';

class CustomStaggeredGrid extends StatelessWidget {
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final MapEntry<String, List<FileModel>> value;

  const CustomStaggeredGrid({
    required this.value,
    this.mainAxisSpacing = 2,
    this.crossAxisSpacing = 2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final items = value.value;
    final crossAxisCount = GridLayoutHelper.getCrossAxisCount(items.length);
    final gridItems = GridLayoutHelper.getGridItems(items.length);

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: generalBorderRadius10),
      child: StaggeredGrid.count(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        children: List.generate(
          gridItems.length,
          (index) => GridTile(
            gridItem: gridItems[index],
            index: index,
            value: value,
          ),
        ),
      ),
    );
  }
}

class GridTile extends StatelessWidget {
  final GridItem gridItem;
  final int index;
  final MapEntry<String, List<FileModel>> value;

  const GridTile({
    required this.gridItem,
    required this.index,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final itemsLength = value.value.length;
    final isMoreThan10 = itemsLength >= 10;
    final isMoreThan4 = itemsLength >= 4;
    // Calculate plusValue
    int plusValue = 0;
    if (isMoreThan10) {
      plusValue = itemsLength - 6;
    } else if (isMoreThan4) {
      plusValue = itemsLength - 4;
    }
    // Determine the correct position to show the plus value
    bool shouldShowPlusValue = false;
    if (isMoreThan10 && index == 2) {
      shouldShowPlusValue = true;
    } else if (isMoreThan4 && !isMoreThan10 && index == 3) {
      shouldShowPlusValue = true;
    }
    final title =
        "${value.value[index].title!}.${value.value[index].fileType!}";
    return StaggeredGridTile.count(
      crossAxisCellCount: gridItem.crossAxisCellCount,
      mainAxisCellCount: gridItem.mainAxisCellCount,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          if (AllowedExtensions.imagesTypes.contains(value.key.toLowerCase()))
            ImageDisplay(imageUrl: value.value[index].file!)
          else if (AllowedExtensions.documentsTypes
              .contains(value.key.toLowerCase()))
            BuildFileContainer(iconPath: pdfIcon, title: title)
          else if (AllowedExtensions.executablesTypes
              .contains(value.key.toLowerCase()))
            BuildFileContainer(iconPath: exeIcon, title: title)
          else if (AllowedExtensions.archivesTypes
              .contains(value.key.toLowerCase()))
            BuildFileContainer(iconPath: archiveIcon, title: title),
          if (shouldShowPlusValue)
            PlusValueDisplay(plusValue: plusValue),
        ],
      ),
    );
  }
}

class BuildFileContainer extends StatelessWidget {
  const BuildFileContainer(
      {super.key, required this.iconPath, required this.title});

  final String iconPath;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        borderRadius: generalBorderRadius10,
      ),
      child: FileTypeCard(iconPath: iconPath, title: title),
    );
  }
}

class GridItem {
  final int crossAxisCellCount;
  final int mainAxisCellCount;

  GridItem({
    required this.crossAxisCellCount,
    required this.mainAxisCellCount,
  });
}

class GridLayoutHelper {
  static int getCrossAxisCount(int length) {
    if (length >= 10) return 5;
    if (length >= 4) return 4;
    if (length == 3) return 3;
    return 2;
  }

  static List<GridItem> getGridItems(int length) {
    if (length >= 10) return GridLayouts.han10Layout;
    if (length >= 4) return GridLayouts.han4Layout;
    if (length == 3) return GridLayouts.han3Layout;
    if (length == 2) return GridLayouts.han2Layout;
    return GridLayouts.han1Layout;
  }
}

class GridLayouts {
  static final List<GridItem> han4Layout = [
    GridItem(crossAxisCellCount: 2, mainAxisCellCount: 2),
    GridItem(crossAxisCellCount: 2, mainAxisCellCount: 1),
    GridItem(crossAxisCellCount: 1, mainAxisCellCount: 1),
    GridItem(crossAxisCellCount: 1, mainAxisCellCount: 1),
  ];

  static final List<GridItem> han10Layout = [
    GridItem(crossAxisCellCount: 3, mainAxisCellCount: 2),
    GridItem(crossAxisCellCount: 2, mainAxisCellCount: 1),
    GridItem(crossAxisCellCount: 2, mainAxisCellCount: 2),
    GridItem(crossAxisCellCount: 1, mainAxisCellCount: 1),
    GridItem(crossAxisCellCount: 1, mainAxisCellCount: 1),
    GridItem(crossAxisCellCount: 1, mainAxisCellCount: 1),
  ];

  static final List<GridItem> han3Layout = [
    GridItem(crossAxisCellCount: 2, mainAxisCellCount: 2),
    GridItem(crossAxisCellCount: 1, mainAxisCellCount: 1),
    GridItem(crossAxisCellCount: 1, mainAxisCellCount: 1),
  ];

  static final List<GridItem> han2Layout = [
    GridItem(crossAxisCellCount: 1, mainAxisCellCount: 1),
    GridItem(crossAxisCellCount: 1, mainAxisCellCount: 1),
  ];

  static final List<GridItem> han1Layout = [
    GridItem(crossAxisCellCount: 2, mainAxisCellCount: 1),
  ];
}
