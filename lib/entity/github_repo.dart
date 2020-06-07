import 'dart:convert';

class GithubRepo {
  final String name;
  final String fullName;
  final int starCount;
  final String description;
  final String htmlUrl;

  GithubRepo(
    this.name,
    this.fullName,
    this.starCount,
    this.description,
    this.htmlUrl,
  );

  static GithubRepo createFromMapData(mapData) => GithubRepo(
        mapData['name'],
        mapData['full_name'],
        mapData['stargazers_count'],
        mapData['description'],
        mapData['html_url'],
      );

  static createListFromJsonData(jsonData) {
    var data = json.decode(jsonData);
    List<dynamic> itemList = data['items'];

    return itemList.map((item) {
      return createFromMapData(item);
    }).toList();
  }
}
