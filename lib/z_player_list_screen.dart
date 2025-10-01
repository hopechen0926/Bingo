// // player_list_screen.dart

// import 'package:flutter/material.dart';
// import 'bingo_grid_screen.dart';

// class PlayerListScreen extends StatefulWidget {
//   final List<String> players;

//   const PlayerListScreen({Key? key, required this.players}) : super(key: key);

//   @override
//   _PlayerListScreenState createState() => _PlayerListScreenState();
// }

// class _PlayerListScreenState extends State<PlayerListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Players List'),
//       ),
//       body: ListView.builder(
//         itemCount: widget.players.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(widget.players[index]),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => BingoGridScreen()),
//           );
//         },
//         child: Icon(Icons.play_arrow),
//       ),
//     );
//   }
// }
