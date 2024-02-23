// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: STTScreen(),
//     );
//   }
// }
//
// class STTScreen extends StatefulWidget {
//   @override
//   _STTScreenState createState() => _STTScreenState();
// }
//
// class _STTScreenState extends State<STTScreen> {
//   stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _text = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Speech to Text Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(_text),
//             SizedBox(height: 20),
//             RaisedButton(
//               onPressed: _listen,
//               child: Text(_isListening ? 'Listening...' : 'Start Listening'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (status) {
//           print('Status: $status');
//         },
//         onError: (error) {
//           print('Error: $error');
//         },
//       );
//       if (available) {
//         setState(() {
//           _isListening = true;
//         });
//         _speech.listen(
//           onResult: (result) {
//             setState(() {
//               _text = result.recognizedWords;
//             });
//           },
//         );
//       }
//     } else {
//       setState(() {
//         _isListening = false;
//         _speech.stop();
//       });
//     }
//   }
// }
