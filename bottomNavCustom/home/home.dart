import 'package:cool_ui/models/icon_model.dart';
import 'package:cool_ui/pages/explore_page.dart';
import 'package:cool_ui/pages/folder_page.dart';
import 'package:cool_ui/pages/main_page.dart';
import 'package:cool_ui/pages/profile_page.dart';
import 'package:cool_ui/pages/search_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = [
    const MainPage(),
    const FolderPage(),
    const SearchPage(),
    const ExplorePage(),
    const ProfilePage(),
  ];

  final List<IconModel> bottomNavList = IconModel.iconModelData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: Stack(
        children: [
          /// Bottom navbar
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.amber,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int index = 0; index < bottomNavList.length; index++)
                            Flexible(
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: [Colors.green, Colors.red, Colors.pink, Colors.blue, Colors.green][index],
                                child: bottomNavList[index].icon,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),

        ],
      ),
    );
  }
}
