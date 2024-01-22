import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:algo_flutter/models/topic.dart';

void main() {
  group('Topic', () {
    test('fromJson creates a Topic instance', () {
      // Mock JSON data
      String jsonString =
          '{"id":1,"name":"Breadth First Search","description":"It\'s like flood fill.","concepts":[{"id":1,"description":"The concept is like flood fill."}],"problems":[{"id":1,"name":"278. First Bad Version","url":"https://leetcode.com/problems/first-bad-version"},{"id":2,"name":"100. Same Tree","url":"https://leetcode.com/problems/same-tree"},{"id":3,"name":"104. Maximum Depth of Binary Tree","url":"https://leetcode.com/problems/maximum-depth-of-binary-tree"}]}';
      Map<String, dynamic> jsonData = json.decode(jsonString);

      // Create a Topic instance from JSON
      Topic topic = Topic.fromJson(jsonData);

      // Verify the properties of the created instance
      expect(topic.name, 'Breadth First Search');
      expect(topic.concepts.length, 1);
      expect(topic.concepts[0].description, "The concept is like flood fill.");

      expect(topic.problems.length, 3);
      expect(topic.problems[0].name, "278. First Bad Version");
      expect(topic.problems[0].url, 'https://leetcode.com/problems/first-bad-version');
      expect(topic.problems[2].name, "104. Maximum Depth of Binary Tree");
    });
  });
}
