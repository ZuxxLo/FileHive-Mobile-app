import 'package:filehive/core/errors/text_field_validator.dart';
import 'package:filehive/core/utils/colors.dart';

import 'package:filehive/core/utils/other_constants.dart';
import 'package:filehive/core/widgets/prefix_icon_text_field.dart';
import 'package:filehive/core/widgets/shake_widget.dart';
import 'package:filehive/features/upload_file/presentation/manager/file_upload_bloc/file_upload_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/import_icon.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    super.key,
    required this.formKey,
    required this.textFieldShakeKey,
    required this.fillColor,
  });

  final GlobalKey<FormState> formKey;
  final GlobalKey<ShakeWidgetState> textFieldShakeKey;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    final FileUploadBloc fileUploadBloc =
        BlocProvider.of<FileUploadBloc>(context);
    return Form(
      key: formKey,
      child: ShakeWidget(
        key: textFieldShakeKey,
        child: BlocBuilder<FileUploadBloc, FileUploadState>(
          builder: (context, state) {
            String? fileNameNoExtension = fileUploadBloc.selectedFile.fileName;

            return TextFormField(
              onChanged: fileUploadBloc.onChangedFileName,
              key: Key(fileNameNoExtension.toString()), // <- Magic!

              initialValue: fileNameNoExtension,
              validator: (input) {
                return Validator.validateRequired(
                    input: input, field: "file name");
              },
              decoration: InputDecoration(
                      prefixIconConstraints: prefixIconBoxConstraints,
                      prefixIcon: const PrefixIconTextField(
                        iconWidget: ImportIcon(),
                      ),
                      hintText: "e.g., 'My Document'")
                  .copyWith(
                      fillColor: fillColor,
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor))),
            );
          },
        ),
      ),
    );
  }
}
