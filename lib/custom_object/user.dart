class User {
  final String displayName;
  final String username;
  final String backgroundUrl;
  final String avatarUrl;
  final List<String>? badgeIds;

  User({
    required this.displayName,
    required this.username,
    required this.backgroundUrl,
    required this.avatarUrl,
    this.badgeIds,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var badgeList = json['badgeIds'] as List;
    List<String> badges = badgeList.map((id) => id.toString()).toList();

    return User(
      displayName: json['displayName'],
      username: json['username'],
      backgroundUrl: json['backgroundUrl'],
      avatarUrl: json['avatarUrl'],
      badgeIds: badges,
    );
  }
}