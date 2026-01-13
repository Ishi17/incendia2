import 'package:flutter/material.dart';

class TrustResultsSection extends StatelessWidget {
  final bool isMobile;

  const TrustResultsSection({
    Key? key,
    this.isMobile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 40,
        vertical: isMobile ? 32 : 48,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            'Trusted by 500+ Parents in Bangalore',
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF001A3A),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 16 : 24),
          isMobile
              ? Column(
                  children: [
                    _ResultCard(
                      number: '92%',
                      label: 'Students improved\nby ≥10% in 6 months',
                      icon: Icons.trending_up,
                    ),
                    const SizedBox(height: 16),
                    _ResultCard(
                      number: '87%',
                      label: 'of students report\nhigher confidence',
                      icon: Icons.star,
                    ),
                    const SizedBox(height: 16),
                    _ResultCard(
                      number: '50+',
                      label: 'Expert faculty with\naverage 12+ yrs exp',
                      icon: Icons.person_4,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ResultCard(
                      number: '92%',
                      label: 'Students improved\nby ≥10% in 6 months',
                      icon: Icons.trending_up,
                    ),
                    _ResultCard(
                      number: '87%',
                      label: 'of students report\nhigher confidence',
                      icon: Icons.star,
                    ),
                    _ResultCard(
                      number: '50+',
                      label: 'Expert faculty with\naverage 12+ yrs exp',
                      icon: Icons.person_4,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String number;
  final String label;
  final IconData icon;

  const _ResultCard({
    required this.number,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF1F3A6F).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF1F3A6F),
            size: 28,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          number,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1F3A6F),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 120,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF5E6475),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
