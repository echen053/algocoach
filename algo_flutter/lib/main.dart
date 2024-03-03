import 'package:algo_flutter/controllers/topic_controller.dart';
import 'package:algo_flutter/screens/topic_screen.dart';
import 'package:algo_flutter/screens/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AlgoCoach',
      theme: ThemeData(
        scaffoldBackgroundColor: Constants.BACKGROUND_COLOR,
      ),
      home: const MyHomePage(title: 'AlgoCoach'),
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
  TopicController controller = TopicController.build();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.BACKGROUND_COLOR,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: TopicScreen(
        controller: controller,
        onRefresh: () {
          // Put the logic executing on refresh here

          // Trigger a rebuild of the widget
          setState(() {});
        },
      ),
    );
  }
}
