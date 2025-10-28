import 'package:flutter/material.dart';
import '../pages/about_page.dart';
import '../pages/academic.dart';
import '../pages/life_skills_page.dart';
import '../pages/schedule_page.dart';
import '../pages/admissions_page.dart';
import '../pages/gallery_page.dart';
import '../pages/careers_page.dart';
import '../pages/contact_us_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'name': 'Home', 'icon': Icons.home, 'route': '/'},
      {'name': 'About', 'icon': Icons.info_outline, 'page': const AboutUsPage()},
      {'name': 'Academic', 'icon': Icons.school, 'page': const AcademicPage()},
      {'name': 'Life Skills', 'icon': Icons.psychology, 'page': const LifeSkillsPage()},
      {'name': 'Schedule', 'icon': Icons.schedule, 'page': const SchedulePage()},
      {'name': 'Admissions', 'icon': Icons.how_to_reg, 'page': const AdmissionsPage()},
      {'name': 'Gallery', 'icon': Icons.photo_library, 'page': const GalleryPage()},
      {'name': 'Careers', 'icon': Icons.work, 'page': const CareersPage()},
      {'name': 'Contact', 'icon': Icons.contact_phone, 'page': const ContactUsPage()},
    ];

    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF002B5B), Color(0xFF004080)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6B00), Color(0xFFFF8533)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF6B00).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.menu_book,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Incendia',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: menuItems
                        .map(
                          (item) => Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.shade50,
                            ),
                            child: ListTile(
                              leading: Icon(
                                item['icon'] as IconData,
                                color: const Color(0xFFFF6B00),
                                size: 24,
                              ),
                              title: Text(
                                item['name'] as String,
                                style: const TextStyle(
                                  color: Color(0xFF002B5B),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Color(0xFFFF6B00),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                if (item['route'] != null) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    item['route'] as String,
                                    (route) => false,
                                  );
                                } else if (item['page'] != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => item['page'] as Widget,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




