import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// StatefulWidgetを継承すると、Stateを扱えるようになる
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  // MyHomePageState で使う State を作る宣言
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Stateの変更とUIの描画
class _MyHomePageState extends State<MyHomePage> {
  // これがState
  int _counter = 0;
  // これもState
  String _displayText = "初期値";

  /// 非同期処理なので、戻り値はFeature型になる(将来的には戻ってくるイメージ？？)
  ///
  /// サーバーでのデータ取得を待つために、awaitで待機しておく
  Future<void> getGithubRepo() async {
    var url = Uri.https("api.github.com", "users/yassan16/repos");
    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // リスポンスをMapに変換する
    final List decodedResponse = json.decode(response.body);
    print(decodedResponse);
  }

  // UIの描画を行う
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            // 入力するとStateが更新されるので、表示内容も変更される
            // 文字が入力されるたびに呼ばれる
            TextField(
              onChanged: (value) {
                // valuenには入力された文字が入る
                print(value);
                // Stateを変更し、再描画させる
                setState(() {
                  _displayText = value;
                });
              },
            ),
            // TextFieldの中身を表示させるため
            Text(_displayText),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // ボタンを押すと以下のメソッドが呼ばれる
        onPressed: () {
          getGithubRepo();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
