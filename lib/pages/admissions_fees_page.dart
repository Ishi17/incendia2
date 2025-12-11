import 'package:flutter/material.dart';
import 'package:incendia_webpage/components/custom_drawer.dart';
import '../components/custom_navbar.dart';

class AdmissionsFeesPage extends StatelessWidget {
  const AdmissionsFeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final rows = const [
      {'program': 'Board Prep (CBSE/ICSE)', 'duration': '3 months', 'fee': '₹18,000'},
      {'program': 'IB Support', 'duration': '3 months', 'fee': '₹24,000'},
      {'program': 'Life Skills + Entrepreneurship', 'duration': '6 weeks', 'fee': '₹9,500'},
      {'program': 'Full Pathway (Academics + Skills)', 'duration': '6 months', 'fee': '₹42,000'},
    ];

    return Scaffold(
      appBar: CustomNavbar.withAnnouncement(
        title: 'Fees Structure',
        showBackButton: true,
      ),
      drawer: CustomDrawer(),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          child: Column(
            children: [
              _FeesHero(isMobile: isMobile),
              const SizedBox(height: 20),
              _FeesTable(rows: rows, isMobile: isMobile),
              const SizedBox(height: 16),
              _NoteCard(isMobile: isMobile),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeesHero extends StatelessWidget {
  final bool isMobile;

  const _FeesHero({required this.isMobile});

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
          Icon(Icons.receipt_long, color: Color(0xFFFFB300), size: 26),
          SizedBox(height: 10),
          Text(
            'Fees Structure',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Transparent pricing across all learning pathways.',
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

class _FeesTable extends StatelessWidget {
  final List<Map<String, String>> rows;
  final bool isMobile;

  const _FeesTable({required this.rows, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12 : 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF0E2440),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: const [
                Expanded(
                  flex: 2,
                  child: Text('Program', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
                Expanded(
                  child: Text('Duration', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: Text('Fee', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          ...rows.map(
            (row) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 16,
                vertical: 12,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      row['program']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row['duration']!,
                      style: const TextStyle(color: Color(0xFF4A5568)),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row['fee']!,
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final bool isMobile;

  const _NoteCard({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFE0B3)),
      ),
      child: const Text(
        'Need help picking a track? Book a free consultation to get a personalized fees breakdown.',
        style: TextStyle(
          color: Color(0xFF7C2D12),
          fontSize: 14,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
