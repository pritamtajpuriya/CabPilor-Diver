import '../../domain/model/user.dart';

class LoginResponse {
  User? user;
  // String? token;
  // String? name;
  // String? role;

  LoginResponse({
    this.user,
    // this.token,
    // this.name,
    // this.role,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        user: User.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}
