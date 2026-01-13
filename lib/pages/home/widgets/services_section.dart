import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
  final bool isMobile;

  const ServicesSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        'icon': Icons.person,
        'title': 'Personalized Learning',33
        'desc': 'Tailored curriculum for individual needs',
      },
      {
        'icon': Icons.people,
        'title': 'Expert Mentorship',
        'desc': 'Guidance from experienced educators',
      },
      {
        'icon': Icons.computer,
        'title': 'Modern Technology',
        'desc': 'Cutting-edge learning tools',
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 50,
        horizontal: isMobile ? 20 : 40,
      ),
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: [
          const Text(
            'Our Educational Services',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFF002B5B),
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: services
                    .map(
                      (service) => SizedBox(
                        width: isMobile
                            ? constraints.maxWidth
                            : (constraints.maxWidth - 48) / 3,
                        child: _ServiceCard(service: service),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final Map<String, dynamic> service;

  const _ServiceCard({required this.service});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showServiceDialog() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ServiceDialog(service: widget.service),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: InkWell(
            onTap: _showServiceDialog,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFB300), Color(0xFFFFD54F)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      widget.service['icon'] as IconData,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.service['title'] as String,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF002B5B),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.service['desc'] as String,
                    style: const TextStyle(
                      color: Color(0xFF666666),
                      height: 1.5,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ServiceDialog extends StatelessWidget {
  final Map<String, dynamic> service;

  const _ServiceDialog({required this.service});

  @override
  Widget build(BuildContext context) {
    // Get detailed content for each service
    String getDetailedContent(String title) {
      switch (title) {
        case 'Personalized Learning':
          return 'Our personalized learning approach ensures that every student receives individual attention and a curriculum tailored to their unique learning style, pace, and academic goals. We assess each student\'s strengths and areas for improvement to create a customized learning path that maximizes their potential.';
        case 'Expert Mentorship':
          return 'Our experienced educators provide one-on-one mentorship and guidance, helping students navigate their academic journey with confidence. Our mentors are not just teachers but academic coaches who inspire, motivate, and guide students toward achieving their educational aspirations.';
        case 'Modern Technology':
          return 'We leverage cutting-edge educational technology and digital tools to enhance the learning experience. From interactive learning platforms to AI-powered assessments, our modern approach ensures students are prepared for the digital future while maintaining the human touch in education.';
        default:
          return service['desc'] as String;
      }
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 20,
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Color(0xFFFFFFFF)],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFB300), Color(0xFFFFD54F)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                service['icon'] as IconData,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              service['title'] as String,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF002B5B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              getDetailedContent(service['title'] as String),
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF666666),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF59E0B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Got it!',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
