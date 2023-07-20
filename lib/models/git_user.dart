///Classe para o usuário do gitHub. Útil para centralizar as informações da página perfil.
class GitUser {
  const GitUser({
    required this.avatarUrl,
    required this.fallowingNumber,
    required this.followersNumber,
    required this.id,
    required this.blog,
    required this.name,
    required this.bio,
    required this.projectsNumber,
    required this.location,
  });

  final String blog;
  final String id;
  final String avatarUrl;
  final String name;
  final String bio;
  final String location;
  final String followersNumber;
  final String fallowingNumber;
  final String projectsNumber;

  GitUser.fromJson(Map parsedUser)
      : id = parsedUser['login'],
        avatarUrl = parsedUser['avatar_url'],
        name = parsedUser['name'] ?? parsedUser['login'],
        location = parsedUser['location'] ?? 'Sem local',
        bio = parsedUser['bio'] ?? 'Sem biografia.',
        fallowingNumber = parsedUser['following'].toString(),
        followersNumber = parsedUser['followers'].toString(),
        projectsNumber = parsedUser['public_repos'].toString(),
        blog = parsedUser['blog'] ?? 'Sem blog pessoal';
}
