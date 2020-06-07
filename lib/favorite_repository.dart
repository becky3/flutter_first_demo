import 'entity/github_repo.dart';

// TODO: Dataの永続化
class FavoriteRepository {
  static final shared = FavoriteRepository._internal();

  FavoriteRepository._internal();

  List<String> _favoriteList = [];

  List<GithubRepo> getFavorites() {
    return _favoriteList.map((e) => GithubRepo.createFromJsonData(e)).toList();
  }

  bool contains(GithubRepo repo) {
    return _favoriteList.contains(repo.encode());
  }

  void addFavorite(GithubRepo repo) {
    if (contains(repo)) {
      return;
    }
    _favoriteList.add(repo.encode());
  }

  void removeFavorite(GithubRepo repo) {
    final index = _favoriteList.indexOf(repo.encode());
    if (index < 0) {
      return;
    }
    _favoriteList.removeAt(index);
  }
}
