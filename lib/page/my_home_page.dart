import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/page/post_page.dart';
import 'package:http/http.dart' as http;

// StatefulWidgetを継承すると、Stateを扱えるようになる
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // MyHomePageState で使う State を作る宣言
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// AIとのトーク画面
class _MyHomePageState extends State<MyHomePage> {
  String text = "";

  /// 投稿ページ呼び出し
  Future<void> openPostPage() async {
    final v = await Navigator.push(
      context,
      // 戻り値の型指定に注意！！
      // <void>を指定したため、戻り値の受け取りでビルドエラーが発生した
      MaterialPageRoute(
        builder: (BuildContext context) => const PostPage(),
        fullscreenDialog: true,
      ),
    );

    // デフォルトの×ボタン(戻るボタン)では、nullが返されるs
    if (v != null) {
      setState(() {
        text = v;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Chat by リクルートA3RT Talk API"),
      ),
      body: Center(
        child: Column(
          children: [
            // TextFieldの中身を表示させるため
            Text(text),
          ],
        ),
      ),
      // 画面をスクロールしても一定位置に表示され続ける
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await openPostPage();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.create),
      ),
    );
  }
}
