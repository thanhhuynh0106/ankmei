// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String?,
  username: json['username'] as String,
  displayName: json['displayName'] as String?,
  email: json['email'] as String?,
  bio: json['bio'] as String?,
  backgroundUrl: json['backgroundUrl'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  provider: json['provider'] as String,
  userRole: json['userRole'] as String,
  badgeIds: (json['badgeIds'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'displayName': instance.displayName,
  'email': instance.email,
  'backgroundUrl': instance.backgroundUrl,
  'avatarUrl': instance.avatarUrl,
  'bio': instance.bio,
  'provider': instance.provider,
  'userRole': instance.userRole,
  'badgeIds': instance.badgeIds,
};
