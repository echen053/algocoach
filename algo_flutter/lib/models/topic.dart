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

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      name: json['name'],
      concept: Concept.fromJson(json['concept']),
      problems: (json['problems'] as List).map((problemJson) => Problem.fromJson(problemJson)).toList(),
    );
  }
}