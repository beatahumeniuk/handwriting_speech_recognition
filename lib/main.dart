import 'package:flutter/material.dart';
import 'package:handwritingspeechrecognition/handwriting.dart';
import 'package:handwritingspeechrecognition/speech.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Rozpoznawanie pisma odręcznego i mowy',
        home: MyHomePage(title: 'Wybierz opcję'),
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Color.fromARGB(255, 50, 50, 50),
          accentColor: Color.fromARGB(255, 50, 50, 50),
        )
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 100, 100, 100),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 50, 50, 50),
          title: Text(
            widget.title,
            style: TextStyle(
              color: Color.fromARGB(255, 220, 220, 220),
            ),
          ),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 0, 30, 10),
                    child:  Container(
                      height: 100.0,
                      width: 100.0,
                      child: FittedBox(
                        child: new FloatingActionButton(
                          heroTag: "goToSpeechPage",
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SpeechPage()));
                          },
                          child: Icon(Icons.mic),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 50),
                    child: Container(
                        child: Text(
                          "Rozpoznawanie mowy",
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
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 50, 30, 10),
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      child: FittedBox(
                        child: new FloatingActionButton(
                          heroTag: "goToHandwritingPage",
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HandwritingPage()));
                          },
                          child: Icon(Icons.edit),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 50),
                    child: Container(
                        child: Text(
                          "Rozpoznawanie pisma",
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
                        )),
                  ),
                ])));
  }
}
