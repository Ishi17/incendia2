import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  final bool isMobile;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final void Function(String route) navigateTo;

  const HeroSection({
    super.key,
    required this.isMobile,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? 650 : 750,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF001A3A), Color(0xFF002B5B), Color(0xFF003366)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Professional floating elements - positioned at edges on mobile with minimal margin, no overlap
          _buildFloatingElement(
            top: isMobile ? 40 : 80,
            right: isMobile ? 0 : 60,
            size: isMobile ? 50 : 100,
            icon: Icons.school_outlined,
            color: Colors.amber,
            delay: 0,
          ),
          // Science/lab icon - hidden on mobile
          if (!isMobile)
            _buildFloatingElement(
              top: 200,
              left: 40,
              size: 80,
              icon: Icons.science_outlined,
              color: Colors.lightBlue,
              delay: 800,
            ),
          _buildFloatingElement(
            top: isMobile ? 60 : 80,
            left: isMobile ? 0 : 50,
            size: isMobile ? 48 : 90,
            icon: Icons.menu_book_outlined,
            color: Colors.greenAccent,
            delay: 1600,
          ),
          _buildFloatingElement(
            bottom: isMobile ? 120 : 120,
            right: isMobile ? 1 : 100,
            size: isMobile ? 52 : 110,
            icon: Icons.biotech_outlined,
            color: Colors.purpleAccent,
            delay: 2400,
          ),
          _buildFloatingElement(
            top: isMobile ? 220 : 180,
            right: isMobile ? 0 : 60,
            size: isMobile ? 46 : 85,
            icon: Icons.history_edu_outlined,
            color: Colors.orangeAccent,
            delay: 3200,
          ),
          _buildFloatingElement(
            top: isMobile ? 340 : 180,
            left: isMobile ? 0 : 120,
            size: isMobile ? 44 : 95,
            icon: Icons.architecture_outlined,
            color: Colors.pinkAccent,
            delay: 4000,
          ),

          // Background decorative elements - positioned at edges on mobile with minimal margin
          Positioned(
            top: isMobile ? -60 : -100,
            right: isMobile ? -40 : -100,
            child: Container(
              width: isMobile ? 140 : 300,
              height: isMobile ? 140 : 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.white.withOpacity(0.08), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            top: isMobile ? 200 : 200,
            left: isMobile ? -30 : -80,
            child: Container(
              width: isMobile ? 100 : 200,
              height: isMobile ? 100 : 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.white.withOpacity(0.06), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: isMobile ? -20 : -80,
            right: isMobile ? -10 : 150,
            child: Container(
              width: isMobile ? 90 : 180,
              height: isMobile ? 90 : 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.white.withOpacity(0.05), Colors.transparent],
                ),
              ),
            ),
          ),

          // Main content - with extra padding on mobile to avoid circles
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 40,
                vertical: isMobile ? 20 : 0,
              ),
              child: AnimatedBuilder(
                animation: fadeAnimation,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: fadeAnimation,
                    child: SlideTransition(
                      position: slideAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Main heading
                          Text(
                            'Empowering Students\nfor Academic Excellence',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1.2,
                              fontSize: isMobile ? 24 : 28,
                            ),
                          ),
                          SizedBox(height: isMobile ? 16 : 20),

                          // Subtitle
                          Text(
                            'Comprehensive education programs combining academic mastery with essential life skills.',
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 18,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: isMobile ? 30 : 40),

                          // Action buttons
                          Wrap(
                            spacing: isMobile ? 12 : 16,
                            runSpacing: isMobile ? 12 : 12,
                            alignment: WrapAlignment.center,
                            children: [
                              _GradientActionButton(
                                text: 'Start Your Journey',
                                onPressed: () => navigateTo('Admissions'),
                                isMobile: isMobile,
                              ),
                              _OutlineActionButton(
                                text: 'Learn More',
                                onPressed: () => navigateTo('About'),
                                isMobile: isMobile,
                              ),
                            ],
                          ),
                          SizedBox(height: isMobile ? 30 : 40),

                          // Student images and stats
                          _buildStudentShowcase(isMobile: isMobile),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingElement({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required IconData icon,
    required int delay,
    Color? color,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 2000 + delay),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: Opacity(
              opacity: value,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      (color ?? Colors.white).withOpacity(0.2),
                      (color ?? Colors.white).withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(size / 2),
                  border: Border.all(
                    color: (color ?? Colors.white).withOpacity(0.4),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (color ?? Colors.white).withOpacity(0.15),
                      blurRadius: 25,
                      spreadRadius: 3,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: size * 0.4,
                    color: color ?? Colors.white.withOpacity(0.9),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStudentShowcase({bool isMobile = false}) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1500),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: EdgeInsets.all(isMobile ? 16 : 24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withOpacity(0.25),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Professional student representation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAnimatedStudentAvatar(Icons.person, 'Alex', 0, isMobile),
                      SizedBox(width: isMobile ? 8 : 12),
                      _buildAnimatedStudentAvatar(Icons.person, 'Sarah', 200, isMobile),
                      SizedBox(width: isMobile ? 8 : 12),
                      _buildAnimatedStudentAvatar(Icons.person, 'Mike', 400, isMobile),
                      if (!isMobile) ...[
                        const SizedBox(width: 12),
                        _buildAnimatedStudentAvatar(Icons.person, 'Emma', 600, isMobile),
                        const SizedBox(width: 12),
                        _buildAnimatedStudentAvatar(Icons.person, 'David', 800, isMobile),
                      ],
                    ],
                  ),
                  SizedBox(height: isMobile ? 16 : 20),

                  // Success stats with animation
                  isMobile
                      ? Column(
                          children: [
                            _buildAnimatedStatItem('10K+', 'Students', 0, isMobile),
                            const SizedBox(height: 12),
                            _buildAnimatedStatItem('95%', 'Success Rate', 300, isMobile),
                            const SizedBox(height: 12),
                            _buildAnimatedStatItem('50+', 'Expert Teachers', 600, isMobile),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildAnimatedStatItem('10K+', 'Students', 0, isMobile),
                            _buildAnimatedStatItem('95%', 'Success Rate', 300, isMobile),
                            _buildAnimatedStatItem('50+', 'Expert Teachers', 600, isMobile),
                          ],
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedStudentAvatar(IconData icon, String name, int delay, bool isMobile) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 800 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: Opacity(
              opacity: value,
              child: Container(
                width: isMobile ? 45 : 55,
                height: isMobile ? 45 : 55,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(isMobile ? 22.5 : 27.5),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: Colors.white.withOpacity(0.9),
                    size: isMobile ? 22 : 28,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedStatItem(String number, String label, int delay, bool isMobile) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 1000 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 15 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Column(
              children: [
                Text(
                  number,
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFFF6B00),
                  ),
                ),
                SizedBox(height: isMobile ? 4 : 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: isMobile ? 11 : 13,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GradientActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isMobile;

  const _GradientActionButton({
    required this.text,
    required this.onPressed,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B00), Color(0xFFFF8533)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B00).withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 14 : 16,
            horizontal: isMobile ? 24 : 32,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: isMobile ? 14 : 16,
          ),
        ),
      ),
    );
  }
}

class _OutlineActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isMobile;

  const _OutlineActionButton({
    required this.text,
    required this.onPressed,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 14 : 16,
            horizontal: isMobile ? 24 : 32,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: isMobile ? 14 : 16,
          ),
        ),
      ),
    );
  }
}