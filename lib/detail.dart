import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    final DetailPageArguments args = ModalRoute.of(context).settings.arguments;
    print("url:${args.url}");

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: WebView(
        initialUrl: args.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _controller = controller;
        },
      ),
    );
  }
}

class DetailPageArguments {
  final String title;
  final String url;

  DetailPageArguments(
    this.title,
    this.url,
  );
}
