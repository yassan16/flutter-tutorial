# flutter_tutorial
flutterのチュートリアル学習用。  
参考動画: [Flutter研修【MIXI 23新卒技術研修】](https://www.youtube.com/watch?v=9IqUQ2TXacI)

## 学んだこと
### State
* StatefulWidgetを継承すると、Stateを扱えるようになる
* createState()メソッドで、State を使用する宣言を行う
* State が変わると画面が再描画される
* 再描画するためには、setState()メソッドの中で行う必要がある

```dart
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
      ・
      ・(その他処理)
      ・
      floatingActionButton: FloatingActionButton(
        // ボタンを押すと以下のメソッドが呼ばれる
        onPressed: () {
          _incrementCounter();
          // こんなやり方でも可能
          setState(() {
            _counter++;
          });
        },
      ),
    );
  }
}
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
