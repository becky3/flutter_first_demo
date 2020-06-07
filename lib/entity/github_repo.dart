import 'dart:convert' show json;

class GithubRepo {
  var name;
  var fullName;
  var starCount;
  var avatarUrl;
  var description;
  var htmlUrl;

  static fromJson(jsonData) {
    var data = json.decode(jsonData);
    List<dynamic> itemList = data['items'];

    return itemList.map((item) {
      var repo = new GithubRepo();
      Map<String, Object> owner = item['owner'];
      repo.avatarUrl = owner['avatar_url'];
      repo.name = item['name'];
      repo.fullName = item['full_name'];
      repo.starCount = item['stargazers_count'];
      repo.description = item['description'];
      repo.htmlUrl = item['html_url'];
      return repo;
    }).toList();
  }
}
