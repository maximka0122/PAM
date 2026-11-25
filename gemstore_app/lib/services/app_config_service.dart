import 'dart:convert';
import 'package:flutter/services.dart';

class AppConfigService {
  static Map<String, dynamic>? _config;

  static Future<Map<String, dynamic>> loadConfig() async {
    if (_config != null) return _config!;
    try {
      final String response = await rootBundle.loadString('assets/lab_v1.json');
      _config = json.decode(response) as Map<String, dynamic>;
    } catch (e) {
      _config = {};
    }
    return _config!;
  }
}
