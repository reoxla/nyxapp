import 'package:flutter/material.dart';
import 'recording.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final VoiceRecorderService _service = VoiceRecorderService();

  @override
  void initState() {
    _service.initPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: _service.startRecording,
              child: Text("start Recording"),
            ),
            TextButton(
              onPressed: _service.stopRecording,
              child: Text("stop recording"),
            ),
            TextButton(
              onPressed: _service.playRecording,
              child: Text("play recording"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // You call your custom method here
    _service.cleanUp();

    // Then you call the REQUIRED super.dispose() for the State
    super.dispose();
  }
}
