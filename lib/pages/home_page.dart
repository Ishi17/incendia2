import 'package:flutter/material.dart';
import 'package:incendia_webpage/pages/about_page.dart';
import 'package:incendia_webpage/pages/academic.dart';
import 'package:incendia_webpage/pages/admissions_page.dart';
import 'package:incendia_webpage/pages/careers_page.dart';
import 'package:incendia_webpage/pages/contact_us_page.dart';
import 'package:incendia_webpage/pages/gallery_page.dart';
import 'package:incendia_webpage/pages/life_skills_page.dart';
import 'package:incendia_webpage/pages/schedule_page.dart';

// Main HomePage
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  late AnimationController _heroAnimationController;
  late AnimationController _cardAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _heroAnimationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _cardAnimationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heroAnimationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.2), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _heroAnimationController,
            curve: Curves.easeOut,
          ),
        );

    _heroAnimationController.forward();

    _scrollController.addListener(() {
      setState(() => _isScrolled = _scrollController.offset > 50);

      if (_scrollController.offset > 150 &&
          !_cardAnimationController.isCompleted) {
        _cardAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _heroAnimationController.dispose();
    _cardAnimationController.dispose();
    super.dispose();
  }

  bool get isMobile => MediaQuery.of(context).size.width < 768;

  void _navigateTo(String pageName) {
    Widget page;
    switch (pageName.toLowerCase()) {
      case 'home':
        return; // Already on home page
      case 'about':
        page = AboutUsPage();
        break;
      case 'academic':
        page = AcademicPage();
        break;
      case 'life skills':
        page = LifeSkillsPage();
        break;
      case 'schedule':
        page = SchedulePage();
        break;
      case 'admissions':
        page = AdmissionsPage();
        break;
      case 'gallery':
        page = GalleryPage();
        break;
      case 'careers':
        page = CareersPage();
        break;
      case 'contact':
        page = ContactUsPage();
        break;
      default:
        return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: isMobile ? _buildDrawer() : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildHeroSection(),
                _buildServicesSection(),
                _buildOfferingsSection(),
                _buildStatsSection(),
                _buildTestimonialsSection(),
                _buildCtaSection(),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    final menuItems = [
      {'name': 'Home', 'icon': Icons.home},
      {'name': 'About', 'icon': Icons.info_outline},
      {'name': 'Academic', 'icon': Icons.school},
      {'name': 'Life Skills', 'icon': Icons.psychology},
      {'name': 'Schedule', 'icon': Icons.schedule},
      {'name': 'Admissions', 'icon': Icons.how_to_reg},
      {'name': 'Gallery', 'icon': Icons.photo_library},
      {'name': 'Careers', 'icon': Icons.work},
      {'name': 'Contact', 'icon': Icons.contact_phone},
    ];

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
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
                padding: EdgeInsets.all(24),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFF6B00), Color(0xFFFF8533)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFFF6B00).withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.menu_book,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: menuItems
                        .map(
                          (item) => Container(
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.shade50,
                            ),
                            child: ListTile(
                              leading: Icon(
                                item['icon'] as IconData,
                                color: Color(0xFFFF6B00),
                                size: 24,
                              ),
                              title: Text(
                                item['name'] as String,
                                style: TextStyle(
                                  color: Color(0xFF002B5B),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Color(0xFFFF6B00),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                _navigateTo(item['name'] as String);
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

  Widget _buildAppBar() {
    final menuItems = ['About', 'Academic', 'Admissions','Careers','Life Skills', 'Schedule', 'Gallery', 'Contact'];

    return SliverAppBar(
      expandedHeight: 70,
      floating: true,
      pinned: true,
      backgroundColor: _isScrolled ? Colors.white : Colors.transparent,
      elevation: _isScrolled ? 4 : 0,
      leading: isMobile ? null : SizedBox.shrink(),
      flexibleSpace: Container(
        decoration: _isScrolled
            ? BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              )
            : null,
        child: FlexibleSpaceBar(
          title: Padding(
            padding: EdgeInsets.only(left: isMobile ? 60 : 24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF6B00), Color(0xFFFF8533)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFFF6B00).withOpacity(0.3),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(Icons.menu_book, color: Colors.white, size: 20),
                ),
                SizedBox(width: 12),
                Text(
                  'Incendia',
                  style: TextStyle(
                    color: Color(0xFF002B5B),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          titlePadding: EdgeInsets.only(bottom: 16),
        ),
      ),
      actions: isMobile
          ? null
          : [
              Container(
                margin: EdgeInsets.only(right: 24),
                child: Row(
                  children: menuItems
                      .map(
                        (item) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: TextButton(
                            onPressed: () => _navigateTo(item),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              item,
                              style: TextStyle(
                                color: Color(0xFF002B5B),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: isMobile ? 550 : 650,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF002B5B), Color(0xFF004080), Color(0xFF0056B3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.white.withOpacity(0.1), Colors.transparent],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
              child: AnimatedBuilder(
                animation: _fadeAnimation,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Empowering Students\nfor Academic Excellence',
                            style: TextStyle(
                              fontSize: isMobile ? 28 : 48,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Comprehensive education programs combining academic mastery with essential life skills.',
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 32),
                          Wrap(
                            spacing: 16,
                            runSpacing: 12,
                            children: [
                              _buildGradientButton(
                                'Start Your Journey',
                                () => _navigateTo('Admissions'),
                              ),
                              _buildOutlineButton(
                                'Learn More',
                                () => _navigateTo('About'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientButton(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF6B00), Color(0xFFFF8533)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFF6B00).withOpacity(0.4),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButton(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide.none,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildServicesSection() {
    final services = [
      {
        'icon': Icons.person,
        'title': 'Personalized Learning',
        'desc': 'Tailored curriculum for individual needs',
      },
      {
        'icon': Icons.people,
        'title': 'Expert Mentorship',
        'desc': 'Guidance from experienced educators',
      },
      {
        'icon': Icons.computer,
        'title': 'Modern Technology',
        'desc': 'Cutting-edge learning tools',
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 50,
        horizontal: isMobile ? 20 : 40,
      ),
      color: Color(0xFFF8F9FA),
      child: Column(
        children: [
          Text(
            'Our Educational Services',
            style: TextStyle(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w800,
              color: Color(0xFF002B5B),
            ),
          ),
          SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: services
                    .map(
                      (service) => Container(
                        width: isMobile
                            ? constraints.maxWidth
                            : (constraints.maxWidth - 48) / 3,
                        child: _buildServiceCard(service),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF6B00), Color(0xFFFF8533)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(service['icon'], color: Colors.white, size: 30),
          ),
          SizedBox(height: 16),
          Text(
            service['title'],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF002B5B),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            service['desc'],
            style: TextStyle(
              color: Color(0xFF666666),
              height: 1.5,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOfferingsSection() {
    final offerings = [
      {
        'icon': Icons.book,
        'title': 'Academic Mastery',
        'desc': 'Board-wise curriculum',
        'color': Color(0xFF4CAF50),
      },
      {
        'icon': Icons.psychology,
        'title': 'Life Skills',
        'desc': 'Critical thinking & communication',
        'color': Color(0xFF2196F3),
      },
      {
        'icon': Icons.schedule,
        'title': 'Flexible Schedule',
        'desc': 'Convenient timings',
        'color': Color(0xFF9C27B0),
      },
      {
        'icon': Icons.groups,
        'title': 'Small Classes',
        'desc': 'Personalized attention',
        'color': Color(0xFFFF6B00),
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 20 : 40,
      ),
      child: Column(
        children: [
          Text(
            'Our Programs',
            style: TextStyle(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w800,
              color: Color(0xFF002B5B),
            ),
          ),
          SizedBox(height: 40),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 1 : 2,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 1.3,
            children: offerings
                .map(
                  (item) => Container(
                    padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: (item['color'] as Color).withOpacity(0.1),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (item['color'] as Color).withOpacity(0.1),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: (item['color'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            size: 36,
                            color: item['color'] as Color,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          item['title'] as String,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF002B5B),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12),
                        Text(
                          item['desc'] as String,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF666666),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    final stats = [
      {'number': '10K+', 'label': 'Students Enrolled'},
      {'number': '95%', 'label': 'Success Rate'},
      {'number': '50+', 'label': 'Expert Teachers'},
      {'number': '15+', 'label': 'Years Experience'},
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 20 : 40,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF002B5B), Color(0xFF004080)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Our Achievement',
            style: TextStyle(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 40),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 2 : 4,
            children: stats
                .map(
                  (stat) => Column(
                    children: [
                      Text(
                        stat['number']!,
                        style: TextStyle(
                          fontSize: isMobile ? 36 : 44,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFFF6B00),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        stat['label']!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialsSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 20 : 40,
      ),
      color: Color(0xFFF8F9FA),
      child: Column(
        children: [
          Text(
            'What Parents Say',
            style: TextStyle(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w800,
              color: Color(0xFF002B5B),
            ),
          ),
          SizedBox(height: 40),
          Container(
            constraints: BoxConstraints(maxWidth: 800),
            padding: EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFF6B00).withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) =>
                        Icon(Icons.star, color: Color(0xFFFF6B00), size: 28),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  '"Incendia has transformed my child\'s learning experience. The personalized approach and dedicated teachers have helped unlock her true potential."',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF002B5B),
                    height: 1.6,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                Text(
                  '— Sarah Johnson, Parent',
                  style: TextStyle(
                    color: Color(0xFFFF6B00),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCtaSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 20 : 40,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF002B5B), Color(0xFF004080)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Ready to Begin Your Journey?',
            style: TextStyle(
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Join thousands of students who have transformed their academic performance.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.9),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _buildGradientButton(
                'Apply Now',
                () => _navigateTo('Admissions'),
              ),
              _buildOutlineButton('Contact Us', () => _navigateTo('Contact')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 40,
        horizontal: isMobile ? 20 : 40,
      ),
      color: Color(0xFF1A1A1A),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF6B00), Color(0xFFFF8533)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.menu_book, color: Colors.white),
              ),
              SizedBox(width: 16),
              Text(
                'Incendia',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Empowering students with comprehensive education programs.',
            style: TextStyle(color: Colors.grey[400], height: 1.6),
          ),
          SizedBox(height: 30),
          Divider(color: Colors.grey[800]),
          SizedBox(height: 20),
          Text(
            '© 2024 Incendia. All rights reserved.',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    IconData icon,
    String title,
    String info,
    String subtitle,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xFFFF6B00).withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF6B00), Color(0xFFFF8533)],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF002B5B),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  info,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF666666),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFFF6B00),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// // About Page
// class AboutPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('About Incendia', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: Color(0xFF002B5B),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Color(0xFF002B5B), Color(0xFF004080)]),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Icon(Icons.school, size: 60, color: Color(0xFFFF6B00)),
//                   SizedBox(height: 20),
//                   Text(
//                     'About Incendia',
//                     style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Transforming Education Since 2009',
//                     style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.8)),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             _buildSection('Our Mission', 
//               'To empower every student with comprehensive education that combines academic excellence with essential life skills, preparing them for future success in an ever-evolving world.'),
//             _buildSection('Our Vision', 
//               'To be the leading educational institution that transforms learning experiences through innovative teaching methods, personalized attention, and holistic development.'),
//             _buildSection('Our Values', '''
// • Excellence in Education
// • Personalized Learning Approach
// • Innovation in Teaching Methods
// • Character Development
// • Community Engagement
// • Lifelong Learning'''),
//             SizedBox(height: 20),
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(25),
//               decoration: BoxDecoration(
//                 color: Color(0xFFF8F9FA),
//                 borderRadius: BorderRadius.circular(15),
//                 border: Border.all(color: Color(0xFFFF6B00).withOpacity(0.2)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Why Choose Incendia?',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF002B5B)),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     '✓ 15+ years of educational excellence\n✓ 10,000+ successful students\n✓ 95% success rate in board examinations\n✓ Expert faculty with proven track record\n✓ Modern infrastructure and technology\n✓ Personalized attention for every student\n✓ Comprehensive life skills development\n✓ Strong parent-teacher collaboration',
//                     style: TextStyle(fontSize: 16, color: Color(0xFF666666), height: 1.8),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSection(String title, String content) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 25),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF002B5B)),
//           ),
//           SizedBox(height: 10),
//           Text(
//             content,
//             style: TextStyle(fontSize: 16, color: Color(0xFF666666), height: 1.6),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Academic Page
// class AcademicPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Academic Programs', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: Color(0xFF002B5B),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Color(0xFF002B5B), Color(0xFF004080)]),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Icon(Icons.book, size: 60, color: Color(0xFFFF6B00)),
//                   SizedBox(height: 20),
//                   Text(
//                     'Academic Excellence',
//                     style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             _buildAcademicCard('CBSE Curriculum', 'Classes 6-12', 
//               'Comprehensive CBSE curriculum with focus on conceptual learning and board exam preparation.'),
//             _buildAcademicCard('ICSE Curriculum', 'Classes 6-12', 
//               'Detailed ICSE syllabus coverage with emphasis on language skills and analytical thinking.'),
//             _buildAcademicCard('State Board', 'Classes 6-12', 
//               'State board preparation with local language support and cultural integration.'),
//             _buildAcademicCard('Competitive Exams', 'JEE/NEET/Others', 
//               'Specialized coaching for engineering and medical entrance examinations.'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAcademicCard(String title, String subtitle, String description) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20),
//       padding: EdgeInsets.all(25),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Color(0xFFFF6B00).withOpacity(0.2)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFFF6B00).withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(Icons.school, color: Color(0xFFFF6B00), size: 28),
//               ),
//               SizedBox(width: 15),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF002B5B)),
//                     ),
//                     Text(
//                       subtitle,
//                       style: TextStyle(fontSize: 16, color: Color(0xFFFF6B00), fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 15),
//           Text(
//             description,
//             style: TextStyle(fontSize: 16, color: Color(0xFF666666), height: 1.5),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Life Skills Page
// class LifeSkillsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Life Skills', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: Color(0xFF002B5B),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Color(0xFF002B5B), Color(0xFF004080)]),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Icon(Icons.psychology, size: 60, color: Color(0xFFFF6B00)),
//                   SizedBox(height: 20),
//                   Text(
//                     'Life Skills Development',
//                     style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             _buildSkillCard('Communication Skills', Icons.chat_bubble_outline, 
//               'Develop effective verbal and written communication abilities for personal and professional success.'),
//             _buildSkillCard('Critical Thinking', Icons.lightbulb_outline, 
//               'Enhance analytical and problem-solving skills to make informed decisions.'),
//             _buildSkillCard('Leadership', Icons.person_outline, 
//               'Build leadership qualities and learn to inspire and motivate others.'),
//             _buildSkillCard('Time Management', Icons.schedule, 
//               'Master the art of managing time effectively and prioritizing tasks.'),
//             _buildSkillCard('Emotional Intelligence', Icons.favorite_outline, 
//               'Develop self-awareness and empathy to build better relationships.'),
//             _buildSkillCard('Digital Literacy', Icons.computer, 
//               'Stay updated with technology and digital tools for modern learning.'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSkillCard(String title, IconData icon, String description) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20),
//       padding: EdgeInsets.all(25),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Color(0xFFFF6B00).withOpacity(0.2)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [Color(0xFFFF6B00), Color(0xFFFF8533)]),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Icon(icon, color: Colors.white, size: 30),
//           ),
//           SizedBox(width: 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF002B5B)),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   description,
//                   style: TextStyle(fontSize: 14, color: Color(0xFF666666), height: 1.5),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Schedule Page
// class SchedulePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Schedule', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: Color(0xFF002B5B),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Color(0xFF002B5B), Color(0xFF004080)]),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Icon(Icons.schedule, size: 60, color: Color(0xFFFF6B00)),
//                   SizedBox(height: 20),
//                   Text(
//                     'Class Schedule',
//                     style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             _buildScheduleCard('Morning Batch', '8:00 AM - 12:00 PM', 
//               'Perfect for early risers with fresh minds ready to learn.'),
//             _buildScheduleCard('Afternoon Batch', '1:00 PM - 5:00 PM', 
//               'Ideal timing for students comfortable with afternoon sessions.'),
//             _buildScheduleCard('Evening Batch', '6:00 PM - 9:00 PM', 
//               'Convenient for working students and after school hours.'),
//             _buildScheduleCard('Weekend Classes', 'Saturday & Sunday', 
//               'Special weekend batches for comprehensive revision and practice.'),
//             Container(
//               margin: EdgeInsets.only(top: 20),
//               padding: EdgeInsets.all(25),
//               decoration: BoxDecoration(
//                 color: Color(0xFFF8F9FA),
//                 borderRadius: BorderRadius.circular(15),
//                 border: Border.all(color: Color(0xFFFF6B00).withOpacity(0.2)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Additional Information',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF002B5B)),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     '• Flexible batch timings available\n• Small class sizes for personalized attention\n• Make-up classes for missed sessions\n• Online and offline options available',
//                     style: TextStyle(fontSize: 16, color: Color(0xFF666666), height: 1.6),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildScheduleCard(String title, String time, String description) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20),
//       padding: EdgeInsets.all(25),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Color(0xFFFF6B00).withOpacity(0.2)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: [Color(0xFFFF6B00), Color(0xFFFF8533)]),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(Icons.access_time, color: Colors.white, size: 28),
//               ),
//               SizedBox(width: 15),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF002B5B)),
//                     ),
//                     Text(
//                       time,
//                       style: TextStyle(fontSize: 16, color: Color(0xFFFF6B00), fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 15),
//           Text(
//             description,
//             style: TextStyle(fontSize: 16, color: Color(0xFF666666), height: 1.5),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Admissions Page
// class AdmissionsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admissions', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: Color(0xFF002B5B),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Color(0xFF002B5B), Color(0xFF004080)]),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Icon(Icons.how_to_reg, size: 60, color: Color(0xFFFF6B00)),
//                   SizedBox(height: 20),
//                   Text(
//                     'Admissions Open',
//                     style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Join the Incendia Family Today!',
//                     style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.8)),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             _buildAdmissionCard('Step 1', 'Fill Application Form', 
//               'Complete our online application form with student details and academic history.'),
//             _buildAdmissionCard('Step 2', 'Document Submission', 
//               'Submit required documents including previous academic records and ID proof.'),
//             _buildAdmissionCard('Step 3', 'Assessment Test', 
//               'Appear for a simple assessment test to determine the appropriate learning level.'),
//             _buildAdmissionCard('Step 4', 'Counseling Session', 
//               'Meet with our counselors to discuss goals and choose the right program.'),
//             _buildAdmissionCard('Step 5', 'Fee Payment', 
//               'Complete the admission process with fee payment and receive confirmation.'),
//             Container(
//               margin: EdgeInsets.only(top: 20),
//               padding: EdgeInsets.all(25),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Color(0xFFFF6B00), Color(0xFFFF8533)]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Column(
//                 children: [
//                   Text(
//                     'Ready to Start?',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Contact us today for admission assistance',
//                     style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9)),
//                   ),
//                   SizedBox(height: 15),
//                   ElevatedButton(
//                     onPressed: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Admission form will open soon!')),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//                     ),
//                     child: Text(
//                       'Apply Now',
//                       style: TextStyle(color: Color(0xFF002B5B), fontWeight: FontWeight.bold, fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAdmissionCard(String step, String title, String description) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20),
//       padding: EdgeInsets.all(25),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Color(0xFFFF6B00).withOpacity(0.2)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [Color(0xFFFF6B00), Color(0xFFFF8533)]),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Center(
//               child: Text(
//                 step.split(' ')[1],
//                 style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           SizedBox(width: 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF002B5B)),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   description,
//                   style: TextStyle(fontSize: 14, color: Color(0xFF666666), height: 1.5),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


