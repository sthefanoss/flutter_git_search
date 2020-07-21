class Project {
  final String name;
  final String description;
  final String language;
  final DateTime updatedAt;

  String get updatedAtToString {
    return '${_putZero(updatedAt.day)}/${_putZero(updatedAt.month)}/${updatedAt.year}';
  }

  static String _putZero(int number) => number < 10 ? "0$number" : "$number";

  const Project({
    this.updatedAt,
    this.language,
    this.name,
    this.description,
  });

  Project.fromJson(Map json)
      : this.name = json['name'],
        this.updatedAt = DateTime.parse(json['updated_at']),
        this.description = json['description'] ?? "Sem descrição.",
        this.language = json['language'] ?? "";
}
