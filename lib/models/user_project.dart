class Project {
  const Project({
    required this.updatedAt,
    required this.language,
    required this.name,
    required this.description,
  });

  final String name;
  final String description;
  final String language;
  final DateTime updatedAt;

  String get updatedAtToString => "${formatInteger(updatedAt.day)}"
      "/${formatInteger(updatedAt.month)}"
      "/${formatInteger(updatedAt.year)}";

  static String formatInteger(int number) => number.toString().padLeft(2, '0');

  Project.fromJson(Map data)
      : name = data['name'],
        updatedAt = DateTime.parse(data['updated_at']),
        description = data['description'] ?? "Sem descrição.",
        language = data['language'] ?? "";
}
