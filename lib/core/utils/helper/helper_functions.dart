import 'package:filehive/core/utils/styles_text.dart';
import 'package:filehive/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

abstract class HelperFunctions {
  static Future<void> showSnackBar(
      {required BuildContext context,
      required String message,
      Color? color}) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
      ),
    );
  }

  static bool _isDialogActive = false;

  static showdDialog(
      {required BuildContext context,
      String? message,
      String? title,
      bool? canPop,
      bool loading = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    // Close the existing dialog if it is active
    if (_isDialogActive) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    // Set the flag to indicate a dialog is active
    _isDialogActive = true;

    showDialog(
        barrierDismissible: canPop ?? true,
        context: context,
        builder: (context) => PopScope(
              canPop: canPop ?? true,
              child: loading
                  ? AlertDialog(
                      title: Text(
                        message ?? "Please wait...",
                        style: StylesText.textStyle18,
                        textAlign: TextAlign.center,
                      ),
                      content: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CircularProgressIndicator()],
                      ),
                    )
                  : AlertDialog(
                      title: title == null
                          ? null
                          : Text(
                              title,
                              textAlign: TextAlign.center,
                              style: StylesText.textStyle18,
                            ),
                      content: message == null
                          ? null
                          : Text(
                              message,
                              style: StylesText.textStyle16,
                              textAlign: TextAlign.center,
                            ),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        CustomButton(
                          text: "Ok",
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    ),
            )).then((_) {
      // Reset the flag when the dialog is closed
      _isDialogActive = false;
    });
  }
}
