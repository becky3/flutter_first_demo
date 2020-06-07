import 'dart:convert';

const _separator = "@@@@@@@@";

// TODO: JSON形式で encode decode する
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

  String encode() {
    final data = [
      name,
      fullName,
      starCount.toString(),
      description,
      htmlUrl,
    ];
    return data.join(_separator);
  }

  static GithubRepo createFromEncodeData(String value) {
    final data = value.split(_separator);
    return GithubRepo(data[0], data[1], int.parse(data[2]), data[3], data[4]);
  }

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
