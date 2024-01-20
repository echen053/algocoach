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
    // logger("Refreshing screens...");
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getTopics(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a waiting icon while the data is being fetched
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // Handle errors
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Handle the case where no topics are available
          return const Center(
            child: Text('No topics available.'),
          );
        } else {
          // Display the topics
          List<String> topics = snapshot.data!;
          return Column(
              children: <Widget>[
                const Text('Select a Topic:'),
                DropdownButton<String>(
                  value: controller.selectedTopicName,
                  onChanged: (String? newValue) {
                    controller.setSelectedTopicName(newValue);
                    refresh();
                  },
                  items: controller.allTopicNames.map<DropdownMenuItem<String>>((
                      String t) {
                    return DropdownMenuItem<String>(
                      value: t,
                      child: Text(t),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ConceptWidget(concept: controller.getCurrentConcept()),
                    const SizedBox(width: 10),
                    ProblemWidget(problem: controller.getFirstProblem()),
                  ],
                ),
              ],
          );
        }
      },
    );
  }
}
