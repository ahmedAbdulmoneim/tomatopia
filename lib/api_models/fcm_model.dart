class UserToken {
  final String? token;
  final String userId;

  UserToken({
    required this.token,
    required this.userId,
  });

  // Factory constructor to create a UserToken from JSON
  factory UserToken.fromJson(Map<String, dynamic> json) {
    return UserToken(
      token: json['token'],
      userId: json['userId'],
    );
  }


  // Factory constructor to create a list of UserToken from JSON
  static List<UserToken> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => UserToken.fromJson(json)).toList();
  }


}
