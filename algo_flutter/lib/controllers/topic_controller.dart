import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/concept.dart';
import '../models/problem.dart';
import '../models/topic.dart';

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}


class TopicController {
  final String apiBaseUrl = "http://localhost:8000";
  List<String> allTopicNames = [];
  String? selectedTopicName;
  Topic? selectedTopic;

  TopicController();


  // Call API to get all topics
  Future<List<String>> getTopics() async {
    try {
      final response = await http.get(Uri.parse("$apiBaseUrl/topics/all"));

      if (response.statusCode == 200) {
        List<dynamic> topicsJson = response.body.isEmpty ? [] : json.decode(response.body);
        List<String> topics = List<String>.from(topicsJson);
        allTopicNames = topics;
        return allTopicNames;
      } else if (response.statusCode == 404) {
        // Simulating a scenario where the API returns a 404 error
        throw ApiException("No topics found");
      } else {
        throw ApiException("Failed to load topics. Status code: ${response.statusCode}");
      }
    } catch (error) {
      // Handle any exceptions that might occur during the request
      print('Error: $error');
      throw ApiException("Failed to load topics");
    }
  }

  // Call API to get one topic by name
  Future<Topic> getTopicByName(String topicName) async {
    try {
      final response = await http.get(Uri.parse("$apiBaseUrl/topics?name=$topicName"));

      if (response.statusCode == 200) {
        Map<String, dynamic> topicJson = json.decode(response.body);
        return Topic.fromJson(topicJson);
      } else if (response.statusCode == 404) {
        // Simulating a scenario where the API returns a 404 error
        throw ApiException("No topics found");
      } else {
        throw ApiException("Failed to load topics. Status code: ${response.statusCode}");
      }
    } catch (error) {
      // Handle any exceptions that might occur during the request
      print('Error: $error');
      throw ApiException("Failed to load topics");
    }
  }

  void setSelectedTopicName(String? topicName) async {
    selectedTopicName = topicName;
    // Call API to load topic
    if (topicName == null) {
      print("Error: No topic selected");
      return;
    }

    selectedTopic = await getTopicByName(topicName);
  }

  Concept? getCurrentConcept() {
    if (selectedTopic != null
        && selectedTopic?.concepts != null
        &&  selectedTopic!.concepts.isNotEmpty) {
      return selectedTopic!.concepts[0];
    }
    return null;
  }

  List<Problem> getCurrentProblems() {
    return selectedTopic?.problems ?? [];
  }

  static TopicController build() {
    return TopicController();
  }
}