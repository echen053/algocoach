import 'concept.dart';
import 'problem.dart';

class Topic {
  final String name;
  final List<Concept> concepts;
  final List<Problem> problems;

  Topic({
    required this.name,
    required this.concepts,
    required this.problems,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      name: json['name'],
      concepts:(json['concepts'] as List).map((conceptJson) => Concept.fromJson(conceptJson)).toList(),
      problems: (json['problems'] as List).map((problemJson) => Problem.fromJson(problemJson)).toList(),
    );
  }
}