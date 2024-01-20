import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:algo_flutter/models/topic.dart';

void main() {
  group('Topic', () {
    test('fromJson creates a Topic instance', () {
      // Mock JSON data
      String jsonString = '{"name":"BFS","concept":{"name":"BFS Concept"},"problems":[{"name":"P1.1","url":"http:p1.1"},{"name":"P1.2","url":"http:p1.2"}]}';
      Map<String, dynamic> jsonData = json.decode(jsonString);

      // Create a Topic instance from JSON
      Topic topic = Topic.fromJson(jsonData);

      // Verify the properties of the created instance
      expect(topic.name, 'BFS');
      expect(topic.concept.description, 'No description');
      expect(topic.problems.length, 2);
      expect(topic.problems[0].name, 'P1.1');
      expect(topic.problems[0].url, 'http:p1.1');
      expect(topic.problems[1].name, 'P1.2');
      expect(topic.problems[1].url, 'http:p1.2');
    });
  });
}
