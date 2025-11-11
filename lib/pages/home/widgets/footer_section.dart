import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  final bool isMobile;

  const FooterSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 40,
        horizontal: isMobile ? 20 : 40,
      ),
      color: const Color(0xFF1A1A1A),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B00), Color(0xFFFF8533)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.menu_book, color: Colors.white),
              ),
              const SizedBox(width: 16),
              const Text(
                'Incendia',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Empowering students with comprehensive education programs.',
            style: TextStyle(color: Colors.grey[400], height: 1.6),
          ),
          const SizedBox(height: 30),
          Divider(color: Colors.grey[800]),
          const SizedBox(height: 20),
          Text(
            '© 2024 Incendia. All rights reserved.',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }
}