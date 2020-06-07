import 'dart:async';
import 'dart:convert' show utf8;
import 'dart:io';

import 'entity/github_repo.dart';

class GithubApiSessionClient {
  Future<List<GithubRepo>> get(String query) async {
    final url =
        'https://api.github.com/search/repositories?sort=stars&q=' + query;
    final httpClient = new HttpClient();

    print("url:$url");

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();

      print("statusCode:${response.statusCode}");

      if (response.statusCode != HttpStatus.ok) {
        return [];
      }

      var json = await response.transform(utf8.decoder).join();
      return GithubRepo.createListFromJsonData(json);
    } catch (exception) {
      print("error:$exception");
      return [];
    }
  }
}
