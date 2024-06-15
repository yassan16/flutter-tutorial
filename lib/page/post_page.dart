import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  // PostPageState で使う State を作る宣言
  @override
  State<PostPage> createState() => _PostPageState();
}

/// AIとのトーク画面
///
/// 1.メイン画面の右下のボタンを押す <br>
/// 2.投稿用のテキスト入力画面が表示される <br>
/// 3.入力後に投稿ボタン(紙飛行機)を押す <br>
/// 4.テキスト入力画面から戻り、入力した内容が新たに表示されている
class _PostPageState extends State<PostPage> {
  String inputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => {Navigator.pop(context, inputText)},
              icon: const Icon(Icons.send)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            inputText = value;
          },
        ),
      ),
    );
  }
}
