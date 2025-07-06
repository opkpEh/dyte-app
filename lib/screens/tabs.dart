import 'package:dyte/screens/categories.dart';
import 'package:dyte/screens/meals.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {

  int _selectedPageIndex= 0;

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex= index;
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget activePage= const CategoriesScreen();
    var activePageTitle= 'Categories';

    if (_selectedPageIndex==1){
      activePage= MealsScreen(title: 'Favorites', meals: [], categoryId: '00');
      activePageTitle= '💫';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Your Favorites"),
        ],
      ),
    );
  }
}
