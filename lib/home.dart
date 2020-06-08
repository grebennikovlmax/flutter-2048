import 'logic.dart';
import 'tile.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
  
}

class _HomeScreenState extends State<HomeScreen> {
  double gameSize = 4;
  double offset = 10;
  double boardWidth;
  double tileSize;
  GameLogic logic; 
  
  @override
  void initState() {
    logic =  GameLogic(gameSize.toInt());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    boardWidth = screenWidth / 1.25;
    tileSize = (boardWidth - offset * (gameSize - 1)) / gameSize - offset / 2;
    return Scaffold(
      body: GestureDetector(
          onVerticalDragEnd: (DragEndDetails details) {
            isSwiped(details.primaryVelocity > 0 ? SwipeDirection.down : SwipeDirection.up);
          },
          onHorizontalDragEnd: (DragEndDetails details) {
            isSwiped(details.primaryVelocity > 0 ? SwipeDirection.right : SwipeDirection.left);
          },
          onTap: () => _isTaped(),
          child: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[ 
              Text("Score: " + logic.score.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: boardWidth,
                height: boardWidth,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(69, 69, 67, 1)
                ),
                child: Padding(
                  padding: EdgeInsets.all(offset),
                  child: Stack(children: _moveTile())
                )
              ),
              
            ]
          ) 
        )
      )
    );
  }

  _isTaped() {
    if(!logic.isOver) return;
    setState(() {
      logic.startGame();
    });
  }

  _moveTile() {
    List<Widget> widgets = [];
    if(logic.isOver) {
      return [
        Container(
          child: Center(
            child: Text("Game Over\n Tap to try again",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              )
            ),
          ),
        )
      ];
    }
    for(int i = 0; i < gameSize; i++) {
      for(int j = 0; j < gameSize; j++) {
        widgets.add(
          Positioned(
            top: i * tileSize + offset * i,
            left: j * tileSize  + offset * j,
            child: Tile(logic.grid[i][j],tileSize)
          )
        );
      }
    }
    return widgets;
  }

  void isSwiped(SwipeDirection direction) {
    setState(() {
      logic.moveTile(direction);
    });
  }
}