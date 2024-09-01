import 'package:flutter/material.dart';
import 'package:tabbar_custom/pages/page1.dart';
import 'package:tabbar_custom/pages/page2.dart';
import 'package:tabbar_custom/pages/page3.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();

  List<Widget> pages = [
    Page1(),
    Page2(),
    Page3(),
  ];

  void pageIndex(int index) {
    setState(() {
      currentIndex = index;
    });
    pageController.animateToPage(
      currentIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linearToEaseOut,
    );
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: pages,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.amber,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (int i = 0; i < pages.length; i++)
                        GestureDetector(
                          onTap: () => pageIndex(i),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: currentIndex == i ? Colors.green : Colors.transparent,
                            child: Center(
                              child: Text("${i + 1}"),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
