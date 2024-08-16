import 'package:filehive/core/utils/colors.dart';
import 'package:filehive/core/widgets/simple_back_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FileWebViewer extends StatelessWidget {
  const FileWebViewer({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    var controller = WebViewController()
      ..loadRequest(
        Uri.parse(url),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    return Scaffold(
      appBar: const SimpleBackAppBar(backgroundColor: kPrimaryColor,),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
