import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool win = false;
  bool checkWin(List<int> board) {
    // Define the winning combinations
    List<List<int>> winningCombinations = [
      [0, 1, 2], // Row 1
      [3, 4, 5], // Row 2
      [6, 7, 8], // Row 3
      [0, 3, 6], // Column 1
      [1, 4, 7], // Column 2
      [2, 5, 8], // Column 3
      [0, 4, 8], // Diagonal 1
      [2, 4, 6] // Diagonal 2
    ];

    // Check each winning combination
    for (List<int> combination in winningCombinations) {
      int a = combination[0];
      int b = combination[1];
      int c = combination[2];

      if (board[a] != 0 && board[a] == board[b] && board[a] == board[c]) {
        return true; // Win found
      }
    }

    return false; // No win found
  }

  List<int> items = [for (int i = 0; i < 9; i++) 0];
  int turn = 1;
  bool full = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Player $turn"),
          Center(
              child: SizedBox(
                  width: 300,
                  height: 400,
                  child: GridView.builder(
                    itemCount: items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          3, // Adjust the number of columns as needed
                    ),
                    itemBuilder: (context, index) {
                      if (win) {
                        return const Center(
                          child: Text("win win win "),
                        );
                      }
                      if (full == true) {
                        return const Center(
                          child: Text("GAME OVER"),
                        );
                      }
                      final item = items[index];
                      String content = "";
                      switch (item) {
                        case 0:
                          content = "";
                          break;
                        case 1:
                          content = "X";
                          break;
                        case 2:
                          content = "O";
                          break;
                        default:
                          content = "";
                      }
                      return GestureDetector(
                        onTap: () {
                          if (item == 0) {
                            setState(() {
                              if (turn == 1) {
                                turn = 2;
                              } else {
                                turn = 1;
                              }
                              items[index] = turn;
                              if (checkWin(items)) {
                                setState(() {
                                  win = true;
                                });
                              }
                              bool it = false;
                              for (var i in items) {
                                if (i == 0) {
                                  it = true;
                                }
                              }
                              if (it == false) {
                                setState(() {
                                  full = true;
                                });
                              }
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(content),
                          ),
                        ),
                      );
                    },
                  ))),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Text("replay"))
        ],
      ),
    );
  }
}
