import 'package:flutter/material.dart';
import '../pages/about_page.dart';
import '../pages/about_values_page.dart';
import '../pages/about_team_page.dart';
import '../pages/academic.dart';
import '../pages/life_skills_page.dart';
import '../pages/schedule_page.dart';
import '../pages/admissions_page.dart';
import '../pages/admissions_fees_page.dart';
import '../pages/admissions_faqs_page.dart';
import '../pages/gallery_page.dart';
import '../pages/careers_page.dart';
import '../pages/contact_us_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final homeItem = {'name': 'Home', 'icon': Icons.home, 'route': '/'};
    final otherItems = [
      {'name': 'Academic', 'icon': Icons.school, 'page': const AcademicPage()},
      {'name': 'Life Skills', 'icon': Icons.psychology, 'page': const LifeSkillsPage()},
      {'name': 'Schedule', 'icon': Icons.schedule, 'page': const SchedulePage()},
      {'name': 'Gallery', 'icon': Icons.photo_library, 'page': const GalleryPage()},
      {'name': 'Join our Team', 'icon': Icons.work, 'page': const CareersPage()},
      {'name': 'Contact', 'icon': Icons.contact_phone, 'page': const ContactUsPage()},
    ];

    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1F2937), Color(0xFF374151)],
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
                          colors: [Color(0xFF0EA5E9), Color(0xFFFFD54F)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0EA5E9).withOpacity(0.3),
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
                    children: [
                      _buildNavTile(context, homeItem),
                      const SizedBox(height: 8),
                      _buildExpansionTile(
                        context,
                        title: 'About',
                        icon: Icons.info_outline,
                        children: const [
                          {'name': 'Our Stories', 'page': AboutUsPage()},
                          {'name': 'Our Values', 'page': OurValuesPage()},
                          {'name': 'Our Team', 'page': OurTeamPage()},
                        ],
                      ),
                      _buildExpansionTile(
                        context,
                        title: 'Admissions',
                        icon: Icons.how_to_reg,
                        children: const [
                          {'name': 'How to Apply', 'page': AdmissionsPage()},
                          {'name': 'Fees Structure', 'page': AdmissionsFeesPage()},
                          {'name': 'Admissions FAQs', 'page': AdmissionsFaqsPage()},
                        ],
                      ),
                      ...otherItems.map((item) => _buildNavTile(context, item)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Map<String, Object>> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(
            icon,
            color: const Color(0xFF0EA5E9),
            size: 24,
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          children: children.map(
            (item) {
              return ListTile(
                title: Text(
                  item['name'] as String,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  final page = item['page'];
                  if (page != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => page as Widget,
                      ),
                    );
                  }
                },
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

Widget _buildNavTile(BuildContext context, Map<String, Object?> item) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.grey.shade50,
    ),
    child: ListTile(
      leading: Icon(
        item['icon'] as IconData,
        color: const Color(0xFF0EA5E9),
        size: 24,
      ),
      title: Text(
        item['name'] as String,
        style: const TextStyle(
          color: Color(0xFF1F2937),
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Color(0xFF0EA5E9),
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
  );
}
