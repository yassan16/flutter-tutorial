import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tutorial/env/env.dart';
import 'package:flutter_tutorial/page/post_page.dart';
import 'package:http/http.dart' as http;

// StatefulWidgetを継承すると、Stateを扱えるようになる
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  // MyHomePageState で使う State を作る宣言
  @override
  State<ChatPage> createState() => _ChatPageState();
}

/// AIとのトーク画面
class _ChatPageState extends State<ChatPage> {
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

  /// Talk APIへの回答取得
  Future<void> getTalkApiResponse() async {
    var url = Uri.https("api.a3rt.recruit.co.jp", "talk/v1/smalltalk");
    var response =
        await http.post(url, body: {"apikey": Env.key, "query": "おはよう"});

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // リスポンスをMapに変換する
    // final List decodedResponse = json.decode(response.body);
    // print(decodedResponse);
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
            ElevatedButton(
              onPressed: () {
                getTalkApiResponse();
              },
              child: const Text('API呼び出しテスト'),
            ),
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
