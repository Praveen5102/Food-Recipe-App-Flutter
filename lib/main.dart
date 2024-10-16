import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/Introduction.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intro/Utils/Widgets/theme_controller.dart';


void main() async {
  await GetStorage.init();
  final themeController = Get.put(ThemeController());  // Initialize ThemeController

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Obx(() {
      return GetMaterialApp(
        title: 'Recipe App',
        theme: ThemeData.light(),  // Light theme
        darkTheme: ThemeData.dark(),  // Dark theme
        themeMode: themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: Introduction(),
      );
    });
  }
}
