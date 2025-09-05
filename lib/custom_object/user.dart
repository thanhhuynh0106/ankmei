import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String username;
  final String? displayName;
  final String? email;
  final String? backgroundUrl;
  final String? avatarUrl;
  final String? bio;
  final String provider;
  final String userRole;
  final List<String>? badgeIds;

  User({
    required this.username,
    this.displayName,
    this.email,
    this.bio,
    this.backgroundUrl,
    this.avatarUrl,
    required this.provider,
    required this.userRole,
    this.badgeIds,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
