import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Full-Screen Video Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Video Player'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      "https://firebasestorage.googleapis.com/v0/b/ne-ngelos.appspot.com/o/home_video.mp4?alt=media&token=45158d14-3c53-479b-9667-9f3360136cb1",
    )
      ..setVolume(0.0)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _toggleFullScreen();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height using MediaQuery
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? GestureDetector(
                onTap: (){
                  _toggleFullScreen();
                }, // Optionally, toggle full-screen on tap
                child: Container(
                  width: width,  // Set the width to the screen's width
                  height: height, // Set the height to the screen's height
                  padding: EdgeInsets.all(20),
                  child: VideoPlayer(_controller),
                ),
              )
            : Center(child: CircularProgressIndicator()), // Show loading indicator until initialized
      ),
    );
  }

  // Optionally, you can add logic to toggle full-screen if needed
  void _toggleFullScreen() {
    log("message");
    setState(() {
      // Handle the logic for toggling full-screen, e.g., use `SystemChrome.setEnabledSystemUIMode()`
      print("object");
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    });
  }
}
