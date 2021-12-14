class UserModel {
  final String displayName;
  final String email;
  final String userId;

  UserModel({this.displayName, this.email, this.userId});

  UserModel.fromJson(Map<String, dynamic> json, String userId)
      : displayName = json['displayName'],
        userId = userId,
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'userId': userId,
        'email': email,
      };
}
