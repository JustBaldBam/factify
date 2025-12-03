// lib/main.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newssports/models/mock_data.dart';

import 'models/models.dart'; // Brings in mock_data.dart → AppTab, categories, etc.

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
  AppTab _activeTab = AppTab.home; // Initial active tab is Home
  String? _currentCategoryId; // Used for navigating from search/home to fact list
  List<Map<String, dynamic>> _savedFacts = []; // Simple list for saved facts
  // Simulated authentication data
  String? _userId = 'user_abc123';
  bool _isAuthReady = true;

  // --- 2. LOGIC FUNCTIONS ---

  void _setTab(AppTab tab) {
    setState(() {
      _activeTab = tab;
      // Reset category view when changing tabs unless it's a specific category view
      if (tab != AppTab.search) {
        _currentCategoryId = null;
      }
    });
  }

  void _selectCategory(String? categoryId) {
    if (categoryId == 'all' || categoryId == null) {
      // If 'View All' is selected or a null is passed, go to the main search/category screen
      setState(() {
        _activeTab = AppTab.search;
        _currentCategoryId = null;
      });
    } else {
      // If a specific category is selected, navigate to the fact list screen
      setState(() {
        _activeTab = AppTab.search; // Keep the search tab active for the back button
        _currentCategoryId = categoryId;
      });
    }
  }

  // NOTE: In a real app, this would check if the fact is already saved before adding it.
  void _saveFact(String fact, String categoryId) {
    final factData = {'fact': fact, 'categoryId': categoryId};
    if (!_savedFacts.any((item) => item['fact'] == fact)) {
      setState(() {
        _savedFacts.add(factData);
      });
      if (kDebugMode) {
        print('Fact Saved: $factData');
      }
    } else if (kDebugMode) {
      print('Fact already saved: $factData');
    }
  }

  // --- 3. RANDOM FACT MODAL ---
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

  // --- 4. SCREEN SWITCHING ---
  Widget _screen() {
    // If we are on the Search tab AND a category is selected, show the FactListScreen
    if (_activeTab == AppTab.search && _currentCategoryId != null) {
      return FactListScreen(
        categoryId: _currentCategoryId!,
        onBackToCategories: () => setState(() => _currentCategoryId = null),
      );
    }

    // Otherwise, switch between the main tabs
    return switch (_activeTab) {
      AppTab.home => HomeScreen(onCategorySelect: _selectCategory, onRandomFactClick: _showRandomFact),
      AppTab.search => CategoryScreen(categories: categories, onCategorySelect: _selectCategory),
      AppTab.saved => SavedScreen(savedFacts: _savedFacts, onCategorySelect: _selectCategory),
      AppTab.profile => ProfileScreen(userId: _userId, isAuthReady: _isAuthReady),
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
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}