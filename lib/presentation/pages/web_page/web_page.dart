import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebPage extends StatelessWidget {
  WebPage({super.key, required this.title, required this.htmlData});

  final String title;
  final String htmlData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: InAppWebView(
          //font size
          initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
            minimumFontSize: 12,
          )),

          initialData: InAppWebViewInitialData(
            data: htmlData,
          ),
        ));
  }
}
