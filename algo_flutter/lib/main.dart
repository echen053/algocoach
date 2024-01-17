import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlgoCoach',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'AlgoCoach'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Numbers represent the different topics availble (todo later)
  int topic = 0;
  String? selectedValue = 'None';
  Widget conceptPage = TopicWidget.getPage('None', 0);
  Widget problemsPage = TopicWidget.getPage('None', 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Select a Topic:'),
            DropdownButton<String>(
              value: selectedValue,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue;
                  conceptPage = TopicWidget.getPage(selectedValue, 0);
                  problemsPage = TopicWidget.getPage(selectedValue, 1);
                });
              },
              items: <String>[
                'None',
                'Depth First Search',
                'Breadth First Search',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                conceptPage,
                SizedBox(width: 10),
                problemsPage,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

abstract class TopicWidget extends StatelessWidget {
  static final Map<String, List<String>> topicMap = {
    'None': ['Concept', 'Problem List'],
    'Depth First Search': ['Concept: DFS', 'Problem List for DFS'],
    'Breadth First Search': ['Concept: BFS', 'Problem List for BFS'],
  };

  static Widget getPage(String? topic, int pageType) {
    String concept = topicMap[topic]?[pageType] ??
        ''; // Use null-aware operator to handle potential null

    return Card(
      // color: theme.colorScheme.onPrimary,
      elevation: 8,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(concept),
            Padding(
              padding: const EdgeInsets.all(170),
            ),
          ]),
    );
  }
}
