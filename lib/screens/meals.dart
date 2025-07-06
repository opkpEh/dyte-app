import 'dart:convert';
import 'package:dyte/data/dummy_data.dart';
import 'package:dyte/models/meal.dart';
import 'package:dyte/screens/meal_details.dart';
import 'package:dyte/screens/new_meal.dart';
import 'package:dyte/widgets/meal_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
    required this.categoryId,
  });

  final String title;
  final List<Meal> meals;
  final String categoryId;

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  List<Meal> _customMeals = [];
  List<Meal> _displayMeals = [];

  @override
  void initState() {
    super.initState();
    _loadCustomMeals();
  }

  Future<void> _loadCustomMeals() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? saved = prefs.getStringList('customMeals');

    if (saved != null) {
      _customMeals = saved
          .map((e) => Meal.fromJson(jsonDecode(e)))
          .where((meal) => meal.categories.contains(widget.categoryId))
          .toList();
    }

    // Combine default meals and custom meals for this category
    final defaultMeals = widget.meals
        .where((meal) => meal.categories.contains(widget.categoryId))
        .toList();

    setState(() {
      _displayMeals = [...defaultMeals, ..._customMeals];
    });
  }

  void _addMeal(Meal meal) async {
    setState(() {
      _customMeals.add(meal);
      if (meal.categories.contains(widget.categoryId)) {
        _displayMeals.add(meal);
      }
    });

    final prefs = await SharedPreferences.getInstance();
    final savedList =
        _customMeals.map((meal) => jsonEncode(meal.toJson())).toList();

    await prefs.setStringList('customMeals', savedList);
  }

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(meal: meal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_displayMeals.isEmpty) {
      content = SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Nothing to see',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Select a different category',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ],
          ),
        ),
      );
    } else {
      content = ListView.builder(
        itemCount: _displayMeals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: _displayMeals[index],
          onSelectMeal: (meal) {
            selectMeal(context, meal);
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (ctx) => NewMeal(
                  onAddMeal: _addMeal,
                  categoryId: widget.categoryId,
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
