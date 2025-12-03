import 'package:flutter/material.dart';
import 'dart:async';
import '../models/mock_data.dart';
import '../widgets/christmas_hat.dart';
import '../widgets/category_card.dart';
import '../models/category.dart';

class HomeScreen extends StatefulWidget {
  final Function(String? categoryId) onCategorySelect;
  final VoidCallback onRandomFactClick;

  const HomeScreen({
    super.key,
    required this.onCategorySelect,
    required this.onRandomFactClick,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentFactIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      if (mounted) {
        setState(() {
          currentFactIndex = (currentFactIndex + 1) % dailyFacts.length;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget _buildDailyFactCarousel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daily Fun Facts',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
        ),
        const SizedBox(height: 12),
        // Fact container
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Container(
            key: ValueKey<int>(currentFactIndex), // Key drives the animation
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.indigo.shade100),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Text(
              dailyFacts[currentFactIndex],
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700, height: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Dots (Changed to Indigo)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(dailyFacts.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  currentFactIndex = index;
                });
              },
              child: Container(
                width: index == currentFactIndex ? 16 : 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: index == currentFactIndex ? Colors.indigo.shade600 : Colors.grey.shade300,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildChristmasBanner() {
    return InkWell(
      onTap: () => widget.onCategorySelect('christmas'),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFDC2626), 
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.red.shade900.withOpacity(0.5), blurRadius: 8)],
        ),
        child: Stack(
          clipBehavior: Clip.none, // Allows the hat to flow out
          children: [
            const Positioned(
              top: -32, 
              right: -10,
              child: ChristmasHat(size: 60),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Seasonal Focus:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white70)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFFDE047), size: 20), // Yellow-300
                        const SizedBox(width: 8),
                        Text(
                          'Christmas Wonders',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, shadows: [Shadow(color: Colors.black.withOpacity(0.2), blurRadius: 2)]),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => widget.onCategorySelect('christmas'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.indigo.shade900, 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 4,
                  ),
                  child: const Text('View', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCosmicBanner() {
    return InkWell(
      onTap: () => widget.onCategorySelect('space'),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.amber.shade500,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.amber.shade900.withOpacity(0.5), blurRadius: 8)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Month\'s Focus:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white70)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.rocket_launch, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Cosmic Wonders',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => widget.onCategorySelect('space'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.amber.shade900,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
              ),
              child: const Text('Explore', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb_outline, size: 24, color: Colors.indigo.shade600), 
                  const SizedBox(width: 8),
                  const Text('Factify', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              ElevatedButton(
                onPressed: widget.onRandomFactClick,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                ),
                child: const Text('Random Fact', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Greeting (Now generic)
          Text(
            'Welcome back!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.grey.shade900,
            ),
          ),
          const SizedBox(height: 20),

          // Daily Fun Facts Carousel
          _buildDailyFactCarousel(),
          const SizedBox(height: 20),

          // Featured Category Banners
          const Text(
            'Featured Content',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
          ),
          const SizedBox(height: 12),
          _buildChristmasBanner(),
          const SizedBox(height: 12),
          _buildCosmicBanner(),
          const SizedBox(height: 20),
          
          // Explore Categories Preview
          const Text(
            'Explore Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              if (index < 3) {
                return CategoryCard(
                  category: categories[index],
                  onSelect: () => widget.onCategorySelect(categories[index].id),
                );
              }
              return CategoryCard(
                category: Category(id: 'all', name: 'View All', icon: Icons.search, color: Colors.grey.shade500),
                onSelect: () => widget.onCategorySelect(null),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}