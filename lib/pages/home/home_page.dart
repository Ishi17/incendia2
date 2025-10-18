import 'package:flutter/material.dart';
import 'package:incendia_webpage/pages/about_page.dart';
import 'package:incendia_webpage/pages/academic.dart';
import 'package:incendia_webpage/pages/admissions_page.dart';
import 'package:incendia_webpage/pages/careers_page.dart';
import 'package:incendia_webpage/pages/contact_us_page.dart';
import 'package:incendia_webpage/pages/gallery_page.dart';
import 'package:incendia_webpage/pages/life_skills_page.dart';
import 'package:incendia_webpage/pages/schedule_page.dart';
import 'package:incendia_webpage/pages/home/widgets/hero_section.dart';
import 'package:incendia_webpage/pages/home/widgets/combined_services_offerings.dart';
import 'package:incendia_webpage/pages/home/widgets/stats_section.dart';
import 'package:incendia_webpage/pages/home/widgets/testimonials_section.dart';
import 'package:incendia_webpage/pages/home/widgets/cta_section.dart';
import 'package:incendia_webpage/pages/home/widgets/footer_section.dart';

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
                HeroSection(
                  isMobile: isMobile,
                  fadeAnimation: _fadeAnimation,
                  slideAnimation: _slideAnimation,
                  navigateTo: _navigateTo,
                ),
                CombinedServicesOfferings(isMobile: isMobile),
                StatsSection(isMobile: isMobile),
                TestimonialsSection(isMobile: isMobile),
                CtaSection(isMobile: isMobile, navigateTo: _navigateTo),
                FooterSection(isMobile: isMobile),
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
    final menuItems = [
      'About',
      'Academic',
      'Admissions',
      'Careers',
      'Life Skills',
      'Schedule',
      'Gallery',
      'Contact',
    ];

    return SliverAppBar(
      expandedHeight: 70,
      floating: true,
      pinned: true,
      backgroundColor: _isScrolled ? Colors.white : Colors.transparent,
      elevation: _isScrolled ? 4 : 0,

      // keep the hamburger on mobile, remove auto back arrows elsewhere
      automaticallyImplyLeading: false,
      leading: isMobile
          ? Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu, color: Color(0xFF002B5B)),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            )
          : null,

      // ensure the title stays on the left when collapsed (not centered)
      centerTitle: false,

      flexibleSpace: Container(
        decoration: _isScrolled
            ? BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              )
            : null,
        child: FlexibleSpaceBar(
          // <<< left padding so it’s not glued to the edge
          titlePadding: const EdgeInsetsDirectional.only(start: 20, bottom: 16),

          // <<< clickable brand → Home
          title: InkWell(
            onTap: () => _navigateTo('Home'),
            borderRadius: BorderRadius.circular(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 36,
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
                  child: const Icon(
                    Icons.menu_book,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
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
        ),
      ),

      actions: isMobile
          ? null
          : [
              Container(
                margin: const EdgeInsets.only(right: 24),
                child: Row(
                  children: menuItems
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: TextButton(
                            onPressed: () => _navigateTo(item),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              item,
                              style: const TextStyle(
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

  // Extracted to ServicesSection widget (widgets/services_section.dart)

  // Extracted to OfferingsSection widget (widgets/offerings_section.dart)

  // Extracted to StatsSection widget (widgets/stats_section.dart)

  // Extracted to TestimonialsSection widget (widgets/testimonials_section.dart)

  // Extracted to CtaSection widget (widgets/cta_section.dart)
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

