import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intro/Utils/AssetsManaget.dart';
import 'package:intro/Utils/Widgets/BottomSheet.dart';
import 'package:get/get.dart';
import '../Utils/Widgets/ViewPages.dart';
import 'package:intro/Utils/Widgets/theme_controller.dart'; // Import the Theme Controller

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  int currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Obx(() {
                return Switch(
                  value: themeController.isDarkMode,
                  onChanged: (value) {
                    themeController.toggleTheme();
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }),
              const SizedBox(width: 5),
              Obx(() {
                return Text(
                  themeController.isDarkMode ? "Dark" : "Light",
                  style: const TextStyle(fontSize: 14),
                );
              }),
            ],
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            children: const [
              ViewPages(
                image: AssetsManager.image6,
                title: "Welcome",
                about: "Discover more delicious recipes from around the world",
              ),
              ViewPages(
                image: AssetsManager.image5,
                title: "Cook Like a Pro",
                about: "Learn cooking techniques and try out new recipes in your kitchen",
              ),
              ViewPages(
                image: AssetsManager.image2,
                title: "Explore",
                about: "Find recipes from different cuisines and satisfy your taste buds",
              ),
            ],
          ),
          bodyContent(),
        ],
      ),
    );
  }

  Widget bodyContent() {
    return SizedBox(
      height: 180,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildIndicator(),
          ),
          const SizedBox(height: 30),
          Container(
            height: 3,
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: const BoxDecoration(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                myContainer("Skip"),
                currentIndex == 2
                    ? GestureDetector(
                  onTap: onTap,
                  child: myContainer("Done"),
                )
                    : myContainer("Next"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget myContainer(String txt) {
    return Container(
      height: 45,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(txt),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }

  onTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(42),
          topRight: Radius.circular(42),
        ),
      ),
      builder: (_) => const MyBottomSheet(),
    );
  }
}
