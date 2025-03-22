import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final WebViewController _controller;
  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://storktic.com/'))
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: _handleLoad,
      ),
    );
    addFileSelectionListener();
  }

  void addFileSelectionListener() async {
    if (Platform.isAndroid) {
      final androidController =
          _controller.platform as AndroidWebViewController;
      await androidController.setOnShowFileSelector(_androidFilePicker);

    } else if (Platform.isIOS) {
        final _ = _controller.platform as WebKitWebViewController;
         // await iosController.setAllowsLinkPreview(true);
    } else {
        print("NOT Android or iOS");
    }
  }

  Future<List<String>> _androidFilePicker(FileSelectorParams params) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      return [file.uri.toString()];
    }
    return [];
  }


  void _handleLoad(String value) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
        controller: _controller);
  }
}