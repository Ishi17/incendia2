import 'package:flutter/material.dart';

class StatsSection extends StatelessWidget {
  final bool isMobile;

  const StatsSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> stats = [
      {'number': '10K+', 'label': 'Students Enrolled'},
      {'number': '95%', 'label': 'Success Rate'},
      {'number': '50+', 'label': 'Expert Teachers'},
      {'number': '15+', 'label': 'Years Experience'},
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 20 : 40,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF002B5B), Color(0xFF004080)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Our Achievement',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 2 : 4,
            children: stats
                .map(
                  (stat) => Column(
                    children: [
                      Text(
                        stat['number']!,
                        style: TextStyle(
                          fontSize: isMobile ? 36 : 44,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFFFF6B00),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        stat['label']!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
