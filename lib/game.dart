import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class BingoGridScreen extends StatefulWidget {
  @override
  _BingoGridScreenState createState() => _BingoGridScreenState();
}

class _BingoGridScreenState extends State<BingoGridScreen> {
  String selectedNumber = '';
  List<int> selectedNums = List.generate(26, (index) => 0);

  List<int> gridValues = List.generate(25, (index) => 0);
  List<Color> gridColors =
      List.generate(25, (index) => Color.fromARGB(0, 140, 0, 255));

  late Socket _socket;
  late String fromserver;
  bool isReady = false;
  bool playing = false;
  late String bingonum = '';
  bool gameEnded = false; // 新增遊戲結束的狀態
  bool winner = false;

  @override
  void initState() {
    super.initState();
    _connectToServer();
  }

  void _connectToServer() async {
    try {
      _socket = await Socket.connect('192.168.137.57', 8000);   //  記得設定自己現在網路的 IP Address!!!

      _socket.listen(
        (List<int> event) {
          String message = utf8.decode(event);
          _handleMessage(message);
        },
        onError: (error) {
          print('Error: $error');
        },
        onDone: () {
          print('Disconnected from server');
        },
      );
    } catch (e) {
      print('Error connecting to server: $e');
    }
  }

  void _handleMessage(String message) {
    print("Receive from server: $message");
    if (message == 'Play') {
      playing = true;
    } else if (message == 'Game Over') {
      setState(() {
        gameEnded = true;
      });
    } else if (message == 'Win') {
      setState(() {
        gameEnded = true;//
        winner = true; // 勝利後也設置遊戲結束
      });
    } else {
      setState(() {
        bingonum = message;
        int number = int.tryParse(message) ?? -1;
        if (number >= 1 && number <= 25) {
          selectedNums[number] = 1;
          gridValues.asMap().forEach((index, value) {
            if (value == number) {
              gridColors[index] =
                  Color.fromARGB(255, 235, 168, 190); // 設定顏色為粉紅色
            }
          });
          if (!gameEnded) {
            // 確保遊戲還沒結束時才檢查勝利條件
            if (checkVictory()) {
              // 如果達成了勝利條件，向服務器發送 "Win" 訊息
              _sendMessageToServer('Win');
              gameEnded = true;
              return; // 在發送 "Win" 訊息後直接返回，不再向服務器發送 "Ready"
            } else {
              // 只有在遊戲還沒結束且未達成勝利條件時才向服務器發送 "Ready" 訊息
              _sendMessageToServer('Ready');
            }
          }
        }
      });
    }
  }

  bool checkVictory() {
    // 檢查水平線
    for (int i = 0; i < 5; i++) {
      if (selectedNums[i * 5 + 1] == 1 &&
          selectedNums[i * 5 + 2] == 1 &&
          selectedNums[i * 5 + 3] == 1 &&
          selectedNums[i * 5 + 4] == 1 &&
          selectedNums[i * 5 + 5] == 1) {
        return true;
      }
    }
    // 檢查垂直線
    for (int i = 1; i < 6; i++) {
      if (selectedNums[i] == 1 &&
          selectedNums[i + 5] == 1 &&
          selectedNums[i + 10] == 1 &&
          selectedNums[i + 15] == 1 &&
          selectedNums[i + 20] == 1) {
        return true;
      }
    }
    // 檢查左上到右下對角線
    if (selectedNums[1] == 1 &&
        selectedNums[7] == 1 &&
        selectedNums[13] == 1 &&
        selectedNums[19] == 1 &&
        selectedNums[25] == 1) {
      return true;
    }
    // 檢查右上到左下對角線
    if (selectedNums[5] == 1 &&
        selectedNums[9] == 1 &&
        selectedNums[13] == 1 &&
        selectedNums[17] == 1 &&
        selectedNums[21] == 1) {
      return true;
    }
    return false;
  }

  void _sendMessageToServer(String message) {
    _socket.write(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bingo Grid'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemCount: gridValues.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (!playing) {
                        if (gridValues[index] == 0) {
                          int nextValue =
                              gridValues.where((value) => value != 0).length +
                                  1;
                          gridValues[index] = nextValue;
                          if (nextValue == 25) isReady = true;
                        }
                      } else {
                        // 在遊戲進行中，點擊格子不會有反應
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: gridColors[index], // 使用新的顏色
                      borderRadius: BorderRadius.zero,
                      border: Border.all(
                        // 添加邊框
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${gridValues[index] != 0 ? gridValues[index] : ''}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Visibility(
            visible: isReady,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _sendMessageToServer('Ready');
                    print('Ready');
                    isReady = false;
                  });
                },
                child: Text(
                  'Ready',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Visibility(
            visible: playing,
            child: Positioned(
              child: Text(
                bingonum, // 使用传入的文本内容
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Noto Sans',
                  fontSize: 50,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ),
          ),
          Visibility(
            visible: winner, // 贏家贏得遊戲
            child: Text(
              'You win!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Visibility(
            visible: gameEnded && !winner, // 顯示遊戲結束消息
            child: Text(
              'Game Over',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
