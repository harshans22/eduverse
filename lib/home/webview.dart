

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class web extends StatefulWidget {
   web({super.key});

  @override
  State<web> createState() => _webState();
}

class _webState extends State<web> {
  final controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://experiments.withgoogle.com/collection/webvr"));

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: WebViewWidget(
            controller: controller,
            
          ),
        ),
      ),
    );
  }
}
