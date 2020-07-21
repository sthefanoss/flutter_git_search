import 'package:flutter_git_search/models/user.dart';

class Profile extends User {
  final String blog;
  final String name;
  final String bio;
  final String location;
  final int followersCount;
  final int fallowingCount;
  final int projectsCount;

  const Profile({
    this.fallowingCount,
    this.followersCount,
    this.blog,
    this.name,
    this.bio,
    this.projectsCount,
    this.location,
  });

  Profile.fromJson(Map json)
      : this.name = json['name'] ?? json['login'],
        this.location = json['location'] ?? 'Sem local',
        this.bio = json['bio'] ?? 'Sem biografia.',
        this.fallowingCount = json['following'],
        this.followersCount = json['followers'],
        this.projectsCount = json['public_repos'],
        this.blog = json['blog'] == "" ? 'Sem blog pessoal' : json['blog'],
        super(login: json['login'], avatarUrl: json['avatar_url']);
}
