import 'package:flutter/material.dart';

class Tile extends StatelessWidget {

  final int title;
  final double width;

  Tile(this.title, this.width);

  int _getColor() {
    switch (title) {
      case 2:
        return 0xffeee4da;
      case 4:
        return 0xffede0c8;
      case 8:
        return 0xfff2b179;
      case 16:
        return 0xfff59563;
      case 32:
        return 0xfff67c5f;
      case 64:
        return 0xfff65e3b;
      case 128:
        return 0xffedcf72;
      case 256:
        return 0xffedcc61;
      case 512:
        return 0xffedc850;
      case 1024:
        return 0xffedc53f;
      case 2048:
        return 0xffedc22e;
    }
    return 0xffcdfb4;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center ( 
        child: Text(title == 0 ? "" : "$title",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          )
        )
      ),
      width: this.width,
      height: this.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(_getColor())
      ),
    );
  } 
}