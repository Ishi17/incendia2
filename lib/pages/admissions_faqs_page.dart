import 'package:flutter/material.dart';
import 'package:incendia_webpage/components/custom_drawer.dart';
import '../components/custom_navbar.dart';

class AdmissionsFaqsPage extends StatelessWidget {
  const AdmissionsFaqsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final faqs = const [
      {
        'question': 'Who can apply?',
        'answer': 'Students in Grades 9-12 across CBSE, ICSE, and IB boards.',
      },
      {
        'question': 'Are the courses online or offline?',
        'answer': 'We offer blended learning with live sessions and on-campus mentorship.',
      },
      {
        'question': 'Is there a fee?',
        'answer': 'Fees vary by track and duration; see Fees Structure for details.',
      },
      {
        'question': 'Do you offer trial classes?',
        'answer': 'Yes, book a free consultation to schedule a trial or campus visit.',
      },
    ];

    return Scaffold(
      appBar: CustomNavbar.withAnnouncement(
        title: 'Admissions FAQs',
        showBackButton: true,
      ),
      drawer: CustomDrawer(),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          child: Column(
            children: [
              _FaqHero(isMobile: isMobile),
              const SizedBox(height: 20),
              ...faqs.map(
                (faq) => _FaqItem(
                  question: faq['question']!,
                  answer: faq['answer']!,
                  isMobile: isMobile,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FaqHero extends StatelessWidget {
  final bool isMobile;

  const _FaqHero({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 18 : 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF002B5B), Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.question_answer_rounded, color: Color(0xFFFF6B00), size: 26),
          SizedBox(height: 10),
          Text(
            'Admissions FAQs',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Answers to the most common questions about joining Incendia.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;
  final bool isMobile;

  const _FaqItem({
    required this.question,
    required this.answer,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(isMobile ? 16 : 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF002B5B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            answer,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF4A5568),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
