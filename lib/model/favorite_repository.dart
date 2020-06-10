import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutterfirstdemo/entity/github_repo.dart';

class FavoriteRepository {
  static final shared = FavoriteRepository._internal();

  static final _key = "favorites";

  FavoriteRepository._internal();

  List<GithubRepo> _favorites = [];

  List<GithubRepo> get favorites => _favorites;

  Future loadFavorites() async {
    final list = await _load();
    final convertedList =
        list.map((e) => GithubRepo.createFromJsonData(e)).toList();
    _favorites = convertedList;
  }

  bool contains(GithubRepo repo) {
    final item = _favorites.firstWhere(
        (element) => element.fullName == repo.fullName,
        orElse: () => null);
    return item != null;
  }

  void addFavorite(GithubRepo repo) {
    if (contains(repo)) {
      return;
    }
    _favorites.add(repo);
    _save();
  }

  void removeFavorite(GithubRepo repo) {
    final item = _favorites.firstWhere(
        (element) => element.fullName == repo.fullName,
        orElse: () => null);
    if (item == null) {
      return;
    }
    _favorites.remove(item);
    _save();
  }

  void clear() async {
    _favorites.clear();
    _save();
  }

  void _save() async {
    final prefs = await SharedPreferences.getInstance();
    final encodes = _favorites.map((e) => e.encode()).toList();
    await prefs.setStringList(_key, encodes);
  }

  Future<List<String>> _load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key);
  }
}
