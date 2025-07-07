import 'package:flutter/material.dart';
import 'dart:math';

class LifeSkillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Life Skills'),
        backgroundColor: Color(0xFF002B5B),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeaderSection(),
              _buildSkillsList(),
              _buildTestimonialSection(),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: Color(0xFF002B5B),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Life Skills for the Real World',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Empowering students with critical thinking, communication, and emotional intelligence.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsList() {
    final List<Map<String, dynamic>> skills = [
      {
        'title': 'Financial Literacy for Teens',
        'description': 'Budgeting, saving, digital payments (UPI, wallets), understanding banks, avoiding scams.',
        'icon': Icons.account_balance,
      },
      {
        'title': 'Digital Citizenship & Internet Safety',
        'description': 'Cyberbullying, privacy settings, fake news, screen time balance, digital footprint.',
        'icon': Icons.security,
      },
      {
        'title': 'Communication & Public Speaking',
        'description': 'Storytelling, debates, presentations, body language, active listening.',
        'icon': Icons.record_voice_over,
      },
      {
        'title': 'Time Management & Study Skills',
        'description': 'Prioritizing tasks, planners, Pomodoro technique, overcoming distractions.',
        'icon': Icons.schedule,
      },
      {
        'title': 'Leadership & Teamwork',
        'description': 'Group roles, collaboration, leading projects, resolving conflicts.',
        'icon': Icons.group,
      },
      {
        'title': 'Emotional Intelligence (EQ)',
        'description': 'Identifying feelings, managing emotions, self-awareness, empathy exercises.',
        'icon': Icons.sentiment_satisfied,
      },
      {
        'title': 'Basic Legal & Civic Awareness',
        'description': 'Student rights, voting basics, equality, safety laws, RTI & digital consent.',
        'icon': Icons.gavel,
      },
      {
        'title': 'Goal Setting & Self-Motivation',
        'description': 'SMART goals, vision boards, intrinsic vs extrinsic motivation, habit loops.',
        'icon': Icons.flag,
      },
      {
        'title': 'First Aid & Personal Safety',
        'description': 'CPR basics, handling minor injuries, emergency contact awareness, street safety.',
        'icon': Icons.medical_services,
      },
      {
        'title': 'Mindfulness & Mental Well-being',
        'description': 'Meditation, stress management, gratitude journaling, self-reflection techniques.',
        'icon': Icons.self_improvement,
      },
      {
        'title': 'Nutrition & Fireless Cooking',
        'description': 'Healthy eating habits, decoding food labels, making simple no-flame recipes.',
        'icon': Icons.restaurant,
      },
      {
        'title': 'Career Awareness & Future Readiness',
        'description': 'Career exploration, 21st-century jobs, freelancing basics, resume writing.',
        'icon': Icons.work,
      },
    ];

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: skills.map<Widget>((skillData) {
        return SkillCard(
          title: skillData['title']!,
          description: skillData['description']!,
          icon: skillData['icon'],
        );
      }).toList(),
    ),
  );
}

  Widget _buildTestimonialSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      color: Color(0xFFEEF2F7),
      child: Column(
        children: [
          Text(
            'What Our Students Say',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002B5B),
            ),
          ),
          SizedBox(height: 16),
          Text(
            '"Learning life skills here helped me become more confident and independent."',
            style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      color: Color(0xFF001122),
      child: Column(
        children: [
          Text(
            'Interested in Life Skills Programs?',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/admissions'),
            child: Text('Apply Now'),
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

  const SkillCard({required this.title, required this.description, required this.icon, Key? key}) : super(key: key);

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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.icon, color: Color(0xFFFF6B00), size: 40),
          SizedBox(height: 12),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002B5B),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBack() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          widget.description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onEnter(true),
      onExit: (_) => _onEnter(false),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          final isFront = _animation.value <= 0.5;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateX(angle),       // rotateX for vertical flip
            child: Container(
              width: 300,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: isFront
                  ? _buildFront()
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationX(pi),
                      child: _buildBack(),
                    ),
            ),
          );
        },
      ),
    );
  }
}
