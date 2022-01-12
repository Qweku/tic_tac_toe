// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> playerPiece = ["", "", "", "", "", "", "", "", ""];
  bool firstPlayer = true;
  int p1 = 0;
  int p2 = 0;
  int taps = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
             
              Container(
                padding: EdgeInsets.symmetric(vertical: height*0.1),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('PLAYER 1',
                              style:
                                  TextStyle(color: Colors.blue,fontFamily:'ArcadeClassic', fontSize: 17)),
                          Text('$p1',
                              style:
                                  TextStyle(color: Colors.blue,fontFamily:'ArcadeClassic', fontSize: 20))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('PLAYER 2',
                              style:
                                  TextStyle(color: Colors.green,fontFamily:'ArcadeClassic', fontSize: 17)),
                          Text('$p2',
                              style:
                                  TextStyle(color: Colors.green,fontFamily:'ArcadeClassic', fontSize: 20))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.builder(
                        itemCount: 9,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              displayPiece(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: firstPlayer
                                          ? Colors.blue
                                          : Colors.green)),
                              child: Center(
                                child: Text(playerPiece[index],
                                    style: TextStyle(
                                        fontSize: 40, color: Colors.white)),
                              ),
                            ),
                          );
                        }),
                  )),
                   Container(
                  //padding: EdgeInsets.only(bottom: height*0.1),
                  child: Text('TIC  TAC  TOE',
                      style: TextStyle(fontFamily:'ArcadeClassic',fontSize: 25, color: Colors.white))),
              Container(                
                padding: EdgeInsets.only(left: width*0.45, right: width*0.45,bottom:height*0.1 ),
                child: Divider(thickness: 3, color: Colors.white),
              ),
              
            ],
          )),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    return (await showDialog<bool>(
            context: context,
            builder: (c) => AlertDialog(
                  backgroundColor: Colors.grey[900],
                  title: Center(
                      child: Text(
                    "Warning",style: TextStyle(fontFamily:'ArcadeClassic', color: Colors.red)
                  )),
                  content: Text(
                    "Do you really want to quit?",
                    textAlign: TextAlign.center,style: TextStyle(color: Colors.white)
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          exit(0);
                        },
                        child: Text(
                          "Yes",style: TextStyle(color: Colors.red)
                        )),
                    TextButton(
                        onPressed: () => Navigator.pop(c, false),
                        child: Text(
                          "No",style: TextStyle(color: Colors.red)
                        ))
                  ],
                ))) ??
        false;
  }

  void displayPiece(int index) {
    setState(() {
      if (firstPlayer && playerPiece[index] == "") {
        playerPiece[index] = "o";
        taps += 1;
      } else if (!firstPlayer && playerPiece[index] == "") {
        playerPiece[index] = "x";
        taps += 1;
      }
      //checkDraw();
      checkWinner();
      firstPlayer = !firstPlayer;
    });
  }

  void checkWinner() {
    // 1st row
    if (playerPiece[0] == playerPiece[1] &&
        playerPiece[0] == playerPiece[2] &&
        playerPiece[0] != "") {
      _showWinScreen();
    }

    // 2nd row
    if (playerPiece[3] == playerPiece[4] &&
        playerPiece[3] == playerPiece[5] &&
        playerPiece[3] != "") {
      _showWinScreen();
    }

    // 3rd row
    if (playerPiece[6] == playerPiece[7] &&
        playerPiece[6] == playerPiece[8] &&
        playerPiece[6] != "") {
      _showWinScreen();
    }

    // 1st column
    if (playerPiece[0] == playerPiece[3] &&
        playerPiece[0] == playerPiece[6] &&
        playerPiece[0] != "") {
      _showWinScreen();
    }

    // 2nd column
    if (playerPiece[1] == playerPiece[4] &&
        playerPiece[1] == playerPiece[7] &&
        playerPiece[1] != "") {
      _showWinScreen();
    }

    // 3rd column
    if (playerPiece[2] == playerPiece[5] &&
        playerPiece[2] == playerPiece[8] &&
        playerPiece[2] != "") {
      _showWinScreen();
    }

    // 1st diagonal
    if (playerPiece[0] == playerPiece[4] &&
        playerPiece[0] == playerPiece[8] &&
        playerPiece[0] != "") {
      _showWinScreen();
    }

    // 2nd diagonal
    if (playerPiece[2] == playerPiece[4] &&
        playerPiece[2] == playerPiece[6] &&
        playerPiece[2] != "") {
      _showWinScreen();
    }else if (taps == 9) {
      _showDrawScreen();
    }
  }

  // void checkDraw() {
  //   if (taps == 9) {
  //     _showDrawScreen();
  //   }
  // }

  void _showWinScreen() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Center(
                  child: !firstPlayer
                      ? Text(
                          'PLAYER 1  WINS', style: TextStyle(fontFamily:'ArcadeClassic', color: Colors.blue)
                        )
                      : Text(
                          'PLAYER 2  WINS',style: TextStyle(fontFamily:'ArcadeClassic', color: Colors.green)
                        )),
              actions: [
                TextButton(
                    onPressed: () {
                      if (!firstPlayer) {
                        p1 += 1;
                      } else {
                        p2 += 1;
                      }
                      taps = 0;
                      resetPieces();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Play Again',style: TextStyle(color: Colors.red)
                    ))
              ]);
        });
  }

  void _showDrawScreen() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Center(
                  child: Text(
                'DRAW GAME',style: TextStyle(fontFamily:'ArcadeClassic', color: Colors.red)
              )),
              actions: [
                TextButton(
                    onPressed: () {
                      taps = 0;
                      resetPieces();
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Play Again',style: TextStyle(color: Colors.red)
                    ))
              ]);
        });
  }

  void resetPieces() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        playerPiece[i] = "";
      }
    });
  }
}
