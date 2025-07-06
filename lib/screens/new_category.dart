import 'package:dyte/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:dyte/models/category.dart';

class NewCategory extends StatefulWidget {
  const NewCategory({super.key, required this.onAddCategory});

  final void Function(Category category) onAddCategory;

  @override
  State<NewCategory> createState() {
    return _NewCategory();
  }
}

class _NewCategory extends State<NewCategory> {
  final Color _selectedColor = const Color.fromARGB(255, 65, 255, 7);

  final _titleController = TextEditingController();

  void _saveCategory() {
    if (_titleController.text.trim().isEmpty) {
      return;
    }

    final lastId = availableCategories.last.id;
    final lastNumber = int.tryParse(lastId.replaceAll('c', '')) ?? 0;
    final nextIndex = 'c${lastNumber + 1}';

    widget.onAddCategory(
      Category(
        id: nextIndex,
        title: _titleController.text,
        color: _selectedColor,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: InputDecoration(
                  label: Text(
                    'Category Name',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'),
                  ),
                  ElevatedButton(onPressed: _saveCategory, child: Text("Save")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
