
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProfileScreen extends StatelessWidget {
  final int savedFactsCount;

  const ProfileScreen({
    super.key,
    required this.savedFactsCount,
  });

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 24),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: Colors.grey.shade900,
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.indigo.shade600, size: 26),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.grey.shade800),
        ),
        subtitle: subtitle != null
            ? Text(subtitle, style: TextStyle(color: Colors.grey.shade600))
            : null,
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                          Icons.person_rounded,
                          color: Colors.indigo.shade600,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Profile",
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

          body: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 80, left: 16, right: 16, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.indigo.shade400, Colors.indigo.shade700],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.4),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person_rounded,
                          size: 70,
                          color: Colors.indigo.shade600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Fact Explorer",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Curious mind - Knowledge seeker",
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 24),

                   
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.auto_awesome, color: Colors.amber.shade600, size: 32),
                          const SizedBox(width: 16),
                          Column(
                            children: [
                              Text(
                                "$savedFactsCount",
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.indigo.shade700,
                                ),
                              ),
                              Text(
                                savedFactsCount == 1 ? "Saved Fact" : "Saved Facts",
                                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.indigo.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.lightbulb_rounded, color: Colors.indigo.shade600, size: 32),
                          const SizedBox(height: 12),
                          Text(
                            "The Origin of Factify",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.indigo.shade800,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Born in a tiny attic during a snowy winter night, Factify started as a simple notebook of random trivia scribbled by a curious soul who couldn't sleep. "
                            "One fact led to another, and soon the notebook became an app - built to spark that same 'whoa' moment in everyone. "
                            "From late-night coding sessions fueled by coffee and wonder, it grew into this cozy collection of knowledge gems. "
                            "Now it's yours to explore. Keep the curiosity alive.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

            
                _buildSectionTitle("Preferences"),
                _buildActionTile(
                  icon: Icons.dark_mode_outlined,
                  title: "Theme Mode",
                  subtitle: "System Default",
                  onTap: () {},
                ),
                _buildActionTile(
                  icon: Icons.notifications_none,
                  title: "Notifications",
                  subtitle: "On",
                  onTap: () {},
                ),
                _buildActionTile(
                  icon: Icons.language,
                  title: "Language",
                  subtitle: "English (US)",
                  onTap: () {},
                ),

           
                _buildSectionTitle("Support & Info"),
                _buildActionTile(
                  icon: Icons.help_outline,
                  title: "Help Center",
                  onTap: () {},
                ),
                _buildActionTile(
                  icon: Icons.privacy_tip_outlined,
                  title: "Privacy Policy",
                  onTap: () {},
                ),
                _buildActionTile(
                  icon: Icons.description_outlined,
                  title: "Terms of Service",
                  onTap: () {},
                ),

                const SizedBox(height: 40),
              ],
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

    for (int i = 0; i < 80; i++) {
      final double progress = (animationValue + i / 80) % 1.0;
      final double sway = math.sin(progress * math.pi * 4 + i) * 30;
      final double x = (random.nextDouble() * size.width + sway).clamp(0.0, size.width);
      final double y = progress * size.height * 1.8 - size.height * 0.5; // Start higher for visibility
      final double radius = 2.0 + random.nextDouble() * 3.0;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
