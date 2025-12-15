import 'dart:async';
import 'package:flutter/material.dart';
import 'package:incendia_webpage/components/custom_drawer.dart';
import '../components/custom_navbar.dart';
import 'home/widgets/combined_services_offerings.dart';
 

class AcademicPage extends StatefulWidget {
  const AcademicPage({super.key});

  @override
  State<AcademicPage> createState() => _AcademicPageState();
}

class _AcademicPageState extends State<AcademicPage> {
  late final PageController _carouselController;
  int _currentIndex = 0;
  Timer? _autoScrollTimer;
  final List<Map<String, dynamic>> curriculums = [
    {
      'name': 'CBSE',
      'desc':
          'The Central Board of Secondary Education (CBSE) is a national level board that emphasizes analytical thinking, structured learning, and a solid foundation for competitive exams like JEE and NEET. It encourages theoretical clarity and a disciplined approach to academics.',
      'image': 'assets/images/cbse.png',
      'bgColor': Color(0xFFFDF3E7),
      'highlights': ['Analytical Focus', 'JEE-ready'],
    },
    {
      'name': 'ICSE',
      'desc':
          'The Indian Certificate of Secondary Education (ICSE) is known for its comprehensive syllabus that balances sciences, mathematics, humanities, and languages. It places special focus on English proficiency, creative expression, and a well-rounded academic experience.',
      'image': 'assets/images/icse.png',
      'bgColor': Color(0xFFE8F2FF),
      'highlights': ['Strong English', 'Balanced Curriculum'],
    },
    {
      'name': 'IB',
      'desc':
          'The International Baccalaureate (IB) program fosters global citizenship, critical thinking, and interdisciplinary inquiry. With internal assessments, extended essays, and real-world learning, IB prepares students for international universities and leadership roles.',
      'image': 'assets/images/ib.png',
      'bgColor': Color(0xFFEFFAF1),
      'highlights': ['Global Perspective', 'Inquiry-led'],
    },
    {
      'name': 'State Boards',
      'desc':
          'State Boards tailor education to regional contexts, languages, and cultures while covering the required academic subjects. They offer flexibility and localized relevance, making them accessible and practical for students across diverse socio-economic backgrounds.',
      'image': 'assets/images/state.png',
      'bgColor': Color(0xFFF3E8FF),
      'highlights': ['Regional Relevance', 'Flexible'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _carouselController = PageController(viewportFraction: 0.50);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _carouselController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      final nextIndex = (_currentIndex + 1) % curriculums.length;
      _goToIndex(nextIndex);
    });
  }

  void _goTo(int delta) {
    final next = (_currentIndex + delta).clamp(0, curriculums.length - 1);
    if (next == _currentIndex) return;
    _goToIndex(next);
  }

  void _goToIndex(int index) {
    if (!mounted) return;
    _carouselController.animateToPage(
      index,
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Scaffold(
      appBar: CustomNavbar.withAnnouncement(
          title: 'Academics', showBackButton: true),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(),
            _buildGradesCaptionBox(),
            _buildCurriculumCarousel(),
            CombinedServicesOfferings(isMobile: isMobile),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // --- Sections ---

  Widget _buildHeaderSection() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : isTablet ? 50 : 60, 
        horizontal: isMobile ? 16 : 24
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF002B5B), Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.school,
            size: isMobile ? 50 : isTablet ? 60 : 70,
            color: Color(0xFFFFB300),
          ),
          SizedBox(height: isMobile ? 15 : 20),
          Text(
            'Academics',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 32 : isTablet ? 36 : 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: isMobile ? 8 : 10),
          Text(
            'Empowering students with academic mastery, real-world relevance, and confidence.',
            style: TextStyle(
              fontSize: isMobile ? 14 : isTablet ? 15 : 16,
              color: Colors.white.withOpacity(0.9),
              fontFamily: 'Inter',
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGradesCaptionBox() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 16 : isTablet ? 18 : 20, 
        horizontal: isMobile ? 16 : 24
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.grade,
                color: Color(0xFFFFB300),
                size: isMobile ? 20 : 24,
              ),
              SizedBox(width: 8),
              Text(
                'Grades 9–12',
                style: TextStyle(
                  fontSize: isMobile ? 20 : isTablet ? 22 : 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF002B5B),
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(height: isMobile ? 8 : 10),
          Text(
            'Curriculum options tailored for every learner',
            style: TextStyle(
              fontSize: isMobile ? 13 : isTablet ? 14 : 15,
              color: Color(0xFF445566),
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  Widget _buildCurriculumCarousel() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 20 : 30,
        horizontal: isMobile ? 4 : 24,
      ),
      child: Column(
        children: [
          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              curriculums.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: isMobile ? 8 : 10,
                height: isMobile ? 8 : 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index 
                      ? Color(0xFFFFB300) 
                      : Color(0xFFFFB300).withOpacity(0.3),
                ),
              ),
            ),
          ),
          SizedBox(height: isMobile ? 20 : 30),
          
          // Carousel with side navigation buttons
          Container(
            height: isMobile ? 500 : isTablet ? 450 : 450,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Carousel
                PageView.builder(
                  controller: _carouselController,
                  itemCount: curriculums.length,
                  onPageChanged: (i) {
                    setState(() => _currentIndex = i);
                    // Reset auto-scroll timer when page changes
                    _startAutoScroll();
                  },
                  itemBuilder: (context, index) {
                    final item = curriculums[index];
                    final List<String> highlights =
                        (item['highlights'] as List<dynamic>).cast<String>();

                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 2.0 : 32.0, 
                        vertical: 8
                      ),
                      child: _CurriculumCard(
                        name: item['name'] as String,
                        desc: item['desc'] as String,
                        image: item['image'] as String,
                        bgColor: item['bgColor'] as Color,
                        highlights: highlights,
                      ),
                    );
                  },
                ),
                
                // Left navigation button
                if (!isMobile)
                  Positioned(
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () => _goTo(-1),
                        icon: Icon(
                          Icons.chevron_left, 
                          size: 32,
                          color: Color(0xFF002B5B),
                        ),
                      ),
                    ),
                  ),
                
                // Right navigation button
                if (!isMobile)
                  Positioned(
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () => _goTo(1),
                        icon: Icon(
                          Icons.chevron_right, 
                          size: 32,
                          color: Color(0xFF002B5B),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Mobile navigation buttons (below on mobile)
          if (isMobile) ...[
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => _goTo(-1),
                    icon: Icon(
                      Icons.chevron_left, 
                      size: 28,
                      color: Color(0xFF002B5B),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => _goTo(1),
                    icon: Icon(
                      Icons.chevron_right, 
                      size: 28,
                      color: Color(0xFF002B5B),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 24 : isTablet ? 28 : 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF002B5B), Color(0xFF001122)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.rocket_launch,
            color: Color(0xFFFFB300),
            size: isMobile ? 40 : 50,
          ),
          SizedBox(height: isMobile ? 15 : 20),
          Text(
            'Ready to take the next step?',
            style: TextStyle(
              color: Colors.white, 
              fontSize: isMobile ? 18 : isTablet ? 20 : 22, 
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 8 : 12),
          Text(
            'Join thousands of students who have found their academic spark with us',
            style: TextStyle(
              color: Colors.white70,
              fontSize: isMobile ? 14 : 16,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 20 : 24),
          isMobile 
              ? Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/admissions'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFB300),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Apply Now',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pushNamed(context, '/contact'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.white70, width: 2),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Talk to a Counselor',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/admissions'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFB300),
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Apply Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => Navigator.pushNamed(context, '/contact'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.white70, width: 2),
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Talk to a Counselor',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _CurriculumCard extends StatelessWidget {
  final String name;
  final String desc;
  final String image;
  final Color bgColor;
  final List<String> highlights;

  const _CurriculumCard({
    required this.name,
    required this.desc,
    required this.image,
    required this.bgColor,
    required this.highlights,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    
    return Container(
      width: isMobile ? double.infinity : isTablet ? 800 : 1000,
      height: isMobile ? 480 : isTablet ? 400 : 380,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: bgColor.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
          border: Border.all(color: bgColor.withOpacity(0.3), width: 2),
        ),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 10.0 : 28.0),
          child: isMobile 
              ? Column(
                  children: [
                    // Header with icon and title
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: bgColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.school,
                            color: bgColor,
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF002B5B),
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    
                    // Image container
                    Container(
                      height: 90,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [bgColor.withOpacity(0.8), bgColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: bgColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            image, 
                            fit: BoxFit.contain, 
                            height: 55,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    
                    // Description
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          desc,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF334155),
                            height: 1.5,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    
                    // Highlights
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Key Features:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF002B5B),
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(height: 6),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: highlights
                              .map((h) => Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [bgColor.withOpacity(0.8), bgColor],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: [
                                        BoxShadow(
                                          color: bgColor.withOpacity(0.3),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      h,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [bgColor.withOpacity(0.8), bgColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: bgColor.withOpacity(0.3),
                              blurRadius: 15,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.asset(
                              image, 
                              fit: BoxFit.contain, 
                              height: isTablet ? 200 : 220,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: isTablet ? 24 : 32),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: bgColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.school,
                                  color: bgColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child:                           Text(
                            name,
                            style: TextStyle(
                              fontSize: isTablet ? 26 : 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF002B5B),
                              fontFamily: 'Poppins',
                            ),
                          ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            desc,
                            style: TextStyle(
                              fontSize: isTablet ? 15 : 17,
                              color: Color(0xFF334155),
                              height: 1.6,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Key Features:',
                            style: TextStyle(
                              fontSize: isTablet ? 14 : 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF002B5B),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 12),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: highlights
                                .map((h) => Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [bgColor.withOpacity(0.8), bgColor],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: bgColor.withOpacity(0.3),
                                            blurRadius: 5,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        h,
                                        style: TextStyle(
                                          fontSize: isTablet ? 11 : 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
