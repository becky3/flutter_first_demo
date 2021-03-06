import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirstdemo/model/github_api_session.dart';

import 'package:flutterfirstdemo/entity/github_repo.dart';

import 'detail_page.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<GithubRepo> _items = [];
  var _searchWord = "";
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: _appBar(),
      body: _listView(),
    );
  }

  ListView _listView() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final item = _items[index];
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black38),
            ),
          ),
          child: ListTile(
              leading: CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(),
                  imageUrl: 'https://github.com/${item.name}.png'),
              title: Text(item.fullName),
              subtitle: Text(item.description),
              onTap: () {
                _didTapItem(context, item);
              }),
        );
      },
      itemCount: _items.length,
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: TextField(
        decoration: InputDecoration(
          labelText: "Search repository name",
          hintText: "Please input repository name",
        ),
        onChanged: _onChangedText,
        controller: _textEditingController,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            _searchWord = "";
            _textEditingController.clear();
            _search();
          },
        ),
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            _search(searchWord: _searchWord);
          },
        ),
      ],
    );
  }

  void _onChangedText(String text) {
    _searchWord = text;
  }

  void _didTapItem(context, GithubRepo item) {
    Navigator.pushNamed(context, '/detailPage',
        arguments: DetailPageArguments(item));
  }

  void _search({String searchWord = ""}) {
    if (searchWord.isEmpty) {
      setState(() {
        _items = [];
        return;
      });
    }

    var client = GithubApiSessionClient();
    client.get(searchWord).then((result) {
      setState(() {
        _items = result;
      });
    }).catchError((e) {
      print("error:$e");
    });
  }
}
