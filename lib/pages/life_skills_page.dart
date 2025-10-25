import 'package:flutter/material.dart';
import '../components/custom_navbar.dart';

class LifeSkillsPage extends StatelessWidget {
  const LifeSkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    
    return Scaffold(
      appBar: CustomNavbar(
        title: 'Life Skills',
        showBackButton: true,
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeaderSection(isMobile, isTablet),
              _buildSkillsList(context, isMobile, isTablet),
              _buildTestimonialSection(isMobile, isTablet),
              _buildFooter(context, isMobile, isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(bool isMobile, bool isTablet) {
    
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
            Icons.psychology,
            size: isMobile ? 50 : isTablet ? 60 : 70,
            color: Color(0xFFFF6B00),
          ),
          SizedBox(height: isMobile ? 15 : 20),
          Text(
            'Life Skills for the Real World',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 28 : isTablet ? 32 : 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'Empowering students with critical thinking, communication, and emotional intelligence.',
            style: TextStyle(
              fontSize: isMobile ? 14 : isTablet ? 16 : 18,
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

  Widget _buildSkillsList(BuildContext context, bool isMobile, bool isTablet) {
    final List<Map<String, dynamic>> skills = [
      {
        'title': 'Financial Literacy for Teens',
        'description': 'Budgeting, saving, digital payments (UPI, wallets), understanding banks, avoiding scams.',
        'icon': Icons.account_balance,
        'color': Color(0xFFE3F2FD), // Light Blue
      },
      {
        'title': 'Digital Citizenship & Internet Safety',
        'description': 'Cyberbullying, privacy settings, fake news, screen time balance, digital footprint.',
        'icon': Icons.security,
        'color': Color(0xFFFCE4EC), // Pink
      },
      {
        'title': 'Communication & Public Speaking',
        'description': 'Storytelling, debates, presentations, body language, active listening.',
        'icon': Icons.record_voice_over,
        'color': Color(0xFFE8F5E9), // Green
      },
      {
        'title': 'Time Management & Study Skills',
        'description': 'Prioritizing tasks, planners, Pomodoro technique, overcoming distractions.',
        'icon': Icons.schedule,
        'color': Color(0xFFFFF3E0), // Orange
      },
      {
        'title': 'Leadership & Teamwork',
        'description': 'Group roles, collaboration, leading projects, resolving conflicts.',
        'icon': Icons.group,
        'color': Color(0xFFF3E5F5), // Purple
      },
      {
        'title': 'Emotional Intelligence (EQ)',
        'description': 'Identifying feelings, managing emotions, self-awareness, empathy exercises.',
        'icon': Icons.sentiment_satisfied,
        'color': Color(0xFFE0F7FA), // Cyan
      },
      {
        'title': 'Basic Legal & Civic Awareness',
        'description': 'Student rights, voting basics, equality, safety laws, RTI & digital consent.',
        'icon': Icons.gavel,
        'color': Color(0xFFFFEBEE), // Light Red
      },
      {
        'title': 'Goal Setting & Self-Motivation',
        'description': 'SMART goals, vision boards, intrinsic vs extrinsic motivation, habit loops.',
        'icon': Icons.flag,
        'color': Color(0xFFFFF9C4), // Yellow
      },
      {
        'title': 'First Aid & Personal Safety',
        'description': 'CPR basics, handling minor injuries, emergency contact awareness, street safety.',
        'icon': Icons.medical_services,
        'color': Color(0xFFE1F5FE), // Light Blue
      },
      {
        'title': 'Mindfulness & Mental Well-being',
        'description': 'Meditation, stress management, gratitude journaling, self-reflection techniques.',
        'icon': Icons.self_improvement,
        'color': Color(0xFFF1F8E9), // Light Green
      },
      {
        'title': 'Nutrition & Fireless Cooking',
        'description': 'Healthy eating habits, decoding food labels, making simple no-flame recipes.',
        'icon': Icons.restaurant,
        'color': Color(0xFFFFFDE7), // Light Yellow
      },
      {
        'title': 'Career Awareness & Future Readiness',
        'description': 'Career exploration, 21st-century jobs, freelancing basics, resume writing.',
        'icon': Icons.work,
        'color': Color(0xFFEDE7F6), // Lavender
      },
    ];

    return Padding(
      padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          
          return Wrap(
            spacing: isMobile ? 12 : isTablet ? 16 : 20,
            runSpacing: isMobile ? 12 : isTablet ? 16 : 20,
            alignment: WrapAlignment.center,
            children: skills.map<Widget>((skillData) {
              return SizedBox(
                width: isMobile 
                    ? (constraints.maxWidth - 32) / 2
                    : isTablet 
                        ? (constraints.maxWidth - 48) / 3
                        : 320,
                child: SkillCard(
                  title: skillData['title']!,
                  description: skillData['description']!,
                  icon: skillData['icon'],
                  color: skillData['color'],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }


  Widget _buildTestimonialSection(bool isMobile, bool isTablet) {
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : isTablet ? 24 : 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEEF2F7), Color(0xFFF8FAFC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.format_quote,
            size: isMobile ? 40 : 50,
            color: Color(0xFFFF6B00),
          ),
          SizedBox(height: isMobile ? 15 : 20),
          Text(
            'What Our Students Say',
            style: TextStyle(
              fontSize: isMobile ? 20 : isTablet ? 22 : 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002B5B),
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            '"Learning life skills here helped me become more confident and independent."',
            style: TextStyle(
              fontSize: isMobile ? 14 : isTablet ? 15 : 16, 
              color: Color(0xFF333333),
              fontFamily: 'Inter',
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 15 : 20),
          Text(
            '- Sarah, Grade 11',
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              color: Color(0xFF666666),
              fontStyle: FontStyle.italic,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isMobile, bool isTablet) {
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : isTablet ? 24 : 32),
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
            color: Color(0xFFFF6B00),
            size: isMobile ? 40 : 50,
          ),
          SizedBox(height: isMobile ? 15 : 20),
          Text(
            'Interested in Life Skills Programs?',
            style: TextStyle(
              color: Colors.white, 
              fontSize: isMobile ? 16 : isTablet ? 18 : 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 8 : 12),
          Text(
            'Join thousands of students developing essential life skills for success',
            style: TextStyle(
              color: Colors.white70,
              fontSize: isMobile ? 14 : 16,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 20 : 24),
          isMobile 
              ? SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/admissions'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF6B00),
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
                )
              : ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/admissions'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6B00),
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
        ],
      ),
    );
  }
}

class SkillCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const SkillCard({required this.title, required this.description, required this.icon, required this.color, super.key});

  @override
  _SkillCardState createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter(bool hovering) {
    setState(() {
      isHovered = hovering;
      if (isHovered) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Widget _buildFront() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    
    return Padding(
      padding: EdgeInsets.all(isMobile ? 16.0 : 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon, 
            color: Color(0xFFFF6B00), 
            size: isMobile ? 32 : isTablet ? 36 : 40
          ),
          SizedBox(height: isMobile ? 10 : 12),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: isMobile ? 14 : isTablet ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002B5B),
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBack() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    
    return Padding(
      padding: EdgeInsets.all(isMobile ? 16.0 : 20.0),
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            widget.description,
            style: TextStyle(
              fontSize: isMobile ? 12 : isTablet ? 13 : 14,
              color: Colors.black87,
              fontFamily: 'Inter',
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    
    return MouseRegion(
      onEnter: (_) => _onEnter(true),
      onExit: (_) => _onEnter(false),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final scale = 1.0 + (0.045 * _animation.value);
          final lift = 6.0 * _animation.value;
          final shadowOpacity = 0.05 + (0.15 * _animation.value);
          final shadowBlur = 10.0 + (12.0 * _animation.value);

          return Transform.translate(
            offset: Offset(0, -lift),
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                height: isMobile ? 180 : isTablet ? 200 : 220,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(shadowOpacity),
                      blurRadius: shadowBlur,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: isHovered
                      ? Container(key: ValueKey('back'), child: _buildBack())
                      : Container(key: ValueKey('front'), child: _buildFront()),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
