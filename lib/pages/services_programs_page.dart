import 'package:flutter/material.dart';
import 'package:incendia_webpage/pages/home/widgets/combined_services_offerings.dart';
import 'package:incendia_webpage/components/custom_navbar.dart';
import 'package:incendia_webpage/components/custom_drawer.dart';

class ServicesProgramsPage extends StatelessWidget {
  const ServicesProgramsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Scaffold(
      appBar: CustomNavbar(isScrolled: false),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section - Full Width
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 60,
                horizontal: isMobile ? 20 : 40,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF001A3A), Color(0xFF002B5B), Color(0xFF003366)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Our Services & Programs',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Comprehensive educational solutions designed for your success',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Services & Programs Section
            CombinedServicesOfferings(isMobile: isMobile),
          ],
        ),
      ),
    );
  }
}

