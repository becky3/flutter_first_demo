const String _key = "favorites";

class FavoriteRepository {
  static final shared = FavoriteRepository._internal();

  FavoriteRepository._internal();

  List<String> _favoriteList = [];

  List<String> getFavorites() {
    return _favoriteList;
  }

  bool contains(String name) {
    return _favoriteList.contains(name);
  }

  void addFavorite(String name) {
    if (contains(name)) {
      return;
    }
    _favoriteList.add(name);
  }

  void removeFavorite(String name) {
    final index = _favoriteList.indexOf(name);
    if (index < 0) {
      return;
    }
    _favoriteList.removeAt(index);
  }
}
