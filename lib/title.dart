import 'package:flutter/material.dart';
//import 'bingo_choose_cs.dart';
import 'game.dart';

class BingoTitleScreen extends StatelessWidget {
  const BingoTitleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bingo Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 0.0), // 調整此處的間距
            const Text(
              'Bingo',
              style: TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 200.0), // 調整此處的間距
            SizedBox(
              // 調整按鈕大小的部分
              height: 60.0,
              width: 200.0,
              child: ElevatedButton(
                onPressed: () {
                  // 按下按鈕 導到遊戲主畫面
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BingoGridScreen()),
                  );
                },
                child:
                    const Text('Start Game', style: TextStyle(fontSize: 23.0)),
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Tap to start',
              style: TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
