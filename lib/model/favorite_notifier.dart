import 'package:flutter/cupertino.dart';
import 'package:flutterfirstdemo/entity/github_repo.dart';

import 'package:flutterfirstdemo/model/favorite_repository.dart';

class FavoriteNotifier extends ChangeNotifier {
  final _favoriteRepository = FavoriteRepository.shared;

  List<GithubRepo> get favorites => _favoriteRepository.favorites;

  void loadFavorites() {
    _favoriteRepository.loadFavorites().then(
          (value) => notifyListeners(),
        );
  }

  bool contains(GithubRepo repo) {
    return _favoriteRepository.contains(repo);
  }

  void addFavorite(GithubRepo repo) {
    _favoriteRepository.addFavorite(repo);
    notifyListeners();
  }

  void removeFavorite(GithubRepo repo) {
    _favoriteRepository.removeFavorite(repo);
    notifyListeners();
  }

  void clearFavorites() {
    _favoriteRepository.clear();
    notifyListeners();
  }
}
