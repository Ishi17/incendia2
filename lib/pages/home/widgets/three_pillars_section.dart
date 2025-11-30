import 'package:flutter/material.dart';

class ThreePillarsSection extends StatelessWidget {
  final bool isMobile;

  const ThreePillarsSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final pillars = [
      {
        'icon': Icons.menu_book_outlined,
        'title': 'Academic Mastery',
        'desc': 'Board-specific coaching for exceptional performance.',
      },
      {
        'icon': Icons.settings_suggest_outlined,
        'title': '12 Essential Life Skills',
        'desc': 'Practical real-world skills schools don\'t teach.',
      },
      {
        'icon': Icons.emoji_objects_outlined,
        'title': 'Entrepreneurial Thinking',
        'desc': 'Balanced development of academics and life skills.',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 24,
        vertical: isMobile ? 24 : 30,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF001A3A), Color(0xFF002B5B), Color(0xFF003366)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Our Three Pillars',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 24 : 26,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'What every Incendia learner builds with us.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.82),
              fontSize: isMobile ? 14 : 15,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 20 : 22),
          Wrap(
            spacing: isMobile ? 16 : 20,
            runSpacing: isMobile ? 16 : 20,
            alignment: WrapAlignment.center,
            children: pillars
                .map(
                  (pillar) => _PillarItem(
                    icon: pillar['icon'] as IconData,
                    title: pillar['title'] as String,
                    description: pillar['desc'] as String,
                    isMobile: isMobile,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _PillarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isMobile;

  const _PillarItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: isMobile ? 260 : 240,
        maxWidth: isMobile ? 320 : 300,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.1,
              ),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFF6B00),
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              height: 1.25,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 14,
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
