class User {
  final int id;
  final int githubId;
  final String username;
  final String email;
  final String avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.githubId,
    required this.username,
    required this.email,
    required this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.githubId == githubId &&
        other.username == username &&
        other.email == email &&
        other.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        githubId.hashCode ^
        username.hashCode ^
        email.hashCode ^
        avatarUrl.hashCode;
  }

  @override
  String toString() {
    return 'User(id: $id, githubId: $githubId, username: $username, email: $email)';
  }
}
