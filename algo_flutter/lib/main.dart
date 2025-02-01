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
        primaryColor: Constants.DARK_GREEN,
        scaffoldBackgroundColor: Constants.BACKGROUND_COLOR,
        appBarTheme: AppBarTheme(
          backgroundColor: Constants.DARK_GREEN,
        ),
        fontFamily: "Georgia",
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: "Georgia"),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87, fontFamily: "Georgia"),
        ),
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

  Widget _buildNavButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.DARK_GREEN,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        elevation: 2,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Constants.BACKGROUND_COLOR,
          fontFamily: "Georgia"
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Adjust height
        child: AppBar(
          backgroundColor: Constants.CARD_BACKGROUND_COLOR, // Light green background
          elevation: 0, // Remove shadow
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo with shadow effect
              Text(
                'AlgoCoach📚',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto",
                  color: Constants.DARK_GREEN,
                  shadows: const [
                    Shadow(offset: Offset(2, 2), blurRadius: 3, color: Colors.black38),
                  ],
                ),
              ),

              // Navigation Buttons
              Row(
                children: [
                  _buildNavButton("Log in", () {}),
                  const SizedBox(width: 15),
                  _buildNavButton("Home", () {}),
                  const SizedBox(width: 10),
                  _buildNavButton("Progress", () {}),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TopicScreen(
        controller: controller,
        onRefresh: () {
          setState(() {});
        },
      ),
    );
  }
}
