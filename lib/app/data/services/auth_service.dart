// lib/core/services/auth_service.dart
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/login_otp_request.dart';

class AuthService extends GetxService {
  static const String _tokenBoxName = 'tokenBox';
  static const String _tokenKey = 'authToken';
  Box<Token>? _tokenBox;

  // Track initialization state
  final _isInitialized = false.obs;
  bool get isInitialized => _isInitialized.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _initializeBox();
  }

  Future<void> _initializeBox() async {
    try {
      if (_tokenBox == null || !(_tokenBox?.isOpen ?? false)) {
        _tokenBox = await Hive.openBox<Token>(_tokenBoxName);
        _isInitialized.value = true;
        debugPrint('Token box initialized successfully');
      }
    } catch (e) {
      debugPrint('Error initializing token box: $e');
      _isInitialized.value = false;
    }
  }

  Future<AuthService> init() async {
    await _initializeBox();
    return this;
  }

  Future<void> saveToken(Token token) async {
    try {
      await _initializeBox();

      debugPrint('Attempting to save token: ${token.token}');
      await _tokenBox?.clear();
      await _tokenBox?.put(_tokenKey, token);

      // Verify save
      final savedToken = getToken();
      debugPrint('Token saved and verified: ${savedToken?.token}');
    } catch (e) {
      debugPrint('Error saving token: $e');
      rethrow;
    }
  }

  Token? getToken() {
    try {
      if (!isInitialized || _tokenBox == null || !_tokenBox!.isOpen) {
        debugPrint('Token box not initialized or not open');
        return null;
      }

      final token = _tokenBox?.get(_tokenKey);
      debugPrint('Retrieved token: ${token?.token}');
      return token;
    } catch (e) {
      debugPrint('Error getting token: $e');
      return null;
    }
  }

  bool get hasToken {
    if (!isInitialized) {
      debugPrint('Auth service not initialized');
      return false;
    }

    try {
      final token = getToken()?.token;
      final isValid = token != null && token.isNotEmpty;
      debugPrint('Token check - exists: ${token != null}, valid: $isValid');
      return isValid;
    } catch (e) {
      debugPrint('Error checking token: $e');
      return false;
    }
  }

  String? get authToken {
    if (!isInitialized) return null;
    return getToken()?.token;
  }

  Future<void> clearToken() async {
    try {
      await _initializeBox();
      await _tokenBox?.clear();
      debugPrint('Token cleared successfully');
    } catch (e) {
      debugPrint('Error clearing token: $e');
    }
  }

  Future<void> logout() async {
    try {
      await clearToken();
      Get.offAllNamed('/registration');
    } catch (e) {
      debugPrint('Error during logout: $e');
    }
  }

  @override
  void onClose() {
    try {
      if (_tokenBox?.isOpen ?? false) {
        _tokenBox?.close();
        debugPrint('Token box closed successfully');
      }
    } catch (e) {
      debugPrint('Error closing token box: $e');
    }
    super.onClose();
  }

  // Helper method to check box status
  bool get isBoxReady {
    final isReady = _tokenBox != null && _tokenBox!.isOpen;
    debugPrint('Box status check - initialized: $isInitialized, box ready: $isReady');
    return isReady;
  }
}
