import 'package:flutter/material.dart';
import 'package:incendia_webpage/components/custom_drawer.dart';
import '../components/custom_navbar.dart';

class OurTeamPage extends StatelessWidget {
  const OurTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final teamMembers = [
      {
        'name': 'Isha A.',
        'role': 'Founder & Academic Lead',
        'bio': 'Drives curriculum design across CBSE, ICSE, and IB with a focus on clarity and rigor.',
      },
      {
        'name': 'Arjun M.',
        'role': 'Life Skills & Entrepreneurship Coach',
        'bio': 'Guides students on communication, critical thinking, and building real-world projects.',
      },
      {
        'name': 'Priya S.',
        'role': 'Student Success Mentor',
        'bio': 'Partners with families to personalize learning plans and track progress.',
      },
    ];

    return Scaffold(
      appBar: CustomNavbar.withAnnouncement(
        title: 'Our Team',
        showBackButton: true,
      ),
      drawer: CustomDrawer(),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 240,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF002B5B), Color(0xFF1E3A8A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.groups_rounded,
                      size: 52,
                      color: Color(0xFFFF6B00),
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Meet the Team',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Mentors, coaches, and cheerleaders for every student',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontFamily: 'Inter',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isMobile ? 16 : 20),
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 1 : 3,
                      childAspectRatio: isMobile ? 1.2 : 0.9,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: teamMembers.length,
                    itemBuilder: (context, index) {
                      final member = teamMembers[index];
                      return _TeamCard(
                        name: member['name']!,
                        role: member['role']!,
                        bio: member['bio']!,
                        isMobile: isMobile,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  _Callout(isMobile: isMobile),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamCard extends StatelessWidget {
  final String name;
  final String role;
  final String bio;
  final bool isMobile;

  const _TeamCard({
    required this.name,
    required this.role,
    required this.bio,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B00).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Color(0xFFFF6B00),
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF002B5B),
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 6),
          Text(
            role,
            style: TextStyle(
              fontSize: isMobile ? 13 : 14,
              color: const Color(0xFF4A5568),
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            bio,
            style: TextStyle(
              fontSize: isMobile ? 13 : 14,
              color: const Color(0xFF4A5568),
              height: 1.5,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

class _Callout extends StatelessWidget {
  final bool isMobile;

  const _Callout({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 18 : 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF002B5B), Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Built by educators, mentors, and parents.',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We’re here to guide every student — academically and beyond.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: isMobile ? 13 : 14,
              height: 1.5,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
