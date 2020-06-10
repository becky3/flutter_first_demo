import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutterfirstdemo/model/favorite_notifier.dart';

import '../entity/github_repo.dart';

class DetailPage extends StatefulWidget {
  final String title;

  DetailPage({Key key, this.title}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final DetailPageArguments args = ModalRoute.of(context).settings.arguments;
    final repo = args.githubRepo;
    final provider = Provider.of<FavoriteNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(repo.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite,
                color: _isFavorite(provider, repo)
                    ? Colors.yellow
                    : Color.fromARGB(255, 0, 100, 0)),
            onPressed: () {
              _onPressedFavorite(provider, repo);
            },
          ),
        ],
      ),
      body: WebView(
        initialUrl: repo.htmlUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  bool _isFavorite(FavoriteNotifier provider, GithubRepo repo) =>
      provider.contains(repo);

  void _onPressedFavorite(FavoriteNotifier provider, GithubRepo repo) {
    setState(() {
      if (_isFavorite(provider, repo)) {
        provider.removeFavorite(repo);
      } else {
        provider.addFavorite(repo);
      }
    });
  }
}

class DetailPageArguments {
  final GithubRepo githubRepo;

  DetailPageArguments(this.githubRepo);
}
