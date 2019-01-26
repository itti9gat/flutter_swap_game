import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slide Puzzle',
      home: MyHomePage(title: 'Slide Puzzle'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const double RADIUS_CORNER_BIG = 10.0;
  static const double RADIUS_CORNER_SMALL = 7.0;

  int moveBox = 0;
  static int maxBox = 4;
  
  List<List<int>> checkValue = [
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12],
    [13, 14, 15, 0],
  ];
  
  List<List<int>> boxValue = [
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12],
    [13, 14, 15, 0],
  ];

  List<int> emptyBox = [maxBox - 1, maxBox - 1];

  void initState() {
    super.initState();

    swapBox();
  }

  void resetBox() {
    setState(() {
      boxValue = [
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 10, 11, 12],
          [13, 14, 15, 0],
        ];
      emptyBox = [maxBox - 1, maxBox - 1];
      moveBox = 0;
    });

    swapBox();
  }

  void swapBox() {
    var rng = new Random();
    var rngloop = new Random();
    var rndInt;
    var rndLoopInt;

    for (var i = 0; i <= 100; i++) {
      rndInt = rng.nextInt(4);
      rndLoopInt = rngloop.nextInt(3);

      setState(() {
        if (rndInt == 0) {
          for (var k = 0; k <= rndLoopInt; k++) {
            moveTop();
          }
        }

        if (rndInt == 1) {
          for (var k = 0; k <= rndLoopInt; k++) {
            moveRight();
          }
        }

        if (rndInt == 2) {
          for (var k = 0; k <= rndLoopInt; k++) {
            moveBottom();
          }
        }

        if (rndInt == 3) {
          for (var k = 0; k <= rndLoopInt; k++) {
            moveLeft();
          }
        }
      });
    }
  }

  void moveTop() {
    var emptyCol = emptyBox[0];
    var emptyRow = emptyBox[1];

    var valCol = emptyCol + 1;

    if (valCol < maxBox) {
      var valNum = boxValue[valCol][emptyRow];

      boxValue[emptyCol][emptyRow] = valNum;
      boxValue[valCol][emptyRow] = 0;
      emptyBox[0] = valCol;
    }
  }

  void moveLeft() {
    var emptyCol = emptyBox[0];
    var emptyRow = emptyBox[1];

    var valRow = emptyRow + 1;

    if (valRow < maxBox) {
      var valNum = boxValue[emptyCol][valRow];

      boxValue[emptyCol][emptyRow] = valNum;
      boxValue[emptyCol][valRow] = 0;
      emptyBox[1] = valRow;
    }
  }

  void moveRight() {
    var emptyCol = emptyBox[0];
    var emptyRow = emptyBox[1];

    var valRow = emptyRow - 1;

    if (valRow > -1) {
      var valNum = boxValue[emptyCol][valRow];

      boxValue[emptyCol][emptyRow] = valNum;
      boxValue[emptyCol][valRow] = 0;
      emptyBox[1] = valRow;
    }
  }

  void moveBottom() {
    var emptyCol = emptyBox[0];
    var emptyRow = emptyBox[1];

    var valCol = emptyCol - 1;

    if (valCol > -1) {
      var valNum = boxValue[valCol][emptyRow];

      boxValue[emptyCol][emptyRow] = valNum;
      boxValue[valCol][emptyRow] = 0;
      emptyBox[0] = valCol;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.blueGrey)),
        backgroundColor: Color.fromRGBO(210, 210, 210, 1.0),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.blueGrey,),
            onPressed: () {
              resetBox();
            },
          )
        ],
      ),
      body: Container(
          color: Color.fromRGBO(230, 230, 230, 1.0),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(250, 250, 250, 1.0),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(RADIUS_CORNER_BIG),
                    topRight: Radius.circular(RADIUS_CORNER_BIG),
                    bottomLeft: Radius.circular(RADIUS_CORNER_BIG),
                    bottomRight: Radius.circular(RADIUS_CORNER_BIG)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("MOVE",
                              style: TextStyle(
                                  color: Color.fromRGBO(130, 170, 175, 1.0),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          Text("$moveBox",
                              style: TextStyle(
                                  color: Color.fromRGBO(130, 170, 175, 1.0),
                                  fontSize: 60.0,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      getGridBox(0, 0),
                      getGridBox(0, 1),
                      getGridBox(0, 2),
                      getGridBox(0, 3),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      getGridBox(1, 0),
                      getGridBox(1, 1),
                      getGridBox(1, 2),
                      getGridBox(1, 3),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      getGridBox(2, 0),
                      getGridBox(2, 1),
                      getGridBox(2, 2),
                      getGridBox(2, 3),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      getGridBox(3, 0),
                      getGridBox(3, 1),
                      getGridBox(3, 2),
                      getGridBox(3, 3),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  InkWell getGridBox(int col, int row) {
    int val = boxValue[col][row];

    return InkWell(
      onTap: () {
        var emptyCol = emptyBox[0];
        var emptyRow = emptyBox[1];

        if (emptyBox[0] == col) {
          var diffRow = row - emptyRow;

          if (diffRow.abs() == 1) {
            setState(() {
              boxValue[col][row] = 0;
              boxValue[emptyCol][emptyRow] = val;

              emptyBox[0] = col;
              emptyBox[1] = row;

              moveBox++;
            });

            if (checkBoxComplete()) {
              showEndGameDialog();
            }
          }
        }

        if (emptyBox[1] == row) {
          var diffCol = col - emptyCol;

          if (diffCol.abs() == 1) {
            setState(() {
              boxValue[col][row] = 0;
              boxValue[emptyCol][emptyRow] = val;

              emptyBox[0] = col;
              emptyBox[1] = row;

              moveBox++;
            });
          }

          if (checkBoxComplete()) {
            showEndGameDialog();
          }
        }
      },
      child: Container(
        width: 70.0,
        height: 70.0,
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(248, 204, 122, 1.0),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(RADIUS_CORNER_SMALL),
              topRight: Radius.circular(RADIUS_CORNER_SMALL),
              bottomLeft: Radius.circular(RADIUS_CORNER_SMALL),
              bottomRight: Radius.circular(RADIUS_CORNER_SMALL)),
        ),
        child: Center(
          child: Text(val > 0 ? "$val" : "", style: TextStyle(fontSize: 30.0)),
        ),
      ),
    );
  }

  bool checkBoxComplete() {

    for (var i=0; i < maxBox; i++) {
        for (var j=0; j < maxBox; j++) {
          if (checkValue[i][j] != boxValue[i][j]) {
            return false;
          }
        }
    }
    return true;
  }

  void showEndGameDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("Congratulation",
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.black45,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 30.0,),
          Text("Move: $moveBox",
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.black45,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 30.0,),
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            color: Colors.yellow[800],
            child: Text("Play again",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.of(context).pop();
              resetBox();
            },
          )
        ]));
      },
    );
  }
}
