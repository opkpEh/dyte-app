import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.amber,
  });

  final String id;
  final String title;
  final Color color;

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'color': color.value};
  }

  static Category fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      color: Color(json['color']),
    );
  }
}
