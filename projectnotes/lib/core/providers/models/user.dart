import 'dart:convert';

class UserData {
  final String? displayName;
  final String? email;
  final String? imageUrl;
  UserData({
    this.displayName,
    this.email,
    this.imageUrl,
  });

  UserData copyWith({
    String? displayName,
    String? email,
    String? imageUrl,
  }) {
    return UserData(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      displayName: map['displayName'],
      email: map['email'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserData(displayName: $displayName, email: $email, imageUrl: $imageUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.displayName == displayName &&
        other.email == email &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => displayName.hashCode ^ email.hashCode ^ imageUrl.hashCode;
}
