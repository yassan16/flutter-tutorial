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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
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
