import 'dart:convert';

import '../../domain/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/globals.dart';

class LocalPrefs {
  //singleton

  SharedPreferences sharedPreferences;
  LocalPrefs({required this.sharedPreferences});
  Future<String?> getAccessToken() async {
    return sharedPreferences.getString(Globals.accessToken) ?? '';
  }

  Future<void> clearAllData() async {
    sharedPreferences.clear();
  }

  Future<String?> getRefreshToken() {
    // TODO: implement getRefreshToken
    throw UnimplementedError();
  }

  Future<String?> getUsername() async {
    String? username = sharedPreferences.getString(Globals.username);
    return username;
  }

  Future<void> saveAccessToken(String accessToken) async {
    sharedPreferences.setString(Globals.accessToken, accessToken);
  }

  //Save User
  Future<void> saveUser(User user) async {
    sharedPreferences.setString(Globals.user, jsonEncode(user.toJson()));
  }

  //Get User
  Future<User?> getUser() async {
    String? userString = sharedPreferences.getString(Globals.user);
    if (userString != null) {
      return User.fromJson(jsonDecode(userString));
    } else {
      return null;
    }
  }

  Future<void> saveUsername(String username) async {
    sharedPreferences.setString(Globals.username, username);
  }

  //Save role of user
  Future<void> saveRole(String role) async {
    sharedPreferences.setString(Globals.role, role);
  }

  // Get role
  Future<String?> getRole() async {
    String? role = sharedPreferences.getString(Globals.role) ?? '';
    return role.toLowerCase();
  }

  //Clear all data
  Future<void> clearAll() async {
    sharedPreferences.clear();
  }
}
