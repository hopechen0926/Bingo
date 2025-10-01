# Multiplayer Network Bingo Game

A cross-platform multiplayer Bingo game implemented using Flutter (for client UI) and Dart sockets (for backend server). Designed for network communication practice and interactive gameplay.

> 🎓 Project by: Hope Chen, National Taipei University  
> 🎥 [Demo Video](https://youtu.be/N4erDuoSdgI)

## 🧩 Overview

This Bingo game allows multiple clients to connect to a central server. The game proceeds as follows:

1. Each client builds their own 5x5 Bingo board.
2. When all players are ready, the server starts broadcasting random numbers.
3. Clients mark matching numbers on their board.
4. The first player to complete a row/column/diagonal wins.

---

## 🖧 Server - `server.dart`

- Manages connections from multiple clients via `ServerSocket`.
- Sends random numbers (1-25) to all clients.
- Detects when a player wins and notifies all others to end the game.

### Key Functions:
- `getRandomNumber()` ensures no repeated numbers.
- Clients send `Ready` or `Win` messages.
- Server sends `Play`, random numbers, or `You win!`.

---

## 📱 Client - Flutter App

### Files:
- `main.dart`: App entry point.
- `title.dart`: Initial title screen.
- `game.dart`: Main UI and socket communication.

### Highlights:

#### 🎮 UI (game.dart)
- 5x5 grid created using `GridView`.
- Players tap to fill the board with numbers.
- Upon clicking "Ready", the server sends numbers.
- Grid highlights matching numbers.

#### 💡 Logic:
- Tracks game state: playing, gameEnded, winner.
- Socket listens for messages: `Play`, number, `Win`, `Game Over`.
- Validates win via `checkVictory()` (rows, columns, diagonals).

---

## ⚙️ How to Run

### Server
```bash
dart server.dart
```
Ensure your IP address is correctly set in `Socket.bind`.

### Client (Flutter)
```bash
flutter run
```
Or launch from VS Code / Android Studio using device simulator.

---

## 📷 Screenshots

![gameplay](https://prod-files-secure.s3.us-west-2.amazonaws.com/1cf77047-099a-4219-b50a-20808e7c42b2/4a8c4ef6-a6cd-4660-a14d-9fe33dd4bb2a/Simulator_Screenshot_-_iPhone_15_Pro_-_2024-06-12_at_00.02.20.png)

![board](https://prod-files-secure.s3.us-west-2.amazonaws.com/1cf77047-099a-4219-b50a-20808e7c42b2/864a5d6f-b451-449a-8aa4-633890af97fd/Simulator_Screenshot_-_iPhone_15_Pro_-_2024-06-12_at_21.46.32.png)

---

## 📌 Features

- Server-client socket communication.
- Real-time gameplay with multiple players.
- Number broadcasting and message handling.
- Victory check logic and in-game UI feedback.
