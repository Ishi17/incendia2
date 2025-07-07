import 'package:flutter/material.dart';

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
          width: double.infinity, // Make container take full width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center contents horizontally
            children: [
              // SizedBox(height: 22), - Top Margin
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
      width: double.infinity, // Ensure full width here too
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
    final skills = [
      {
        'title': 'Financial Literacy for Teens',
        'description': 'Budgeting, saving, digital payments (UPI, wallets), understanding banks, avoiding scams.'
      },
      {
        'title':'Digital Citizenship & Internet Safety',
        'description':'Cyberbullying, privacy settings, fake news, screen time balance, digital footprint.'
      },
      {
        'title':'Communication & Public Speaking',
        'description': 'Storytelling, debates, presentations, body language, active listening.'
      },
      {
        'title':'Time Management & Study Skills',
        'description': 'Prioritizing tasks, planners, Pomodoro technique, overcoming distractions.'
      },
      {
        'title': 'Leadership & Teamwork',
        'description': 'Group roles, collaboration, leading projects, resolving conflicts.'
      },
      {
        'title': 'Emotional Intelligence (EQ)',
        'description': 'Identifying feelings, managing emotions, self-awareness, empathy exercises.'
      },
      {
        'title':'Basic Legal & Civic Awareness',
        'description': 'Student rights, voting basics, equality, safety laws, RTI & digital consent.'
      },
      {
        'title':'Goal Setting & Self-Motivation',
        'description': 'SMART goals, vision boards, intrinsic vs extrinsic motivation, habit loops.'
      },
      {
        'title': 'First Aid & Personal Safety',
        'description': 'CPR basics, handling minor injuries, emergency contact awareness, street safety.'
      },
      {
        'title': 'Mindfulness & Mental Well-being',
        'description': 'Meditation, stress management, gratitude journaling, self-reflection techniques.'
      },
      {
        'title': 'Nutrition & Fireless Cooking',
        'description': 'Healthy eating habits, decoding food labels, making simple no-flame recipes.'
      },
      {
        'title': 'Career Awareness & Future Readiness',
        'description': 'Career exploration, 21st-century jobs, freelancing basics, resume writing.'
      }
    ];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Wrap(
        spacing: 24,
        runSpacing: 24,
        alignment: WrapAlignment.center, // Center the skill cards in the row
        children: skills.map((skillData) {
          final title = skillData['title']!;
          final description = skillData['description']!;
          return Container(
            width: 300,
            height: 220,
            padding: EdgeInsets.all(20),
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
            child: Column(
              children: [
                Icon(Icons.check_circle, color: Color(0xFFFF6B00), size: 40),
                SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF002B5B),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Expanded(
                  child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3, // 👈 Limits to 3 lines
                  overflow: TextOverflow.ellipsis,
                  ),
                )
                
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTestimonialSection() {
    return Container(
      width: double.infinity, // Full width section
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
      width: double.infinity, // Full width footer
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
