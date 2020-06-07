import 'dart:convert' show json;

class GithubRepo {
  var name;
  var fullName;
  var starCount;
  var avatarUrl;
  var description;

  static fromJson(jsonData) {
    print("json:$jsonData");
    var data = json.decode(jsonData);
    print("data:$data");
    data.forEach((key, value) {
      print("[$key]:$value");
    });
    List<dynamic> itemList = data['items'];

    return itemList.map((item) {
      var repo = new GithubRepo();
      Map<String, Object> owner = item['owner'];
      repo.avatarUrl = owner['avatar_url'];
      repo.name = item['name'];
      repo.fullName = item['full_name'];
      repo.starCount = item['stargazers_count'];
      repo.description = item['description'];
      return repo;
    }).toList();
  }
}
