class Problem {
  final String name;
  final String url;

  Problem({
    required this.name,
    required this.url,
  });

  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
      name: json['name'] ?? "No Name",
      url: json['url'] ?? "No URL",
    );
  }
}