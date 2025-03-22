import 'package:flutter/material.dart';
import '../webview.dart';

class FirstView extends StatelessWidget {
  const FirstView({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return Center(
          child: WebView(url:url)
    );
  }
}
