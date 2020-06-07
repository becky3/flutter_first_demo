import 'package:flutter/material.dart';

import 'detail.dart';
import 'entity/github_repo.dart';
import 'github_api_session.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => MyHomePage(title: 'Flutter Demo Home Page'),
          '/detail': (_) => DetailPage(title: '詳細'),
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GithubRepo> _items = [];
  var _searchWord = "";
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final item = _items[index];
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black38),
              ),
            ),
            child: ListTile(
                leading: Image.network('https://github.com/${item.name}.png'),
                title: Text(item.fullName),
                subtitle: Text(item.description),
                onTap: () {
                  _didTapItem(context, item);
                }),
          );
        },
        itemCount: _items.length,
      ),
    );
  }

  void _onChangedText(String text) {
    _searchWord = text;
  }

  void _didTapItem(context, GithubRepo item) {
    Navigator.pushNamed(context, '/detail',
        arguments: DetailPageArguments(item.fullName, item.htmlUrl));
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
        print("result:$result");
        _items = result;
      });
    }).catchError((e) {
      print("error:$e");
    });
  }
}
