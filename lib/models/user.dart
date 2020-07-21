class User {
  final int id;
  final String login;
  final String avatarUrl;

  const User({this.id, this.login, this.avatarUrl});

  User.fromJson(Map json)
      : login = json['login'],
        id = json['id'],
        avatarUrl = json['avatar_url'];
}
