import 'package:flutter/material.dart';
import '../webview.dart';

class FirstView extends StatelessWidget {
  const FirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
          child: WebView()
    );
  }
}
