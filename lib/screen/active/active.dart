import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ActiveScreen extends StatelessWidget {
  const ActiveScreen({
    super.key,
    required this.a,
  });
  final String a;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(a),
          ),
        ),
      ),
    );
  }
}
