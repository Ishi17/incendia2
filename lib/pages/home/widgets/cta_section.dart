import 'package:flutter/material.dart';

class CtaSection extends StatelessWidget {
  final bool isMobile;
  final void Function(String route) navigateTo;
  final VoidCallback? onConsultationPressed;

  const CtaSection({
    super.key,
    required this.isMobile,
    required this.navigateTo,
    this.onConsultationPressed,
  });

  @override
  Widget build(BuildContext context) {
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
            'Ready to Begin Your Journey?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Join thousands of students who have transformed their academic performance.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.9),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Center(
            child: _GradientActionButton(
              text: 'Book your free consultation',
              onPressed: onConsultationPressed ?? () => navigateTo('Admissions'),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _GradientActionButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFB300), Color(0xFFFFD54F)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFB300).withOpacity(0.4),
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
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (text.toLowerCase().contains('consultation')) ...[
              const Icon(Icons.phone, color: Colors.white, size: 18),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OutlineActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _OutlineActionButton({required this.text, required this.onPressed});

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
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}