import 'package:filehive/core/utils/colors.dart';
import 'package:flutter/material.dart';

class SimpleBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SimpleBackAppBar({
    super.key,
    this.backgroundColor = transparentColor,
    this.title,
  });
  final Color backgroundColor;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: title != null ? Text(title!) : null,
      foregroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.white,
        ),
        onPressed: Navigator.of(context).pop,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
