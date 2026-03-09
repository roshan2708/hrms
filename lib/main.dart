import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  // Initialize the ThemeController globally
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HRMS Application',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Get.find<ThemeController>().isDarkTheme
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: Routes.login,
      getPages: AppPages.routes,
    );
  }
}
