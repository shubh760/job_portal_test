import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _keyUserEmail = "userEmail";
  static const String _keyUserName = "userName";
  static const String _keyUserId = "userId";
  static const String _keyUserPhotoUrl = "userPhotoUrl";

  // Save user data
  static Future<void> saveUserData({
    required String? email,
    required String? name,
    required String? userId,
    String? photoUrl,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserEmail, email ?? '');
    await prefs.setString(_keyUserName, name ?? '');
    await prefs.setString(_keyUserId, userId ?? '');
    if (photoUrl != null) {
      await prefs.setString(_keyUserPhotoUrl, photoUrl);
    }
  }

  // Get user email
  static Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserEmail);
  }

  // Get user name
  static Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  // Get user ID
  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  // Get user photo URL
  static Future<String?> getUserPhotoUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserPhotoUrl);
  }

  // Clear user data
  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserEmail);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserPhotoUrl);
  }
}
