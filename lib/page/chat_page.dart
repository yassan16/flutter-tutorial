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
  String postText = "";
  String apiResponseText = "";

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

    // デフォルトの×ボタン(戻るボタン)では、nullが返される
    if (v != null) {
      setState(() {
        postText = v;
      });
    }
  }

  /// Talk APIへの回答取得
  Future<void> getTalkApiResponse(String requestParm) async {
    var url = Uri.https("api.a3rt.recruit.co.jp", "talk/v1/smalltalk");
    var response =
        await http.post(url, body: {"apikey": Env.key, "query": requestParm});

    var responseJson = jsonDecode(response.body);
    print("取得結果: ${responseJson["results"]}");

    String resultApiText = getResponseBodyResult(responseJson);

    setState(() {
      apiResponseText = resultApiText;
    });
  }

  String getResponseBodyResult(dynamic jsonResponse) {
    // print(jsonResponse);
    // print(jsonResponse.runtimeType);
    // print(jsonResponse["results"][0]["reply"]);
    return jsonResponse["results"][0]["reply"];
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
            Text(postText),
            ElevatedButton(
              onPressed: () {
                getTalkApiResponse(postText);
              },
              child: const Text('API呼び出しテスト'),
            ),
            Text(apiResponseText),
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
