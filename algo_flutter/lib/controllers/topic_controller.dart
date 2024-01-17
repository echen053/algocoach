import '../models/concept.dart';
import '../models/problem.dart';
import '../models/topic.dart';

class TopicController {
  List<Topic> allTopics = [];
  Topic? selectedTopic;

  TopicController({
    required this.allTopics,
  }) {
    selectedTopic = allTopics[0];
  }

  void setSelectedTopic(Topic? topic) {
    selectedTopic = topic;
  }

  static TopicController build() {
    return TopicController(allTopics: [
      Topic(
          name:"None",
          concept:Concept(description:""),
        problems: [
          Problem(name: "None", url: "none")
        ]
      ),
      Topic(
          name:"DFS",
          concept:Concept(description:"This is DFS concept"),
        problems: [
          Problem(name: "L1.1", url: "https://www.leetcode.com/problems/l11"),
          Problem(name: "L1.2", url: "https://www.leetcode.com/problems/l12"),
        ]
      ),
      Topic(
          name:"BFS",
          concept:Concept(description:"This is BFS concept"),
        problems: [
          Problem(name: "L2.1", url: "https://www.leetcode.com/problems/l11"),
          Problem(name: "L2.2", url: "https://www.leetcode.com/problems/l12"),
        ]
      )
    ]);
  }
}