///classe responsável por reunir os dados dos projetos
class Project {
  const Project({this.updatedAt, this.language, this.name, this.description});
  final String name, description, language;
  final DateTime updatedAt;

  ///BEGIN GAMBIARRA
  String get updatedAtToString =>
      "${_putZero(updatedAt.day)}/${_putZero(updatedAt.month)}/${updatedAt.year}";
  static String _putZero(int number) => number < 10 ? "0$number" : "$number";
  ///END GAMBIARRA

  static Project fromJson(Map data) => Project(
      name: data['name'],
      updatedAt: DateTime.parse(data['updated_at']),
      description: data['description'] ?? "Sem descrição.",
      language: data['language'] ?? "");
}
