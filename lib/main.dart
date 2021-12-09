import 'dart:convert';

import 'package:bilibili/dao/login_dao.dart';
import 'package:bilibili/db/hi_cache.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/http/core/hi_net.dart';
import 'package:bilibili/http/request/notic_request.dart';
import 'package:bilibili/http/request/test_request.dart';
import 'package:bilibili/model/owner.dart';
import 'package:bilibili/page/register_page.dart';
import 'package:bilibili/util/color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: RegisterPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    HiCache.preInit();
  }

  void _incrementCounter() async {
    testNotice();
  }

  void testNotice() async {
    try {
      var notice = await HiNet.getInstance().fire(NoticRequest());
      print("notice: $notice");
    } on HiNetError catch (e) {
      print("testNotice: ${e.message}");
    }
  }

  void testLogin() async {
    try {
      // var result = await LoginDao.register("huxiaoyou", "Mace0000", "9492498", "0419");
      var result = await LoginDao.login("huxiaoyou", "Mace0000");
      print("result: $result");
    } on NeedAuth catch (e) {
      print("NeedAuth: $e");
    } on HiNetError catch (e) {
      print("HiNetError: $e");
    }
  }

  void test() {
    const jsonString =
        "{ \"name\": \"flutter\", \"url\": \"https://coding.imooc.com/class/487.html\" }";

    // json 转 map
    var jsonMap = jsonDecode(jsonString);
    print(jsonMap['name']);
    print(jsonMap['url']);

    // map 转 json
    String json = jsonEncode(jsonMap);
    print(json);
  }

  void test1() {
    var ownerMap = {
      "name": "伊零Onezero",
      "face":
          "http://i2.hdslb.com/bfs/face/1c57a17a7b077ccd19dba58a981a673799b85aef.jpg",
      "fans": 12
    };

    Owner owner = Owner.fromJson(ownerMap);
    print(owner.name);
    print(owner.face);
    print(owner.fans);
  }

  void test2() {
    HiCache.getInstance().setString("aa", "123456");
    var value = HiCache.getInstance().get("aa");
    print("value: $value");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
