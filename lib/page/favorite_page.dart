import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirstdemo/model/favorite_notifier.dart';
import 'package:provider/provider.dart';

import '../entity/github_repo.dart';
import 'detail_page.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteNotifier>(
      builder: (context, notifier, _) {
        final favorites = notifier.favorites;
        return Scaffold(
          body: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final item = favorites[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black38),
                  ),
                ),
                child: ListTile(
                    leading: CachedNetworkImage(
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        imageUrl: 'https://github.com/${item.name}.png'),
                    title: Text(item.fullName),
                    subtitle: Text(item.description),
                    onTap: () {
                      _didTapItem(context, item);
                    }),
              );
            },
            itemCount: favorites?.length ?? 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              final provider =
                  Provider.of<FavoriteNotifier>(context, listen: false);
              provider.clearFavorites();
            },
            tooltip: 'Clear Favorites',
            child: Icon(Icons.delete),
          ),
        );
      },
    );
  }

  void _didTapItem(context, GithubRepo item) {
    Navigator.pushNamed(
      context,
      '/detailPage',
      arguments: DetailPageArguments(item),
    );
  }
}
