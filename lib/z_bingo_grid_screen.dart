// import 'package:flutter/material.dart';

// class BingoGridScreen extends StatefulWidget {
//   @override
//   _BingoGridScreenState createState() => _BingoGridScreenState();
// }

// class _BingoGridScreenState extends State<BingoGridScreen> {
//   List<bool> isSelected = List.generate(25, (index) => false);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Bingo Grid'),
//       ),
//       body: Center(
//         child: GridView.builder(
//           shrinkWrap: true,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 5,
//           ),
//           itemCount: 25,
//           itemBuilder: (BuildContext context, int index) {
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   isSelected[index] = !isSelected[index];
//                 });
//               },
//               child: Container(
//                 margin: const EdgeInsets.all(2),
//                 color: isSelected[index]
//                     ? Color.fromARGB(255, 212, 155, 222)
//                     : Colors.grey[300],
//                 child: Center(
//                   child: Text(
//                     '${index + 1}',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
