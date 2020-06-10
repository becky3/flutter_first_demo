import 'package:flutter/material.dart';
import 'package:flutterfirstdemo/page/favorite_page.dart';
import 'package:provider/provider.dart';

import 'package:flutterfirstdemo/model/favorite_notifier.dart';

import 'page/detail_page.dart';
import 'page/search_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteNotifier>(
      create: (context) => FavoriteNotifier(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/',
          routes: {
            '/': (_) => MyHomePage(title: 'Flutter Demo Home Page'),
            '/searchPage': (_) => SearchPage(title: "リポジトリ検索"),
            '/detailPage': (_) => DetailPage(title: '詳細'),
          }),
    );
  }
}

class TabInfo {
  String label;
  Widget widget;
  TabInfo(this.label, this.widget);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TabInfo> _tabs = [
    TabInfo("🔎 検索", SearchPage()),
    TabInfo("⭐ お気に入り", FavoritePage()),
  ];

  @override
  Widget build(BuildContext context) {
    final favoriteProvider =
        Provider.of<FavoriteNotifier>(context, listen: false);
    favoriteProvider.loadFavorites();

    print("build");

    return MainTab(tabs: _tabs);
  }
}

class MainTab extends StatelessWidget {
  const MainTab({
    Key key,
    @required List<TabInfo> tabs,
  })  : _tabs = tabs,
        super(key: key);

  final List<TabInfo> _tabs;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: _appBar(),
        body: TabBarView(children: _tabs.map((tab) => tab.widget).toList()),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('Flutter First Demo'),
      bottom: PreferredSize(
        child: TabBar(
          isScrollable: true,
          tabs: _tabs.map((TabInfo tab) {
            return Tab(text: tab.label);
          }).toList(),
        ),
        preferredSize: Size.fromHeight(30.0),
      ),
    );
  }
}
