import 'package:flutter/material.dart';
import 'package:flutterfirstdemo/favorite_repository.dart';

import '../entity/github_repo.dart';
import 'detail_page.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final _favoriteRepository = FavoriteRepository.shared;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getFavorites(),
      builder: (context, snapshot) {
        final favorites = snapshot.data;
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
                    leading:
                        Image.network('https://github.com/${item.name}.png'),
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
            onPressed: _clearFavorites,
            tooltip: 'Clear Favorites',
            child: Icon(Icons.delete),
          ),
        );
      },
    );
  }

  void _clearFavorites() {
    setState(() {
      _favoriteRepository.clear();
    });
  }

  Future<List<GithubRepo>> _getFavorites() async {
    return _favoriteRepository.getFavorites();
  }

  void _didTapItem(context, GithubRepo item) {
    Navigator.pushNamed(context, '/detailPage',
        arguments: DetailPageArguments(item));
  }
}
