import 'concept.dart';
import 'problem.dart';

class Topic {
  final String name;
  final Concept concept;
  final List<Problem> problems;

  Topic({
    required this.name,
    required this.concept,
    required this.problems,
  });
}
