import 'package:algo_flutter/screens/problem_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/topic_controller.dart';
import '../models/topic.dart';
import 'concept_widget.dart';

class TopicScreen extends StatelessWidget {
  final TopicController controller;
  final Function onRefresh; // Callback function

  const TopicScreen(
      {super.key, required this.controller, required this.onRefresh});

  void refresh() {
    // logger("Refrehsing screens...");
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('Select a Topic:'),
        DropdownButton<Topic>(
          value: controller.selectedTopic,
          onChanged: (Topic? newValue) {
            controller.setSelectedTopic(newValue);
            refresh();
          },
          items: controller.allTopics.map<DropdownMenuItem<Topic>>((Topic t) {
            return DropdownMenuItem<Topic>(
              value: t,
              child: Text(t.name),
            );
          }).toList(),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ConceptWidget(concept: controller.selectedTopic?.concept),
            const SizedBox(width: 10),
            ProblemWidget(problem: controller.selectedTopic?.problems[0]),
          ],
        ),
      ],
    );
  }
}
