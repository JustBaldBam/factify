
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import '../widgets/christmas_hat.dart';
import '../widgets/category_card.dart';
import 'package:newssports/models/models.dart';

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
  final ScrollController _scrollController = ScrollController();

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
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildDailyFactCarousel() {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Fun Facts',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
          ),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
            child: Container(
              key: ValueKey<int>(currentFactIndex),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.indigo.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Text(
                dailyFacts[currentFactIndex],
                style: TextStyle(fontSize: 17, color: Colors.grey.shade800, height: 1.6),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(dailyFacts.length, (index) {
              return GestureDetector(
                onTap: () => setState(() => currentFactIndex = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: index == currentFactIndex ? 20 : 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: index == currentFactIndex ? Colors.indigo.shade600 : Colors.grey.shade300,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  
  Widget _buildChristmasBanner() {
    return InkWell(
      onTap: () => widget.onCategorySelect('christmas'),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFFDC2626),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.red.shade900.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const Positioned(
              top: -40,
              right: -10,
              child: ChristmasHat(size: 80),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seasonal Magic',
                  style: TextStyle(fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  'Christmas Wonders',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => widget.onCategorySelect('christmas'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red.shade800,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text('Dive In', style: TextStyle(fontWeight: FontWeight.bold)),
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
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade900, Colors.indigo.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.shade900.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Spotlight',
              style: TextStyle(fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.rocket_launch, color: Colors.white, size: 32),
                const SizedBox(width: 12),
                Text(
                  'Cosmic Wonders',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => widget.onCategorySelect('space'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text('Explore Space', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
 
        SnowingBackground(scrollController: _scrollController),

        SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.indigo.withOpacity(0.3), blurRadius: 20)],
                        ),
                        child: Icon(Icons.lightbulb_rounded, size: 38, color: Colors.indigo.shade600),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Factify',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.grey.shade900),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: widget.onRandomFactClick,
                    icon: const Icon(Icons.auto_awesome, size: 20),
                    label: const Text('Random Fact'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 8,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Text(
                'Welcome back!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.grey.shade900),
              ),
              const SizedBox(height: 32),

              _buildDailyFactCarousel(),
              const SizedBox(height: 32),

              const Text(
                'Featured Content',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
              ),
              const SizedBox(height: 16),
              _buildChristmasBanner(),
              const SizedBox(height: 20),
              _buildCosmicBanner(),
              const SizedBox(height: 32),

              const Text(
                'Explore Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1F2937)),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
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
                    category: Category(id: 'all', name: 'View All', icon: Icons.apps, color: Colors.indigo.shade600),
                    onSelect: () => widget.onCategorySelect(null),
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}


class SnowingBackground extends StatefulWidget {
  final ScrollController scrollController;
  const SnowingBackground({super.key, required this.scrollController});

  @override
  State<SnowingBackground> createState() => _SnowingBackgroundState();
}

class _SnowingBackgroundState extends State<SnowingBackground> with TickerProviderStateMixin {
  late AnimationController _snowController;

  @override
  void initState() {
    super.initState();
    _snowController = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
  }

  @override
  void dispose() {
    _snowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.scrollController,
      builder: (context, child) {
        final offset = widget.scrollController.hasClients ? widget.scrollController.offset / 4 : 0.0;
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.indigo.shade100, Colors.white],
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, offset),
              child: AnimatedBuilder(
                animation: _snowController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: SnowPainter(_snowController.value),
                    size: MediaQuery.of(context).size,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class SnowPainter extends CustomPainter {
  final double animationValue;
  SnowPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.9);
    final random = math.Random(999);

    for (int i = 0; i < 60; i++) {
      final double progress = (animationValue + i / 60) % 1.0;
      final x = (random.nextDouble() * size.width + progress * 40 * math.sin(progress * 10)) % size.width;
      final y = progress * size.height * 1.5;
      final radius = 1.5 + random.nextDouble() * 2.0;
      canvas.drawCircle(Offset(x, y - size.height), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}