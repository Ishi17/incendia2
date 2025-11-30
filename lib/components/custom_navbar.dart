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
import '../pages/home_page.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool isTransparent;
  final bool isScrolled;
  final VoidCallback? onConsultationPressed;

  static final ValueNotifier<bool> _showAnnouncement = ValueNotifier<bool>(true);

  static PreferredSizeWidget withAnnouncement({
    String? title,
    bool showBackButton = false,
    VoidCallback? onBackPressed,
    List<Widget>? actions,
    bool isTransparent = false,
    bool isScrolled = false,
    VoidCallback? onConsultationPressed,
  }) {
    return CustomNavbar(
      title: title,
      showBackButton: showBackButton,
      onBackPressed: onBackPressed,
      actions: actions,
      isTransparent: isTransparent,
      isScrolled: isScrolled,
      onConsultationPressed: onConsultationPressed,
    );
  }

  const CustomNavbar({
    super.key,
    this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.actions,
    this.isTransparent = false,
    this.isScrolled = false,
    this.onConsultationPressed,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (_showAnnouncement.value ? 76 : 0));

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    final isDesktop = MediaQuery.of(context).size.width >= 1024;

    return ValueListenableBuilder<bool>(
      valueListenable: _showAnnouncement,
      builder: (context, showAnnouncement, _) {
        final navBar = AppBar(
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
                    color: Colors.white,
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

        if (!showAnnouncement) return navBar;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AnnouncementBar(
              isMobile: isMobile,
              onAction: onConsultationPressed ??
                  () => _navigateTo(context, 'home'),
              onClose: () => _showAnnouncement.value = false,
            ),
            navBar,
          ],
        );
      },
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
      'Academic',
      'Join our Team',
      'Life Skills',
      'Schedule',
      'Gallery',
      'Contact'
    ];

    return [
      Container(
        margin: EdgeInsets.only(right: isDesktop ? 32 : 24),
        child: Row(
          children: [
            _buildAboutDropdown(context, isDesktop, isTablet),
            _buildAdmissionsDropdown(context, isDesktop, isTablet),
            ...menuItems.map(
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
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildAboutDropdown(BuildContext context, bool isDesktop, bool isTablet) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: isDesktop ? 16 : isTablet ? 15 : 14,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 4 : 2),
      child: PopupMenuButton<String>(
        onSelected: (value) => _navigateTo(context, value),
        color: Colors.white,
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'Our Stories',
            child: Text('Our Stories'),
          ),
          const PopupMenuItem(
            value: 'Our Values',
            child: Text('Our Values'),
          ),
          const PopupMenuItem(
            value: 'Our Team',
            child: Text('Our Team'),
          ),
        ],
        child: Row(
          children: [
            Text('About', style: textStyle),
            const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildAdmissionsDropdown(BuildContext context, bool isDesktop, bool isTablet) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: isDesktop ? 16 : isTablet ? 15 : 14,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 4 : 2),
      child: PopupMenuButton<String>(
        onSelected: (value) => _navigateTo(context, value),
        color: Colors.white,
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        itemBuilder: (context) => const [
          PopupMenuItem(
            value: 'How to Apply',
            child: Text('How to Apply'),
          ),
          PopupMenuItem(
            value: 'Fees Structure',
            child: Text('Fees Structure'),
          ),
          PopupMenuItem(
            value: 'Admissions FAQs',
            child: Text('FAQs'),
          ),
        ],
        child: Row(
          children: [
            Text('Admissions', style: textStyle),
            const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String pageName) {
    Widget page;
    switch (pageName.toLowerCase()) {
      case 'home':
        page = const HomePage();
        break;
      case 'about':
      case 'our stories':
        page = const AboutUsPage();
        break;
      case 'our values':
        page = const OurValuesPage();
        break;
      case 'our team':
        page = const OurTeamPage();
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
      case 'how to apply':
        page = const AdmissionsPage();
        break;
      case 'fees structure':
        page = const AdmissionsFeesPage();
        break;
      case 'admissions faqs':
      case 'faqs':
        page = const AdmissionsFaqsPage();
        break;
      case 'gallery':
        page = const GalleryPage();
        break;
      case 'careers':
      case 'join our team':
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

class _AnnouncementBar extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onAction;
  final VoidCallback onClose;

  const _AnnouncementBar({
    required this.isMobile,
    required this.onAction,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF0C1B33),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 20,
                vertical: isMobile ? 10 : 12,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final bool useShortText =
                      constraints.maxWidth < 720 || isMobile;
                  final String message = useShortText
                      ? 'Book a FREE consultation this week'
                      : 'Book a FREE consultation this week - get clear, personalized guidance for your child’s learning journey.';

                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          message,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: isMobile ? 16 : 18,
                            color: Colors.white,
                            letterSpacing: 0.1,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: isMobile ? 10 : 14),
                      ElevatedButton(
                        onPressed: onAction,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B00),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 16 : 22,
                            vertical: isMobile ? 12 : 13,
                          ),
                          minimumSize: Size(isMobile ? 0 : 170, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: isMobile ? 14 : 15,
                            letterSpacing: 0.2,
                          ),
                          elevation: 2,
                        ),
                        child: const Text('Book a Free Consultation'),
                      ),
                      IconButton(
                        onPressed: onClose,
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 22,
                          color: Colors.white70,
                        ),
                        splashRadius: 20,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
