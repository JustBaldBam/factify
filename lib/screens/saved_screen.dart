
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:newssports/models/category.dart';
import 'package:newssports/models/data.dart';

class SavedScreen extends StatefulWidget {
  final List<Map<String, dynamic>> savedFacts;
  final Function(String? categoryId) onCategorySelect;
  final Function(int index) onRemoveFact;

  const SavedScreen({
    super.key,
    required this.savedFacts,
    required this.onCategorySelect,
    required this.onRemoveFact,
  });

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  late List<Map<String, dynamic>> _facts;
  Map<String, dynamic>? _recentlyRemoved;
  int? _removedIndex;

  @override
  void initState() {
    super.initState();
    _facts = List.from(widget.savedFacts);
  }

  @override
  void didUpdateWidget(covariant SavedScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.savedFacts != oldWidget.savedFacts) {
      _facts = List.from(widget.savedFacts);
    }
  }

  void _removeFact(int index) {
    setState(() {
      _recentlyRemoved = _facts.removeAt(index);
      _removedIndex = index;
    });

    widget.onRemoveFact(index);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Fact removed'),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.white,
          onPressed: () {
            if (_recentlyRemoved != null && _removedIndex != null) {
              setState(() {
                _facts.insert(_removedIndex!, _recentlyRemoved!);
              });
              _recentlyRemoved = null;
              _removedIndex = null;
            }
          },
        ),
      ),
    );
  }

  Category? _getCategory(String categoryId) {
    return Category.findById(categoryId, categories);
  }

  FactItem? _getOriginalFactItem(String factText, String categoryId) {
    final List<FactItem> categoryFacts = factDataStore[categoryId] ?? [];
    try {
      return categoryFacts.firstWhere((item) => item.fact == factText);
    } catch (e) {
      return null;
    }
  }

  String _getImageUrl(String factText, String categoryId) {
    final original = _getOriginalFactItem(factText, categoryId);
    if (original != null && original.imageUrl.isNotEmpty) {
      return original.imageUrl;
    }
    final alt = original?.imageAlt ?? 'Saved Fact';
    final sanitized = alt.replaceAll(' ', '+');
    return 'https://placehold.co/600x400/F3F4F6/6366F1?text=$sanitized';
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = _facts.isEmpty;

    return Stack(
      children: [
      
        const SnowingBackground(),

        Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,

          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              automaticallyImplyLeading: false,
              flexibleSpace: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigo.withOpacity(0.3),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.bookmark_rounded,
                          color: Colors.indigo.shade600,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Saved Facts",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -0.5,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          body: isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark_border_rounded,
                          size: 110,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          'Your collection awaits',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Explore the world of facts and save the ones that spark joy.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 36),
                        ElevatedButton.icon(
                          onPressed: () => widget.onCategorySelect(null),
                          icon: const Icon(Icons.explore_rounded, size: 28),
                          label: const Text('Discover More Facts', style: TextStyle(fontSize: 17)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.indigo.shade700,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            elevation: 10,
                            shadowColor: Colors.indigo.shade300,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 80, left: 16, right: 16, bottom: 20),
                  child: ListView.separated(
                    itemCount: _facts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final factItem = _facts[index];
                      final String factText = factItem['fact'];
                      final String categoryId = factItem['categoryId'];
                      final Category? category = _getCategory(categoryId);

                      final Color accentColor = category?.color ?? Colors.grey.shade500;
                      final IconData catIcon = category?.icon ?? Icons.category;

                      final String imageUrl = _getImageUrl(factText, categoryId);

                      return AnimatedScaleOnTap(
                        child: Dismissible(
                          key: ValueKey(factText),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 32),
                            decoration: BoxDecoration(
                              color: Colors.red.shade500,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 36),
                          ),
                          confirmDismiss: (_) async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Colors.white,
                                title: const Text('Remove this gem?'),
                                content: const Text('This saved fact will be gone from your collection.'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Keep')),
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, true),
                                    style: TextButton.styleFrom(foregroundColor: Colors.red.shade600),
                                    child: const Text('Remove'),
                                  ),
                                ],
                              ),
                            );
                            return confirm ?? false;
                          },
                          onDismissed: (_) => _removeFact(index),
                          child: GestureDetector(
                            onLongPress: () => _removeFact(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: accentColor.withOpacity(0.7), width: 3),
                                boxShadow: [
                                  BoxShadow(
                                    color: accentColor.withOpacity(0.25),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.12),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    height: 180,
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Container(
                                          color: Colors.grey.shade100,
                                          child: const Center(child: CircularProgressIndicator()),
                                        );
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: accentColor.withOpacity(0.15),
                                          child: Center(
                                            child: Text(
                                              category?.name ?? 'Fact',
                                              style: TextStyle(color: accentColor, fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          factText,
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w700,
                                            height: 1.6,
                                            color: Colors.grey.shade900,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: accentColor.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(30),
                                            border: Border.all(color: accentColor.withOpacity(0.4), width: 1.5),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(catIcon, size: 20, color: accentColor),
                                              const SizedBox(width: 8),
                                              Text(
                                                category?.name ?? categoryId.toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: accentColor,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}


class SnowingBackground extends StatefulWidget {
  const SnowingBackground({super.key});

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
      animation: _snowController,
      builder: (context, child) {
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
            CustomPaint(
              painter: SnowPainter(_snowController.value),
              size: MediaQuery.of(context).size,
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


class AnimatedScaleOnTap extends StatefulWidget {
  final Widget child;
  const AnimatedScaleOnTap({super.key, required this.child});

  @override
  State<AnimatedScaleOnTap> createState() => _AnimatedScaleOnTapState();
}

class _AnimatedScaleOnTapState extends State<AnimatedScaleOnTap> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.96),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}