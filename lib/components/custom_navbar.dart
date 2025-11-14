import 'package:flutter/material.dart';
import '../pages/about_page.dart';
import '../pages/academic.dart';
import '../pages/life_skills_page.dart';
import '../pages/schedule_page.dart';
import '../pages/admissions_page.dart';
import '../pages/gallery_page.dart';
import '../pages/careers_page.dart';
import '../pages/contact_us_page.dart';
import '../pages/home_page.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool isTransparent;
  final bool isScrolled;

  const CustomNavbar({
    super.key,
    this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.actions,
    this.isTransparent = false,
    this.isScrolled = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    
    return AppBar(
      backgroundColor: isTransparent 
          ? (isScrolled ? Colors.white : Colors.transparent)
          : const Color(0xFF002B5B),
      foregroundColor: Colors.white,
      elevation: isTransparent ? (isScrolled ? 4 : 0) : 0,
      centerTitle: false,
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios, 
                color: Colors.white
              ),
              onPressed: onBackPressed ?? () => Navigator.pop(context),
            )
          : null,
      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 18 : isTablet ? 20 : 22,
                fontWeight: FontWeight.w600,
              ),
            )
          : _buildBrandLogo(context, isMobile, isTablet, isDesktop),
      actions: actions ?? _buildDefaultActions(context, isMobile, isTablet, isDesktop),
    );
  }

  Widget _buildBrandLogo(BuildContext context, bool isMobile, bool isTablet, bool isDesktop) {
    return InkWell(
      onTap: () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      ),
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isMobile ? 32 : isTablet ? 36 : 40,
            height: isMobile ? 32 : isTablet ? 36 : 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6B00), Color(0xFFFF8533)],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF6B00).withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              Icons.menu_book, 
              color: Colors.white, 
              size: isMobile ? 18 : isTablet ? 20 : 22
            ),
          ),
          SizedBox(width: isMobile ? 8 : isTablet ? 12 : 16),
          Text(
            'Incendia',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 20 : isTablet ? 24 : 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDefaultActions(BuildContext context, bool isMobile, bool isTablet, bool isDesktop) {
    if (isMobile) {
      return [
        Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu, 
              color: Colors.white
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ];
    }

    final menuItems = [
      'Home',
      'About',
      'Academic',
      'Admissions',
      'Careers',
      'Life Skills',
      'Schedule',
      'Gallery',
      'Contact'
    ];

    return [
      Container(
        margin: EdgeInsets.only(right: isDesktop ? 32 : 24),
        child: Row(
          children: menuItems.map(
            (item) => Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 4 : 2),
              child: TextButton(
                onPressed: () => _navigateTo(context, item),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 20 : 16, 
                    vertical: isDesktop ? 10 : 8
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: isDesktop ? 16 : isTablet ? 15 : 14,
                  ),
                ),
              ),
            ),
          ).toList(),
        ),
      ),
    ];
  }

  void _navigateTo(BuildContext context, String pageName) {
    Widget page;
    switch (pageName.toLowerCase()) {
      case 'home':
        page = const HomePage();
        break;
      case 'about':
        page = const AboutUsPage();
        break;
      case 'academic':
        page = const AcademicPage();
        break;
      case 'life skills':
        page = const LifeSkillsPage();
        break;
      case 'schedule':
        page = const SchedulePage();
        break;
      case 'admissions':
        page = const AdmissionsPage();
        break;
      case 'gallery':
        page = const GalleryPage();
        break;
      case 'careers':
        page = const CareersPage();
        break;
      case 'contact':
        page = const ContactUsPage();
        break;
      default:
        return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
