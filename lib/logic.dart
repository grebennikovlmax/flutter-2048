import 'dart:math';

enum SwipeDirection {left, right, up, down}

class Position {
  int row,column;
  Position(this.row, this.column);
}

class GameLogic {
  
  int gameSize;
  int score = 0;
  final initValues = [2,4];
  List<List<int>> grid = [];
  bool isMoved = true;
  bool isOver = false;

  var direction;

  GameLogic(int gameSize) {
    this.gameSize = gameSize;
    startGame();
  }

  void startGame() {
    grid = List.generate(gameSize, (_) => List.filled(gameSize, 0));
    score = 0;
    isMoved = true;
    isOver = false;
    createTile();
  }

  void createTile() {
    if(isOver) return;
    var freeCoord = _checkCoordinates();
    if(freeCoord.isNotEmpty) {
      if(!isMoved) return;
      isMoved = false;
      var random = Random().nextInt(freeCoord.length);
      var position = freeCoord[random];
      grid[position.row][position.column] = initValues[Random().nextInt(initValues.length)];
    } else {
      isOver = true;
    }
  }

  List<Position> _checkCoordinates() {
    List<Position> res = [];
    for(int i = 0; i < gameSize; i++) {
      for(int j = 0; j < gameSize; j++) {
        if(grid[i][j] == 0) {
          res.add(Position(i,j));
        }
      } 
    }
    return res;
  }

  void moveTile(SwipeDirection direction) {
    switch(direction){
      case SwipeDirection.up:
        for(int i = 1; i < gameSize; i++) {
          for(int j = 0; j < gameSize; j++) {
            if(grid[i][j] == 0) continue;
            var newInd = i;
            while(newInd > 0) {
              if(grid[newInd - 1][j] == 0) {
                newInd--;
                continue;
              }
              if(grid[i][j] == grid[newInd-1][j]) {
                grid[i][j] *= 2;
                score += grid[i][j];
                grid[newInd - 1][j] = 0;
                newInd--;
              }
              break;
            }
            if(newInd == i) continue;
            grid[newInd][j] = grid[i][j];
            grid[i][j] = 0;
            isMoved = true;
          }
        }
        break;
      case SwipeDirection.down:
        for(int i = gameSize - 2; i >= 0; i--) {
          for(int j = 0; j < gameSize; j++) {
            if(grid[i][j] == 0) continue;
            var newInd = i;
            while(newInd < gameSize - 1) {
              if(grid[newInd + 1][j] == 0) {
                newInd++;
                continue;
              }
              if(grid[i][j] == grid[newInd+1][j]) {
                grid[i][j] *= 2;
                score += grid[i][j];
                grid[newInd + 1][j] = 0;
                newInd++;
              }
              break;
            }
            if(newInd == i) continue;
            grid[newInd][j] = grid[i][j];
            grid[i][j] = 0;
            isMoved = true;
          }
        }
        break;
      case SwipeDirection.left:
        for(int i = 1; i < gameSize; i++) {
          for(int j = 0; j < gameSize; j++) {
            if(grid[j][i] == 0) continue;
            var newInd = i;
            while(newInd > 0) {
              if(grid[j][newInd - 1] == 0) {
                newInd--;
                continue;
              }
              if(grid[j][i] == grid[j][newInd - 1]) {
                grid[j][i] *= 2;
                score += grid[j][i];
                grid[j][newInd - 1] = 0;
                newInd--;
              }
              break;
            }
            if(newInd == i) continue;
            grid[j][newInd] = grid[j][i];
            grid[j][i] = 0;
            isMoved = true;
          }
        }
        break;
      case SwipeDirection.right:
        for(int i = gameSize - 2; i >= 0; i--) {
          for(int j = 0; j < gameSize; j++) {
            if(grid[j][i] == 0) continue;
            var newInd = i;
            while(newInd < gameSize - 1) {
              if(grid[j][newInd + 1] == 0) {
                newInd++;
                continue;
              }
              if(grid[j][i] == grid[j][newInd + 1]) {
                grid[j][i] *= 2;
                score += grid[j][i];
                grid[j][newInd + 1] = 0;
                newInd++;
              }
              break;
            }
            if(newInd == i) continue;
            grid[j][newInd] = grid[j][i];
            grid[j][i] = 0;
            isMoved = true;
          }
        }
        break;
    }
    createTile();
  }



}