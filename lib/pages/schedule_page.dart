import 'package:flutter/material.dart';
import '../components/custom_navbar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    
    return Scaffold(
      appBar: CustomNavbar(
        title: 'Schedule',
        showBackButton: true,
      ),
      drawer: const CustomDrawer(),
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            _buildHeroSection(),
            
            // Schedule Overview
            _buildScheduleOverview(),
            
            // Batch Timings
            _buildBatchTimings(),
            
            // Class Structure
            _buildClassStructure(),
            
            // Additional Information
            _buildAdditionalInfo(),
            
            // Contact Section
            _buildContactSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Container(
      height: isMobile ? 400 : 500,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF002B5B), Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.schedule,
                size: 80,
                color: Color(0xFFFF6B00),
              ),
              SizedBox(height: 20),
              Text(
                'Class Schedule',
                style: TextStyle(
                  fontSize: isMobile ? 32 : 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Text(
                'Flexible timings designed for every student\'s needs',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 20,
                  color: Colors.white70,
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleOverview() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      child: Column(
        children: [
          Text(
            'Schedule Overview',
            style: TextStyle(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002B5B),
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'We offer flexible batch timings to accommodate different schedules and learning preferences. Choose the timing that works best for you.',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              color: Colors.grey[700],
              height: 1.6,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          isMobile 
              ? Column(
                  children: [
                    _buildOverviewCard('6 Days', 'Per Week', Icons.calendar_today, isMobile),
                    SizedBox(height: 15),
                    _buildOverviewCard('2-4 Hours', 'Per Day', Icons.access_time, isMobile),
                    SizedBox(height: 15),
                    _buildOverviewCard('Small', 'Batch Size', Icons.people, isMobile),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildOverviewCard('6 Days', 'Per Week', Icons.calendar_today, isMobile),
                    _buildOverviewCard('2-4 Hours', 'Per Day', Icons.access_time, isMobile),
                    _buildOverviewCard('Small', 'Batch Size', Icons.people, isMobile),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String subtitle, IconData icon, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 12 : 15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: isMobile ? 8 : 10,
            offset: Offset(0, isMobile ? 3 : 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon, 
            color: Color(0xFFFF6B00), 
            size: isMobile ? 24 : 30
          ),
          SizedBox(height: isMobile ? 8 : 10),
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002B5B),
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 4 : 6),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              color: Colors.grey[600],
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBatchTimings() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    
    final batches = [
      {
        'title': 'Morning Batch',
        'time': '8:00 AM - 12:00 PM',
        'description': 'Perfect for early risers with fresh minds ready to learn',
        'icon': Icons.wb_sunny,
        'color': Color(0xFFFF6B00),
        'subjects': ['Maths', 'Physics', 'Chemistry'],
      },
      {
        'title': 'Afternoon Batch',
        'time': '1:00 PM - 5:00 PM',
        'description': 'Ideal timing for students comfortable with afternoon sessions',
        'icon': Icons.wb_sunny_outlined,
        'color': Color(0xFF2196F3),
        'subjects': ['Biology', 'English', 'Social Studies'],
      },
      {
        'title': 'Evening Batch',
        'time': '6:00 PM - 9:00 PM',
        'description': 'Convenient for working students and after school hours',
        'icon': Icons.nights_stay,
        'color': Color(0xFF9C27B0),
        'subjects': ['All Subjects', 'Revision', 'Doubt Clearing'],
      },
      {
        'title': 'Weekend Classes',
        'time': 'Saturday & Sunday',
        'description': 'Special weekend batches for comprehensive revision and practice',
        'icon': Icons.weekend,
        'color': Color(0xFF4CAF50),
        'subjects': ['Test Series', 'Mock Exams', 'Special Classes'],
      },
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      color: Color(0xFFF8F9FA),
      child: Column(
        children: [
          Text(
            'Available Batches',
            style: TextStyle(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002B5B),
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: isMobile ? 16 : isTablet ? 20 : 24,
                runSpacing: isMobile ? 16 : isTablet ? 20 : 24,
                children: batches.map((batch) => SizedBox(
                  width: isMobile 
                      ? constraints.maxWidth
                      : isTablet 
                          ? (constraints.maxWidth - 40) / 2
                          : (constraints.maxWidth - 60) / 3,
                  child: _buildBatchCard(
                    batch['title'] as String,
                    batch['time'] as String,
                    batch['description'] as String,
                    batch['icon'] as IconData,
                    batch['color'] as Color,
                    batch['subjects'] as List<String>,
                    isMobile,
                    isTablet,
                  ),
                )).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBatchCard(String title, String time, String description, IconData icon, Color color, List<String> subjects, bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : isTablet ? 20 : 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: isMobile ? 10 : 15,
            offset: Offset(0, isMobile ? 3 : 5),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMobile 
              ? Column(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: color, size: 24),
                    ),
                    SizedBox(height: 12),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF002B5B),
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 14,
                        color: color,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Row(
                  children: [
                    Container(
                      width: isTablet ? 50 : 60,
                      height: isTablet ? 50 : 60,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(isTablet ? 12 : 15),
                      ),
                      child: Icon(icon, color: color, size: isTablet ? 24 : 30),
                    ),
                    SizedBox(width: isTablet ? 12 : 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: isTablet ? 18 : 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF002B5B),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: isTablet ? 14 : 16,
                              color: color,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          SizedBox(height: isMobile ? 12 : 15),
          Text(
            description,
            style: TextStyle(
              fontSize: isMobile ? 12 : isTablet ? 13 : 14,
              color: Colors.grey[700],
              height: 1.5,
              fontFamily: 'Inter',
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
          SizedBox(height: isMobile ? 12 : 15),
          Text(
            'Subjects Covered:',
            style: TextStyle(
              fontSize: isMobile ? 12 : isTablet ? 13 : 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF002B5B),
              fontFamily: 'Poppins',
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
          SizedBox(height: isMobile ? 6 : 8),
          Wrap(
            spacing: isMobile ? 6 : 8,
            runSpacing: isMobile ? 6 : 8,
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            children: subjects.map((subject) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 10 : 12, 
                vertical: isMobile ? 4 : 6
              ),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(isMobile ? 12 : 15),
              ),
              child: Text(
                subject,
                style: TextStyle(
                  fontSize: isMobile ? 10 : isTablet ? 11 : 12,
                  color: color,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildClassStructure() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      child: Column(
        children: [
          Text(
            'Class Structure',
            style: TextStyle(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002B5B),
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          isMobile 
              ? Column(
                  children: [
                    _buildStructureItem('Theory', 'Conceptual understanding and problem-solving', Icons.book, isMobile),
                    SizedBox(height: 15),
                    _buildStructureItem('Practice', 'Regular practice sessions and assignments', Icons.assignment, isMobile),
                    SizedBox(height: 15),
                    _buildStructureItem('Tests', 'Weekly tests and monthly assessments', Icons.quiz, isMobile),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: _buildStructureItem('Theory', 'Conceptual understanding and problem-solving', Icons.book, isMobile),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: _buildStructureItem('Practice', 'Regular practice sessions and assignments', Icons.assignment, isMobile),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: _buildStructureItem('Tests', 'Weekly tests and monthly assessments', Icons.quiz, isMobile),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildStructureItem(String title, String description, IconData icon, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 12 : 15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: isMobile ? 8 : 10,
            offset: Offset(0, isMobile ? 3 : 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon, 
            color: Color(0xFFFF6B00), 
            size: isMobile ? 32 : 40
          ),
          SizedBox(height: isMobile ? 12 : 15),
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002B5B),
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 8 : 10),
          Text(
            description,
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              color: Colors.grey[700],
              height: 1.5,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      color: Color(0xFFF8F9FA),
      child: Column(
        children: [
          Text(
            'Additional Information',
            style: TextStyle(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002B5B),
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.all(isMobile ? 20 : 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: isMobile ? 10 : 15,
                  offset: Offset(0, isMobile ? 3 : 5),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildInfoItem('Flexible batch timings available', isMobile),
                _buildInfoItem('Small class sizes for personalized attention', isMobile),
                _buildInfoItem('Make-up classes for missed sessions', isMobile),
                _buildInfoItem('Online and offline options available', isMobile),
                _buildInfoItem('Regular progress tracking and parent updates', isMobile),
                _buildInfoItem('Special focus on weak subjects', isMobile),
                _buildInfoItem('Experienced and qualified teachers', isMobile),
                _buildInfoItem('Regular parent-teacher meetings', isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String text, bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 6 : 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: isMobile ? 6 : 8, right: isMobile ? 12 : 15),
            width: isMobile ? 6 : 8,
            height: isMobile ? 6 : 8,
            decoration: BoxDecoration(
              color: Color(0xFFFF6B00),
              borderRadius: BorderRadius.circular(isMobile ? 3 : 4),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                height: 1.5,
                color: Colors.grey[700],
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF002B5B), Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Need Help Choosing a Batch?',
            style: TextStyle(
              fontSize: isMobile ? 24 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          Text(
            'Our academic counselors are here to help you find the perfect schedule that fits your needs and learning style.',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              color: Colors.white70,
              fontFamily: 'Inter',
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          isMobile 
              ? Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/contact');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF6B00),
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Contact Us',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/admissions');
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.white, width: 2),
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Apply Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/contact');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF6B00),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Contact Us',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/admissions');
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white, width: 2),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Apply Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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