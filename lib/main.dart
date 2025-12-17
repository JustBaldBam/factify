
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newssports/models/data.dart';

import 'models/models.dart';

import 'screens/home_screen.dart';
import 'screens/category_screen.dart';
import 'screens/fact_list_screen.dart';
import 'screens/saved_screen.dart';
import 'screens/profile_screen.dart';
import 'widgets/random_fact_modal.dart';

void main() {
  runApp(const FactifyApp());
}

class FactifyApp extends StatelessWidget {
  const FactifyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Factify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Nunito Sans',
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  AppTab _activeTab = AppTab.home;
  String? _currentCategoryId;
  List<Map<String, dynamic>> _savedFacts = [];

  void _setTab(AppTab tab) {
    setState(() {
      _activeTab = tab;
      if (tab != AppTab.search) {
        _currentCategoryId = null;
      }
    });
  }

  void _selectCategory(String? categoryId) {
    if (categoryId == 'all' || categoryId == null) {
      setState(() {
        _activeTab = AppTab.search;
        _currentCategoryId = null;
      });
    } else {
      setState(() {
        _activeTab = AppTab.search;
        _currentCategoryId = categoryId;
      });
    }
  }

  void _saveFact(String fact, String categoryId) {
    final factData = {'fact': fact, 'categoryId': categoryId};
    if (!_savedFacts.any((item) => item['fact'] == fact)) {
      setState(() {
        _savedFacts.add(factData);
      });
      if (kDebugMode) print('Fact saved: $fact');
    } else {
      if (kDebugMode) print('Already saved');
    }
  }

  void _removeFact(int index) {
    setState(() {
      _savedFacts.removeAt(index);
    });
  }

  void _showRandomFact() {
    final randomFactData = getRandomFactFromStore();
    showDialog(
      context: context,
      builder: (ctx) => RandomFactModal(
        fact: randomFactData,
        onClose: () => Navigator.of(ctx).pop(),
      ),
    );
  }

  Widget _screen() {
    if (_activeTab == AppTab.search && _currentCategoryId != null) {
      return FactListScreen(
        categoryId: _currentCategoryId!,
        onBackToCategories: () => setState(() => _currentCategoryId = null),
        onSaveFact: _saveFact,
      );
    }

    return switch (_activeTab) {
      AppTab.home => HomeScreen(
          onCategorySelect: _selectCategory,
          onRandomFactClick: _showRandomFact,
        ),
      AppTab.search => CategoryScreen(
          categories: categories,
          onCategorySelect: _selectCategory,
        ),
      AppTab.saved => SavedScreen(
          savedFacts: _savedFacts,
          onCategorySelect: _selectCategory,
          onRemoveFact: _removeFact,
        ),
      AppTab.profile => ProfileScreen(
          savedFactsCount: _savedFacts.length, 
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _activeTab.index,
        onTap: (i) => _setTab(AppTab.values[i]),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo.shade600,
        unselectedItemColor: Colors.grey.shade600,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}