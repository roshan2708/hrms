import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final _isDarkTheme = false.obs;

  bool get isDarkTheme => _isDarkTheme.value;

  @override
  void onInit() {
    super.onInit();
    _isDarkTheme.value = Get.isPlatformDarkMode;
  }

  void toggleTheme() {
    _isDarkTheme.value = !_isDarkTheme.value;
    Get.changeThemeMode(_isDarkTheme.value ? ThemeMode.dark : ThemeMode.light);
  }
}
