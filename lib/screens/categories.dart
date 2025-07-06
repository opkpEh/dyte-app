import 'package:dyte/data/dummy_data.dart';
import 'package:dyte/screens/meals.dart';
import 'package:dyte/screens/new_category.dart';
import 'package:dyte/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:dyte/models/category.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> _customCategories = [];

  @override
  void initState() {
    super.initState();
    _loadCustomCategories();
  }

  Future<void> _loadCustomCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? saved = prefs.getStringList('customCategories');

    if (saved != null) {
      setState(() {
        _customCategories =
            saved.map((e) => Category.fromJson(jsonDecode(e))).toList();
            availableCategories.addAll(_customCategories);
      });
    }
  }

  void _addCategory(Category category) async {
    setState(() {
      availableCategories.add(category);
      _customCategories.add(category);
    });

    final prefs= await SharedPreferences.getInstance();
    final savedList= _customCategories.map((category)=> jsonEncode(category.toJson())).toList();

    await prefs.setStringList('customCategories', savedList);
  }

  void _selectCategory(Category category) {
    final filteredMeals =
        dummyMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(title: category.title, categoryId: category.id, meals: filteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a category"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                useSafeArea: true,
                context: context,
                builder: (ctx) => NewCategory(onAddCategory: _addCategory),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),

      body: GridView(
        padding: EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(category);
              },
            ),
        ],
      ),
    );
  }
}
