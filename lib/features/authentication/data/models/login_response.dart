class AuthResponse {
  String? message;
  User? user;
  String? refreshToken;
  String? accessToken;

  AuthResponse({this.message, this.user, this.refreshToken, this.accessToken});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    refreshToken = json['refresh_token'];
    accessToken = json['acess_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['refresh_token'] = refreshToken;
    data['acess_token'] = accessToken;
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? profilePicture;
  String? firstName;
  String? lastName;
  bool? isActive;
  bool? isVerified;
  bool? isSuperuser;

  User(
      {this.id,
      this.email,
      this.profilePicture,
      this.firstName,
      this.lastName,
      this.isActive,
      this.isVerified,
      this.isSuperuser});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
    isSuperuser = json['is_superuser'];
  }
  User.fromJsonMy(Map<String, dynamic> json) {
    json = json["user"];
    id = json['id'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
    isSuperuser = json['is_superuser'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['profilePicture'] = profilePicture;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['is_active'] = isActive;
    data['is_verified'] = isVerified;
    data['is_superuser'] = isSuperuser;
    return data;
  }
}
