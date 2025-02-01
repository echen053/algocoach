import 'package:algo_flutter/screens/problem_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/topic_controller.dart';
import 'concept_widget.dart';
import 'constants.dart';

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
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No topics available.'),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    'No Topic Selected:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Georgia",
                      color: Constants.DARK_GREEN,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 8),

                // Centered Dropdown Button
                Center(
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Constants.CARD_BACKGROUND_COLOR,
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: Constants.DARK_GREEN, width: 1.5),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      alignment: Alignment.center,
                      hint: const Center(
                        child: Text(
                          "Select a Topic",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Constants.DARK_GREEN,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      dropdownColor: Colors.green[100],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Constants.DARK_GREEN,
                      ),
                      icon:
                          Icon(Icons.arrow_drop_down, color: Colors.green[900]),
                      value: controller.selectedTopicName,
                      onChanged: (String? newValue) {
                        controller.setSelectedTopicName(newValue);
                        refresh();
                      },
                      items: controller.allTopicNames
                          .map<DropdownMenuItem<String>>((String t) {
                        return DropdownMenuItem<String>(
                          value: t,
                          child: Center(
                            child: Text(
                              t,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                // Concept and Problems Section
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 250,
                          child: ConceptWidget(
                              concept: controller.getCurrentConcept()),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 250,
                          child: ProblemWidget(
                              problems: controller.getCurrentProblems()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
