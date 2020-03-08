///Classe para o usuário do gitHub. Útil para centralizar as informações da página perfil.
class GitUser {
  const GitUser({
    this.avatarUrl,
    this.fallowingNumber,
    this.followersNumber,
    this.id,
    this.blog,
    this.name,
    this.bio,
    this.projectsNumber,
    this.location,
  });

  final String blog,
      id,
      avatarUrl,
      name,
      bio,
      location,
      followersNumber,
      fallowingNumber,
      projectsNumber;

  ///Função que recebe o mapa de json já decodificado, e transforma em um membro da classe.
  /// Essa função é útil porque a classe foi feita imutável. Então não possível colocar
  /// lógica para alterar os parâmetros no contrutor. Tendo a lógica em um método estático,
  /// é permitido retornar a classe processada posteriormente - tornando o código limpo.
  static fromJson(Map parsedUser) => GitUser(
        id: parsedUser['login'],
        avatarUrl: parsedUser['avatar_url'],
        name: parsedUser['name'] ?? parsedUser['login'],

        ///equivalente a name: parsedUser['name'] != null ? parsedUser['name'] : parsedUser['login']
        location: parsedUser['location'] ?? 'Sem local',
        bio: parsedUser['bio'] ?? 'Sem biografia.',
        fallowingNumber: parsedUser['following'].toString(),
        followersNumber: parsedUser['followers'].toString(),
        projectsNumber: parsedUser['public_repos'].toString(),
        blog:
            parsedUser['blog'] == "" ? 'Sem blog pessoal' : parsedUser['blog'],
      );
}
