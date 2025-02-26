import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the URL passed from the previous page
    final String url = Get.arguments as String;
    print("Opening URL: $url");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resource'),
        backgroundColor: Colors.teal,
      ),
      body: WebViewWidgetWithUrl(url: url), // Pass the URL to WebViewWidgetWithUrl
    );
  }
}

class WebViewWidgetWithUrl extends StatefulWidget {
  final String url;

  const WebViewWidgetWithUrl({super.key, required this.url});

  @override
  _WebViewWidgetWithUrlState createState() => _WebViewWidgetWithUrlState();
}

class _WebViewWidgetWithUrlState extends State<WebViewWidgetWithUrl> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the WebView and the controller
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));  // Load the passed URL
  }

  @override
  void dispose() {
    _controller.clearCache(); // Clear cache when leaving the screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Here, WebViewWidget no longer takes 'controller', but we directly use it in the WebViewController.
    return WebViewWidget(controller: _controller);  // WebViewWidget now takes the controller
  }
}
