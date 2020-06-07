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
  var _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final DetailPageArguments args = ModalRoute.of(context).settings.arguments;
    print("url:${args.url}");

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite,
                color: _isFavorite
                    ? Colors.yellow
                    : Color.fromARGB(255, 0, 100, 0)),
            onPressed: _onPressedFavorite,
          ),
        ],
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

  void _onPressedFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
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
