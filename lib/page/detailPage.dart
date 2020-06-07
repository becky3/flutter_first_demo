import 'package:flutter/material.dart';
import 'package:flutterfirstdemo/favorite_repository.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../entity/github_repo.dart';

class DetailPage extends StatefulWidget {
  final String title;

  DetailPage({Key key, this.title}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  WebViewController _controller;
  FavoriteRepository _favoriteRepository = FavoriteRepository.shared;

  @override
  Widget build(BuildContext context) {
    final DetailPageArguments args = ModalRoute.of(context).settings.arguments;
    final repo = args.githubRepo;

    return Scaffold(
      appBar: AppBar(
        title: Text(repo.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite,
                color: _isFavorite(repo)
                    ? Colors.yellow
                    : Color.fromARGB(255, 0, 100, 0)),
            onPressed: () {
              _onPressedFavorite(repo);
            },
          ),
        ],
      ),
      body: WebView(
        initialUrl: repo.htmlUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _controller = controller;
        },
      ),
    );
  }

  bool _isFavorite(GithubRepo repo) => _favoriteRepository.contains(repo);

  void _onPressedFavorite(GithubRepo repo) {
    setState(() {
      if (_isFavorite(repo)) {
        _favoriteRepository.removeFavorite(repo);
      } else {
        _favoriteRepository.addFavorite(repo);
      }
    });
  }
}

class DetailPageArguments {
  final GithubRepo githubRepo;

  DetailPageArguments(
    this.githubRepo,
  );
}
