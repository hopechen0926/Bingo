// import 'package:flutter/material.dart';
// import 'player_list_screen.dart';

// class BingoNameScreen extends StatefulWidget {
//   const BingoNameScreen({Key? key}) : super(key: key);

//   @override
//   _BingoNameScreenState createState() => _BingoNameScreenState();
// }

// class _BingoNameScreenState extends State<BingoNameScreen> {
//   String playerName = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Enter Your Name'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextField(
//                 style: const TextStyle(fontSize: 20), // 將輸入框文字大小增加一點
//                 decoration: const InputDecoration(
//                   labelText: 'Enter Your Name', // 輸入框標籤文字
//                   border: OutlineInputBorder(), // 輸入框邊框
//                 ),
//                 onChanged: (value) {
//                   // 更新玩家名稱
//                   setState(() {
//                     playerName = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 20.0), // 調整間距
//               ElevatedButton(
//                 onPressed: () {
//                   // 確認按鈕操作，導航到玩家清單頁面，將玩家名稱傳遞過去
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => PlayerListScreen(players: [playerName])),
//                   );
//                 },
//                 child: const Text(
//                   'Confirm', // 確認鍵文字
//                   style: TextStyle(fontSize: 20), // 將文字放大一點
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
