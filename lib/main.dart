
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

import 'models/models.dart';
import 'services/api_service.dart';

import 'screens/home_screen.dart';
import 'screens/category_screen.dart';
import 'screens/ai_screen.dart';
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

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  static const _emptyCategories = <Category>[];
  static const _emptyFacts = <String, List<FactItem>>{};
  static const _emptyDailyFacts = <String>[];

  final ApiService _apiService = ApiService();
  AppTab _activeTab = AppTab.home;
  String? _currentCategoryId;
  final List<Map<String, dynamic>> _savedFacts = [];
  List<Category> _categories = const <Category>[];
  Map<String, List<FactItem>> _factDataStore =
      const <String, List<FactItem>>{};
  List<String> _dailyFacts = const <String>[];
  bool _isLoading = true;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _loadError = null;
    });

    try {
      final data = await _apiService.fetchInitialData();
      if (!mounted) return;

      setState(() {
        _categories = data.categories;
        _factDataStore = data.factDataStore;
        _dailyFacts = data.dailyFacts;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _categories = _emptyCategories;
        _factDataStore = _emptyFacts;
        _dailyFacts = _emptyDailyFacts;
        _currentCategoryId = null;
        _activeTab = AppTab.home;
        _loadError = error.toString();
        _isLoading = false;
      });
    }
  }

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
    if (_factDataStore.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backend data is unavailable right now.')),
      );
      return;
    }

    final randomFactData = getRandomFactFromStore(_factDataStore);
    showDialog(
      context: context,
      builder: (ctx) => RandomFactModal(
        fact: randomFactData,
        onClose: () => Navigator.of(ctx).pop(),
      ),
    );
  }

  Widget _screen() {
    if (_isLoading) {
      return const _LoadingScreen();
    }

    if (_loadError != null &&
        _activeTab != AppTab.ai &&
        _activeTab != AppTab.profile) {
      return _ErrorScreen(
        message: _loadError!,
        onRetry: _loadData,
      );
    }

    if (_activeTab == AppTab.search && _currentCategoryId != null) {
      return FactListScreen(
        categoryId: _currentCategoryId!,
        categories: _categories,
        factDataStore: _factDataStore,
        onBackToCategories: () => setState(() => _currentCategoryId = null),
        onSaveFact: _saveFact,
      );
    }

    return switch (_activeTab) {
      AppTab.home => HomeScreen(
          categories: _categories,
          dailyFacts: _dailyFacts,
          onCategorySelect: _selectCategory,
          onRandomFactClick: _showRandomFact,
        ),
      AppTab.search => CategoryScreen(
          categories: _categories,
          onCategorySelect: _selectCategory,
        ),
      AppTab.ai => AiScreen(apiService: _apiService),
      AppTab.saved => SavedScreen(
          savedFacts: _savedFacts,
          categories: _categories,
          factDataStore: _factDataStore,
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
        onTap: _isLoading ? null : (i) => _setTab(AppTab.values[i]),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo.shade600,
        unselectedItemColor: Colors.grey.shade600,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy_outlined), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading facts from the backend...'),
          ],
        ),
      ),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;

  const _ErrorScreen({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, size: 64, color: Colors.redAccent),
              const SizedBox(height: 16),
              const Text(
                'Could not reach the Factify backend.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
