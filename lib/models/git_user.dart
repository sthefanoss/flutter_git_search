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

  final String blog;
  final String id;
  final String avatarUrl;
  final String name;
  final String bio;
  final String location;
  final String followersNumber;
  final String fallowingNumber;
  final String projectsNumber;

  GitUser.fromJson(Map json)
      : this.id = json['login'],
        this.avatarUrl = json['avatar_url'],
        this.name = json['name'] ?? json['login'],
        this.location = json['location'] ?? 'Sem local',
        this.bio = json['bio'] ?? 'Sem biografia.',
        this.fallowingNumber = json['following'].toString(),
        this.followersNumber = json['followers'].toString(),
        this.projectsNumber = json['public_repos'].toString(),
        this.blog = json['blog'] == "" ? 'Sem blog pessoal' : json['blog'];
}
