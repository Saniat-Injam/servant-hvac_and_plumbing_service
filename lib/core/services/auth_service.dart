import 'dart:developer';
import 'package:get/get.dart';
import 'package:servant_hvac_and_plumbing_service/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'token';
  static const String _moodKey = 'selected_mood';
  static const String _userIdKey = 'userId';
  static const String _userRoleKey = 'role';
  static const String _isSeeOnboardingKey = 'isSeeOnboarding';

  // Remember me keys
  static const String _emailKey = 'remember_email';
  static const String _passwordKey = 'remember_password';

  static SharedPreferences? _preferences;

  static String? _token;
  static String? _userId;
  static String? _userRole;

  /// ✅ Initialize SharedPreferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _token = _preferences?.getString(_tokenKey);
    _userId = _preferences?.getString(_userIdKey);
    _userRole = _preferences?.getString(_userRoleKey);
    log("AuthService initialized. Token: $_token, UserId: $_userId,User Role: $_userRoleKey");
  }

  /// ✅ Helper to check initialization
  static Future<void> _ensureInitialized() async {
    if (_preferences == null) {
      await init();
    }
  }

  static Future<bool> hasToken() async {
    await _ensureInitialized();
    return _preferences!.containsKey(_tokenKey);
  }

  static Future<void> saveToken(String token, String userId,String userRole) async {
    await _ensureInitialized();
    try {
      await _preferences!.setString(_tokenKey, token);
      await _preferences!.setString(_userIdKey, userId);
      await _preferences!.setString(_userRoleKey, userRole);
      _token = token;
      _userId = userId;
      _userRole = userRole;
    } catch (e) {
      log('Error saving token or userId: $e');
    }
  }

  static Future<void> setOnboardingSeen(bool seen) async {
    await _ensureInitialized();
    try {
      await _preferences!.setBool(_isSeeOnboardingKey, seen);
      log('Onboarding flag saved: $seen');
    } catch (e) {
      log('Error saving onboarding flag: $e');
    }
  }

  static Future<void> saveSelectedMood(String mood) async {
    await _ensureInitialized();
    try {
      await _preferences!.setString(_moodKey, mood);
    } catch (e) {
      log('Error saving mood: $e');
    }
  }

  static Future<String?> getSelectedMood() async {
    await _ensureInitialized();
    return _preferences!.getString(_moodKey);
  }

  static Future<bool> hasSeenOnboarding() async {
    await _ensureInitialized();
    return _preferences!.getBool(_isSeeOnboardingKey) ?? false;
  }

  static Future<void> saveCredentials(String email, String password) async {
    await _ensureInitialized();
    await _preferences!.setString(_emailKey, email);
    await _preferences!.setString(_passwordKey, password);
  }

  static Future<void> clearCredentials() async {
    await _ensureInitialized();
    await _preferences!.remove(_emailKey);
    await _preferences!.remove(_passwordKey);
  }

  static Future<void> logoutUser() async {
    await _ensureInitialized();
    try {
      await _preferences!.remove(_tokenKey);
      await _preferences!.remove(_userIdKey);
      await _preferences!.remove(_userRoleKey);
      _token = null;
      _userId = null;
      _userRole = null;
      log("User logged out");
      await goToLogin();
    } catch (e) {
      log('Error during logout: $e');
    }
  }

  static Future<void> goToLogin() async {
     Get.offAllNamed(AppRoute.loginScreen);
  }

  static String? get token => _token;
  static String? get userId => _userId;
  static String? get userRole=> _userRole;

  static Future<String?> get rememberedEmail async {
    await _ensureInitialized();
    return _preferences!.getString(_emailKey);
  }

  static Future<String?> get rememberedPassword async {
    await _ensureInitialized();
    return _preferences!.getString(_passwordKey);
  }
}
