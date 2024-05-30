import 'package:flutter/material.dart';

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

  // State が変わるとUIが再描画される
  void _incrementCounter() {
    // setStatメソッドの中でStateを更新した時のみ、再描画される
    setState(() {
      _counter++;
    });
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
          _incrementCounter();
          // こんなやり方でも可能
          setState(() {
            _counter++;
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
