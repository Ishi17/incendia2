import 'package:flutter/material.dart';

class OfferingsSection extends StatelessWidget {
  final bool isMobile;

  const OfferingsSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final offerings = [
      {
        'icon': Icons.book,
        'title': 'Academic Mastery',
        'desc': 'Board-wise curriculum',
        'color': const Color(0xFF4CAF50),
      },
      {
        'icon': Icons.psychology,
        'title': 'Life Skills',
        'desc': 'Critical thinking & communication',
        'color': const Color(0xFF2196F3),
      },
      {
        'icon': Icons.schedule,
        'title': 'Flexible Schedule',
        'desc': 'Convenient timings',
        'color': const Color(0xFF9C27B0),
      },
      {
        'icon': Icons.groups,
        'title': 'Small Classes',
        'desc': 'Personalized attention',
        'color': const Color(0xFFFF6B00),
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 20 : 40,
      ),
      child: Column(
        children: [
          const Text(
            'Our Programs',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF002B5B),
            ),
          ),
          const SizedBox(height: 40),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 1 : 2,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 1.3,
            children: offerings
                .map(
                  (item) => Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: (item['color'] as Color).withOpacity(0.1),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (item['color'] as Color).withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: (item['color'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            size: 36,
                            color: item['color'] as Color,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          item['title'] as String,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF002B5B),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item['desc'] as String,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF666666),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}