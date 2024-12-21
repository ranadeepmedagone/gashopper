// lib/core/services/auth_service.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/login_otp_request.dart';

class AuthService extends GetxService {
  static const String _tokenBoxName = 'tokenBox';
  static const String _tokenKey = 'authToken';
  Box<Token>? _tokenBox;

  Future<AuthService> init() async {
    try {
      await Hive.initFlutter();

      // Register adapter only if not registered
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(TokenAdapter());
      }

      _tokenBox = await Hive.openBox<Token>(_tokenBoxName);
      debugPrint('AuthService initialized successfully');
      return this;
    } catch (e) {
      debugPrint('Error initializing AuthService: $e');
      rethrow;
    }
  }

  // Token Management
  Future<void> saveToken(Token token) async {
    try {
      await _tokenBox?.put(_tokenKey, token);
      debugPrint('Token saved successfully');
    } catch (e) {
      debugPrint('Error saving token: $e');
      rethrow;
    }
  }

  Token? getToken() {
    try {
      final token = _tokenBox?.get(_tokenKey);
      debugPrint('Token retrieved: ${token?.token != null}');
      return token;
    } catch (e) {
      debugPrint('Error getting token: $e');
      return null;
    }
  }

  bool get hasToken {
    final token = getToken()?.token;
    final isValid = token != null && token.isNotEmpty;
    debugPrint('Has valid token: $isValid');
    return isValid;
  }

  String? get authToken => getToken()?.token;

  Future<void> clearToken() async {
    try {
      await _tokenBox?.clear();
      debugPrint('Token cleared successfully');
    } catch (e) {
      debugPrint('Error clearing token: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    await clearToken();
    Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    _tokenBox?.close();
    super.onClose();
  }
}
