import 'package:dyte/data/dummy_data.dart';
import 'package:dyte/models/meal.dart';
import 'package:flutter/material.dart';

class NewMeal extends StatefulWidget {
  const NewMeal({super.key, required this.onAddMeal, required this.categoryId});

  final void Function(Meal meal) onAddMeal;
  final String categoryId;

  @override
  State<NewMeal> createState() {
    return _NewMeal();
  }
}

class _NewMeal extends State<NewMeal> {
  final _titleController = TextEditingController();
  final _timeController = TextEditingController();
  Affordability _selectedAffordability = Affordability.affordable;
  Complexity _selectedComplexity = Complexity.simple;
  final _imageUrlController = TextEditingController();
  bool _isGlutenFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _isLactoseFree = false;

  void _saveMeal() {
    if (_titleController.text.trim().isEmpty ||
        _timeController.text.trim().isEmpty ||
        _imageUrlController.text.trim().isEmpty) {
      return;
    }
    final lastId = dummyMeals.last.id;
    final lastNumber = int.tryParse(lastId.replaceAll('m', '')) ?? 0;
    final nextId = 'm${lastNumber + 1}';
    List<String> categoryIds = [widget.categoryId];
    List<String> ingredients= ['None for now'];
    List<String> steps= ['None for now'];

    widget.onAddMeal(
      Meal(
        id: nextId,
        categories: categoryIds,
        title: _titleController.text,
        imageUrl: _imageUrlController.text,
        duration: int.tryParse(_timeController.text)!,
        complexity: _selectedComplexity,
        affordability: _selectedAffordability,
        ingredients: ingredients,
        steps: steps,
        isGlutenFree: _isGlutenFree,
        isLactoseFree: _isLactoseFree,
        isVegan: _isVegan,
        isVegetarian: _isVegetarian,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.95,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + keyboardSpace),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  height * 0.8, // ensures there's a minimum layout height
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _titleController,
                    maxLength: 30,
                    decoration: InputDecoration(
                      label: Text(
                        'Meal Name',
                        style: TextStyle(color: Colors.white60),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedAffordability,
                        items:
                            Affordability.values
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item.name.toUpperCase(),
                                      style: TextStyle(color: Colors.white60),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedAffordability = value;
                          });
                        },
                      ),
                      const Spacer(),
                      DropdownButton(
                        value: _selectedComplexity,
                        items:
                            Complexity.values
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item.name.toUpperCase(),
                                      style: TextStyle(color: Colors.white60),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedComplexity = value;
                          });
                        },
                      ),
                    ],
                  ),
                  TextField(
                    controller: _timeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Time',
                      hintText: "Minutes",
                    ),
                  ),
                  TextFormField(
                    controller: _imageUrlController,
                    decoration: InputDecoration(
                      label: Text("Image"),
                      hintText: "Paste the url",
                      icon: Icon(Icons.open_in_browser),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    title: const Text("Gluten-Free"),
                    value: _isGlutenFree,
                    onChanged: (newValue) {
                      setState(() {
                        _isGlutenFree = newValue;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text("Vegan"),
                    value: _isVegan,
                    onChanged: (newValue) {
                      setState(() {
                        _isVegan = newValue;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text("Vegetarian"),
                    value: _isVegetarian,
                    onChanged: (newValue) {
                      setState(() {
                        _isVegetarian = newValue;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text("Lactose-Free"),
                    value: _isLactoseFree,
                    onChanged: (newValue) {
                      setState(() {
                        _isLactoseFree = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _saveMeal();
                    },
                    child: const Text("Add Meal"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel."),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
