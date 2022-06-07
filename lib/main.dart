import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text("TicTacToe"),
            actions: [],
          ),
          body: HomeScreen(),
        ));
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _homeScreenState();
  }
}

class _homeScreenState extends State<HomeScreen> {
  bool player_o_turn = true;
  List<String> boxstate = ['', '', '', '', '', '', '', '', ''];
  int player_o_score = 0;
  int player_x_score = 0;
  int box_filled = 0;

  Widget buttons(String buttonVal, int index) {
    return Expanded(
      child: ElevatedButton(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 48.5, horizontal: 0.0),
          child: Text(
            buttonVal,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onPressed: () {
          setState(() {
            if (player_o_turn && boxstate[index] == '') {
              boxstate[index] = 'O';
              box_filled++;
            } else if (!player_o_turn && boxstate[index] == '') {
              boxstate[index] = 'X';
              box_filled++;
            }
            player_o_turn = !player_o_turn;
            _checkWinner();
          });
        },
      ),
    );
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Player " + winner + " Win!!!"),
            actions: [
              TextButton(
                child: Text("Continue"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'O') {
      player_o_score++;
    } else if (winner == 'X') {
      player_x_score++;
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw"),
            actions: [
              TextButton(
                child: Text("Continue"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        boxstate[i] = '';
      }
    });

    box_filled = 0;
  }

  void _clearScoreBoard() {
    setState(() {
      player_x_score = 0;
      player_o_score = 0;
      for (int i = 0; i < 9; i++) {
        boxstate[i] = '';
      }
    });
    box_filled = 0;
  }

  void _checkWinner() {
    // Cek Baris
    if (boxstate[0] == boxstate[1] &&
        boxstate[0] == boxstate[2] &&
        boxstate[0] != '') {
      _showWinDialog(boxstate[0]);
    }
    if (boxstate[3] == boxstate[4] &&
        boxstate[3] == boxstate[5] &&
        boxstate[3] != '') {
      _showWinDialog(boxstate[3]);
    }
    if (boxstate[6] == boxstate[7] &&
        boxstate[6] == boxstate[8] &&
        boxstate[6] != '') {
      _showWinDialog(boxstate[6]);
    }

    // Cek Kolom
    if (boxstate[0] == boxstate[3] &&
        boxstate[0] == boxstate[6] &&
        boxstate[0] != '') {
      _showWinDialog(boxstate[0]);
    }
    if (boxstate[1] == boxstate[4] &&
        boxstate[1] == boxstate[7] &&
        boxstate[1] != '') {
      _showWinDialog(boxstate[1]);
    }
    if (boxstate[2] == boxstate[5] &&
        boxstate[2] == boxstate[8] &&
        boxstate[2] != '') {
      _showWinDialog(boxstate[2]);
    }

    // Cek Diagonal
    if (boxstate[0] == boxstate[4] &&
        boxstate[0] == boxstate[8] &&
        boxstate[0] != '') {
      _showWinDialog(boxstate[0]);
    }
    if (boxstate[2] == boxstate[4] &&
        boxstate[2] == boxstate[6] &&
        boxstate[2] != '') {
      _showWinDialog(boxstate[2]);
    } else if (box_filled == 9) {
      _showDrawDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          // creating the ScoreBoard
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Player X",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        player_x_score.toString(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Player O",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(
                        player_o_score.toString(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        //TicTacToe Board
        Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.
                children: [
                  buttons(boxstate[0], 0),
                  buttons(boxstate[1], 1),
                  buttons(boxstate[2], 2),
                ],
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buttons(boxstate[3], 3),
                  buttons(boxstate[4], 4),
                  buttons(boxstate[5], 5),
                ],
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buttons(boxstate[6], 6),
                  buttons(boxstate[7], 7),
                  buttons(boxstate[8], 8),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        //Reset Score Button
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _clearScoreBoard();
                },
                style: ElevatedButton.styleFrom(primary: Colors.white),
                child: Text(
                  "Reset Score Board",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
