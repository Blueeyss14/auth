import 'package:flutter/material.dart';

class IconModel {
  Icon icon;
  String label;

  IconModel({
    required this.icon,
    required this.label
  });

  static List<IconModel> iconModelData() {
    return [
      IconModel(
          icon: const Icon(Icons.home),
          label: "Home",
      ),
      IconModel(
        icon: const Icon(Icons.folder),
        label: "Folder",
      ),
      IconModel(
        icon: const Icon(Icons.search),
        label: "Search",
      ),
      IconModel(
        icon: const Icon(Icons.explore),
        label: "Search",
      ),
      IconModel(
        icon: const Icon(Icons.person),
        label: "Search",
      ),
    ];
  }
}
