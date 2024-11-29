import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stopwatch App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: StopwatchScreen(),
    );
  }
}

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  String _formattedTime = "00:00:00";

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {
        _formattedTime = _formatTime(_stopwatch.elapsed);
      });
    });
  }

  void _startStopwatch() {
    _stopwatch.start();
    _startTimer();
  }

  void _pauseStopwatch() {
    _stopwatch.stop();
    _timer.cancel();
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    _timer.cancel();
    setState(() {
      _formattedTime = "00:00:00";
    });
  }

  String _formatTime(Duration duration) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    String milliseconds = (duration.inMilliseconds % 1000 ~/ 10).toString().padLeft(2, '0');
    return "$minutes:$seconds:$milliseconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stopwatch"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Time Display
          Text(
            _formattedTime,
            style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 40.0),
          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _stopwatch.isRunning ? _pauseStopwatch : _startStopwatch,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  backgroundColor: _stopwatch.isRunning ? Colors.orange : Colors.green,
                ),
                child: Text(
                  _stopwatch.isRunning ? "Pause" : "Start",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              SizedBox(width: 20.0),
              ElevatedButton(
                onPressed: _resetStopwatch,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  backgroundColor: Colors.red,
                ),
                child: Text(
                  "Reset",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
