import 'package:flutter/material.dart';
import 'package:flutter_tutorial/page/sample/first_page.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("2枚目のページ"),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const FirstPage(),
                  ),
                );
              },
              child: const Text("戻るボタン"),
            ),
          ],
        ),
      ),
    );
  }
}
