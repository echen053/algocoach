import 'concept.dart'; // Import the Concept class
import 'problem.dart'; // Import the Problem class

class Concept {
  final String description;

  Concept({
    required this.description,
  });

  factory Concept.fromJson(Map<String, dynamic> json) {
    return Concept(
      description: json['description'] ?? "No description",
    );
  }
}
