import 'package:flutter/material.dart';
import 'package:incendia_webpage/components/custom_drawer.dart';
import '../components/custom_navbar.dart';

class OurValuesPage extends StatelessWidget {
  const OurValuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Scaffold(
      appBar: CustomNavbar.withAnnouncement(
        title: 'Our Values',
        showBackButton: true,
      ),
      drawer: CustomDrawer(),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 260,
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
                      Icons.star_rounded,
                      size: 56,
                      color: Color(0xFFFFB300),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Our Values',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'What we stand for at Incendia',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isMobile ? 16 : 20),
              child: _ValuesBody(isMobile: isMobile),
            ),
          ],
        ),
      ),
    );
  }
}

class _ValuesBody extends StatelessWidget {
  final bool isMobile;

  const _ValuesBody({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(isMobile ? 20 : 25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: const [
              _ValueItem('Every student is seen', Icons.visibility),
              _ValueItem('Every question matters', Icons.help_outline),
              _ValueItem('Every spark finds its flame', Icons.local_fire_department),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Container(
          padding: EdgeInsets.all(isMobile ? 20 : 25),
          decoration: BoxDecoration(
            color: const Color(0xFFFFB300).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFFFB300).withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Column(
            children: const [
              Text(
                'Trusted by parents. Loved by students.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF002B5B),
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Where marks open doors, but mindset shapes destinies.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4A5568),
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ValueItem extends StatelessWidget {
  final String text;
  final IconData icon;

  const _ValueItem(this.text, this.icon);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFFFFB300),
            size: isMobile ? 22 : 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isMobile ? 14 : 15,
                color: const Color(0xFF4A5568),
                fontFamily: 'Inter',
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
