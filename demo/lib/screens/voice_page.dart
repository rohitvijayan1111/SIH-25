import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoicePage extends StatefulWidget {
  const VoicePage({super.key});

  @override
  _VoicePageState createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Press the microphone to start listening...";
  double _confidence = 1.0;
  bool _speechAvailable = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _speechAvailable = await _speech.initialize(
      onStatus: (status) => debugPrint("Speech status: $status"),
      onError: (error) => debugPrint("Speech error: $error"),
    );
    setState(() {}); // refresh UI if not available
  }

  Future<void> _startListening() async {
    if (_speechAvailable && !_isListening) {
      setState(() => _isListening = true);
      await _speech.listen(
        onResult: (val) {
          setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          });
        },
        localeId:
            "ta-IN", // Tamil (India). Change to "en-IN" for English India, etc.
      );
    } else {
      debugPrint("Speech recognition not available.");
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Speech-to-Text Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _speechAvailable
                      ? _text
                      : "Speech recognition is not available on this device.",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isListening ? _stopListening : _startListening,
        child: Icon(_isListening ? Icons.mic : Icons.mic_none),
      ),
    );
  }
}
