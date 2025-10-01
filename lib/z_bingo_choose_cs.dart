// import 'package:flutter/material.dart';
// import 'bingo_grid_screen.dart';
// import 'bingo_name_screen.dart';

// class ServerClientSelectionScreen extends StatelessWidget {
//   const ServerClientSelectionScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Server or Client?'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to BingoGridScreen when server button is pressed
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => BingoGridScreen()),
//                 );
//               },
//               child: const Text(
//                 'Server',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to BingoNameScreen when client button is pressed
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => BingoGridScreen()),
//                 );
//               },
//               child: const Text(
//                 'Client',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }