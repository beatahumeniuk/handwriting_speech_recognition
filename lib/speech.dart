import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

class SpeechPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SpeechPageState();
  }
}

class SpeechPageState extends State<SpeechPage> {
  final Map<String, HighlightedWord> _highlights = {
  };

  stt.SpeechToText _speech;
  bool isListening = false;
  String _text = 'Naciśnij przycisk i powiedz coś...';
  double _confidence = 0.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 100, 100, 100),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 50, 50, 50),
        title: Text("Rozpoznawanie mowy"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: Container(
          height: 100.0,
          width: 100.0,
          child: FittedBox(
            child: FloatingActionButton(
              heroTag: "listen",
              onPressed: _listen,
              child: Icon(isListening ? Icons.mic : Icons.mic_none),
            ),
          ),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 150.0, 30.0, 150.0),
          child: Column(
            children: [
              TextHighlight(
                text: _text,
                words: _highlights,
                textAlign: TextAlign.center,
                textStyle: const  TextStyle(
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
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: Text(
                    "Skuteczność algorytmu: " + (_confidence * 100).round().toString() + "%",
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
          )
        ),
    );
  }

  void _listen() async {
    if (!isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => isListening = false);
      _speech.stop();
    }
  }
}
