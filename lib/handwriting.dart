import 'package:flutter/material.dart';
import 'package:handwritingspeechrecognition/constants.dart';
import 'package:handwritingspeechrecognition/drawing_painter.dart';
import 'package:handwritingspeechrecognition/brain.dart';

class HandwritingPage extends StatefulWidget {
  HandwritingPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HandwritingPageState createState() => HandwritingPageState();
}

class HandwritingPageState extends State<HandwritingPage> {
  List<Offset> points = List();
  AppBrain brain = AppBrain();
  String number = "";
  double effectiveness = 0.0;

  void _cleanDrawing() {
    setState(() {
      points = List();
    });
  }

  @override
  void initState() {
    super.initState();
    brain.loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 100, 100, 100),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 50, 50, 50),
        title: Text("Rozpoznawanie pisma"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Text(
                  "Wpisz cyfrę",
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Color.fromARGB(255, 220, 220, 220),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            blurRadius: 2.0,
                            color: Color.fromARGB(255, 25, 25, 25),
                            offset: Offset(1.0, 1.0))
                      ]),
                ),
              ),
            ),
            Container(
              decoration: new BoxDecoration(
                color: Color.fromARGB(255, 220, 220, 220),
                border: new Border.all(
                  width: 3.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        RenderBox renderBox = context.findRenderObject();
                        points.add(
                            renderBox.globalToLocal(details.globalPosition));
                      });
                    },
                    onPanStart: (details) {
                      setState(() {
                        RenderBox renderBox = context.findRenderObject();
                        points.add(
                            renderBox.globalToLocal(details.globalPosition));
                      });
                    },
                    onPanEnd: (details) async {
                      points.add(null);
                      List predictions =
                          await brain.processCanvasPoints(points);
                      number = predictions.first['label'];
                      effectiveness = predictions.first['confidence'];
                      setState(() {});
                    },
                    child: ClipRect(
                      child: CustomPaint(
                        size: Size(kCanvasSize, kCanvasSize),
                        painter: DrawingPainter(
                          offsetPoints: points,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Text(
                  "Wpisana cyfra to: " + number,
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Color.fromARGB(255, 220, 220, 220),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            blurRadius: 2.0,
                            color: Color.fromARGB(255, 25, 25, 25),
                            offset: Offset(1.0, 1.0))
                      ]),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Text(
                  "Skuteczność algorytmu: " + (effectiveness * 100).round().toString() + "%",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromARGB(255, 220, 220, 220),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            blurRadius: 2.0,
                            color: Color.fromARGB(255, 25, 25, 25),
                            offset: Offset(1.0, 1.0))
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _cleanDrawing();
          number = "";
          effectiveness = 0.0;
        },
        tooltip: 'Wyczyść',
        child: Icon(Icons.clear),
      ),
    );
  }
}
