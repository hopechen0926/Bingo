import 'dart:convert';
import 'dart:io';
import 'dart:math';

Set<int> numbers = {}; // 全局變量用於存儲隨機數字

int getRandomNumber() {
  Random random = Random();

  if (numbers.isEmpty) {
    // 如果集合為空，則生成新的隨機數字集合
    numbers = Set<int>.from(List<int>.generate(25, (index) => index + 1));
  }

  int index = random.nextInt(numbers.length); // 在集合中隨機選擇一個索引
  int randomNumber = numbers.elementAt(index); // 獲取該索引對應的數字
  numbers.remove(randomNumber); // 從集合中移除已經使用過的數字
  return randomNumber;
}

void main() async {
  final server = await ServerSocket.bind('192.168.137.57', 8000);  //  記得設定自己現在網路的 IP Address
  print('server started at ${server.address}:${server.port}.');

  int clientnum = 0;
  int Readyclient = 0;
  bool gameEnded = false;
  //bool winner = false;
  final Map<int, Socket> clients = {};

  server.listen((Socket client) {
    clientnum++;
    Readyclient++;
    final clientIdString = 'Client_$clientnum';
    print('Client connected: $clientIdString');

    clients[clientnum] = client;

    client.listen((List<int> data) async {
      final message = utf8.decode(data).trim();
      print('Message from $clientIdString: $message');
      if (message == 'Ready') {
        Readyclient--;
        if (Readyclient == 0) {
          for (var id in clients.keys) {
            clients[id]?.write('Play');
          }
          await Future.delayed(Duration(seconds: 1)); //預防'Play'和隨機數字同時送出
          while (!gameEnded) {
            // 只有在遊戲還沒結束時才發送隨機數字
            int randomNumber = getRandomNumber();
            for (var id in clients.keys) {
              clients[id]?.write(randomNumber.toString());
            }
            await Future.delayed(Duration(seconds: 2));
          }
        }
      } else if (message == 'Win') {
        print('Player $clientIdString wins!');
        gameEnded = true; // 當有玩家勝利時設置遊戲結束
        //winner = true;
        for (var id in clients.keys) {
          clients[id]?.write('You win!');
        }
      }
    }, onError: (error) {
      print('Error from $clientIdString: $error');
      client.close();
      clients.remove(clientnum);
    }, onDone: () {
      print('Client disconnected: $clientIdString');
      clients.remove(clientnum);
      clientnum--;
    });
  });
}
