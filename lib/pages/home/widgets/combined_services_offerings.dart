import 'package:flutter/material.dart';

class CombinedServicesOfferings extends StatelessWidget {
  final bool isMobile;

  const CombinedServicesOfferings({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final allItems = [
      // Services
      {
        'icon': Icons.person,
        'title': 'Personalized Learning',
        'desc': 'Tailored curriculum for individual needs',
        'category': 'Service',
        'color': const Color(0xFFFF6B00),
      },
      {
        'icon': Icons.people,
        'title': 'Expert Mentorship',
        'desc': 'Guidance from experienced educators',
        'category': 'Service',
        'color': const Color(0xFFFF6B00),
      },
      {
        'icon': Icons.computer,
        'title': 'Modern Technology',
        'desc': 'Cutting-edge learning tools',
        'category': 'Service',
        'color': const Color(0xFFFF6B00),
      },
      // Offerings
      {
        'icon': Icons.book,
        'title': 'Academic Mastery',
        'desc': 'Board-wise curriculum',
        'category': 'Program',
        'color': const Color(0xFF4CAF50),
      },
      {
        'icon': Icons.psychology,
        'title': 'Life Skills',
        'desc': 'Critical thinking & communication',
        'category': 'Program',
        'color': const Color(0xFF2196F3),
      },
      {
        'icon': Icons.schedule,
        'title': 'Flexible Schedule',
        'desc': 'Convenient timings',
        'category': 'Program',
        'color': const Color(0xFF9C27B0),
      },
      {
        'icon': Icons.groups,
        'title': 'Small Classes',
        'desc': 'Personalized attention',
        'category': 'Program',
        'color': const Color(0xFFFF6B00),
      },
      {
        'icon': Icons.assessment,
        'title': 'Progress Tracking',
        'desc': 'Regular assessments & feedback',
        'category': 'Service',
        'color': const Color(0xFFE91E63),
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 20 : 40,
      ),
      color: const Color(0xFFF8F9FA),
      child: Column(
        children: [
          const Text(
            'Our Services & Programs',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Color(0xFF002B5B),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Comprehensive educational solutions designed for your success',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF666666),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.0,
            ),
            itemCount: allItems.length,
            itemBuilder: (context, index) {
              return _CombinedCard(item: allItems[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _CombinedCard extends StatefulWidget {
  final Map<String, dynamic> item;

  const _CombinedCard({required this.item});

  @override
  State<_CombinedCard> createState() => _CombinedCardState();
}

class _CombinedCardState extends State<_CombinedCard>
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

  void _showItemDialog() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Service detail',
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: _ItemDialog(item: widget.item),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curvedAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.08),
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.9, end: 1.0).animate(curvedAnimation),
              child: child,
            ),
          ),
        );
      },
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
            onTap: _showItemDialog,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: (widget.item['color'] as Color).withOpacity(0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (widget.item['color'] as Color).withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (widget.item['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.item['icon'] as IconData,
                      color: widget.item['color'] as Color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.item['title'] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF002B5B),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.item['category'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: (widget.item['color'] as Color),
                      fontWeight: FontWeight.w600,
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

class _ItemDialog extends StatelessWidget {
  final Map<String, dynamic> item;

  const _ItemDialog({required this.item});

  @override
  Widget build(BuildContext context) {
    // Get detailed content for each item
    String getDetailedContent(String title) {
      switch (title) {
        case 'Personalized Learning':
          return 'Our personalized learning approach ensures that every student receives individual attention and a curriculum tailored to their unique learning style, pace, and academic goals. We assess each student\'s strengths and areas for improvement to create a customized learning path that maximizes their potential.';
        case 'Expert Mentorship':
          return 'Our experienced educators provide one-on-one mentorship and guidance, helping students navigate their academic journey with confidence. Our mentors are not just teachers but academic coaches who inspire, motivate, and guide students toward achieving their educational aspirations.';
        case 'Modern Technology':
          return 'We leverage cutting-edge educational technology and digital tools to enhance the learning experience. From interactive learning platforms to AI-powered assessments, our modern approach ensures students are prepared for the digital future while maintaining the human touch in education.';
        case 'Academic Mastery':
          return 'Our comprehensive academic programs cover all major educational boards including CBSE, ICSE, and State boards. We provide structured learning paths with regular assessments, mock tests, and personalized feedback to ensure academic excellence and board exam success.';
        case 'Life Skills':
          return 'Beyond academics, we focus on developing essential life skills including critical thinking, communication, leadership, and emotional intelligence. These skills prepare students for real-world challenges and help them become well-rounded individuals ready for future success.';
        case 'Flexible Schedule':
          return 'We understand that every student has different learning patterns and commitments. Our flexible scheduling system allows students to choose convenient timings that fit their lifestyle, ensuring optimal learning without compromising on other important activities.';
        case 'Small Classes':
          return 'We maintain small class sizes to ensure personalized attention for every student. This approach allows our educators to focus on individual learning needs, provide immediate feedback, and create a supportive learning environment where every student can thrive.';
        case 'Progress Tracking':
          return 'Our comprehensive progress tracking system monitors each student\'s academic journey with detailed analytics and regular assessments. We provide real-time feedback, performance reports, and personalized recommendations to ensure continuous improvement and academic success.';
        default:
          return item['desc'] as String;
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
            colors: [Colors.white, Color(0xFFF8F9FA)],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: (item['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: item['color'] as Color,
                size: 35,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              item['title'] as String,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF002B5B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: (item['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item['category'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: item['color'] as Color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              getDetailedContent(item['title'] as String),
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF666666),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: item['color'] as Color,
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
