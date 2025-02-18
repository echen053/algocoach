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
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No topics available.'));
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Select a Topic:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Georgia",
                      color: Constants.DARK_GREEN,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Constants.CARD_BACKGROUND_COLOR,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Constants.DARK_GREEN, width: 1.5),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      alignment: Alignment.center,
                      hint: const Center(
                        child: Text(
                          "No topic selected",
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
                      icon: const Icon(Icons.arrow_drop_down, color: Constants.DARK_GREEN),
                      value: controller.selectedTopicName,
                      onChanged: (String? newValue) {
                        controller.setSelectedTopicName(newValue);
                        refresh();
                      },
                      items: controller.allTopicNames.map<DropdownMenuItem<String>>((String t) {
                        return DropdownMenuItem<String>(
                          value: t,
                          child: Center(child: Text(t, textAlign: TextAlign.center)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Responsive Layout for Concept and Problems
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 600) {
                      // WIDE SCREEN (Row Layout)
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 550,
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
                                      ],
                                    ),
                                    child: ConceptWidget(concept: controller.getCurrentConcept()),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 550,
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
                                      ],
                                    ),
                                    child: ProblemWidget(problems: controller.getCurrentProblems()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      // SMALL SCREEN (Column Layout)
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 420,
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
                                  ],
                                ),
                                child: ConceptWidget(concept: controller.getCurrentConcept()),
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 450, // 👈 Increased height
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
                                  ],
                                ),
                                child: ProblemWidget(problems: controller.getCurrentProblems()),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}