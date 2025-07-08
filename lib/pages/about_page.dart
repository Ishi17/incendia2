import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage>
    with TickerProviderStateMixin {
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
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              height: 300,
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
                        Icons.local_fire_department,
                        size: 60,
                        color: Color(0xFFFF6B00),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'About Incendia',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Where every spark finds its flame',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Main Content
            Padding(
              padding: EdgeInsets.all(20),
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      // Story Section
                      _buildStoryCard(),
                      SizedBox(height: 30),
                      
                      // Mission Cards
                      _buildMissionCards(),
                      SizedBox(height: 30),
                      
                      // Stats Section
                      _buildStatsSection(),
                      SizedBox(height: 30),
                      
                      // Values Section
                      _buildValuesSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryCard() {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFFF6B00).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.auto_stories,
                  color: Color(0xFFFF6B00),
                  size: 24,
                ),
              ),
              SizedBox(width: 15),
              Text(
                'Our Story — The Spark Behind Incendia',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF002B5B),
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'In every child lies a spark — a quiet curiosity, a restless question, a flicker of confidence waiting to ignite. But in crowded classrooms and exam-driven systems, that spark is often overlooked.',
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.grey[700],
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF002B5B).withOpacity(0.05),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color(0xFF002B5B).withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Text(
              'At Incendia, we exist to protect that spark. To fan it. To turn it into a steady flame of understanding, clarity, and purpose. We\'re reimagining what tuition means.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF002B5B),
                fontFamily: 'Poppins',
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'We started as educators, mentors, and parents who believed that real learning goes beyond finishing the syllabus. It\'s about mastering fundamentals, building the confidence to ask \'why,\' and learning skills that last a lifetime — not just till the next test.',
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.grey[700],
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFFF6B00).withOpacity(0.05),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color(0xFFFF6B00).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'From a single classroom filled with eager questions and honest conversations, we\'ve grown into a learning community that:',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Colors.grey[700],
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 10),
                _buildBulletPoint('Caters to multiple boards (CBSE, ICSE, IB)'),
                _buildBulletPoint('Serves Grades 9 to 12'),
                _buildBulletPoint('Balances academic excellence and life skills'),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'At Incendia, we teach students how to solve equations — but also how to speak with clarity, think with depth, and grow with integrity. Because in tomorrow\'s world, marks will open doors, but mindset will shape destinies.',
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.grey[700],
              fontFamily: 'Inter',
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF002B5B), Color(0xFF1E3A8A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'So whether your child dreams of becoming a scientist, an artist, a doctor, or an innovator — we\'re here to walk with them. To guide, nurture, and remind them that their spark matters.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Welcome to Incendia. Where every student is seen, every question matters, and every spark finds its flame.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF6B00),
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8, right: 10),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Color(0xFFFF6B00),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
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

  Widget _buildMissionCards() {
    return Row(
      children: [
        Expanded(
          child: _buildMissionCard(
            Icons.school,
            'Academic Excellence',
            'Mastering fundamentals with confidence',
            Color(0xFFFF6B00),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: _buildMissionCard(
            Icons.psychology,
            'Life Skills',
            'Building mindset for tomorrow',
            Color(0xFF002B5B),
          ),
        ),
      ],
    );
  }

  Widget _buildMissionCard(IconData icon, String title, String subtitle, Color color) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
          SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002B5B),
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF002B5B), Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat('Grades', '9-12', Icons.grade),
          _buildStat('Boards', 'CBSE, ICSE, IB', Icons.school),
          _buildStat('Focus', 'Excellence', Icons.star),
        ],
      ),
    );
  }

  Widget _buildStat(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Color(0xFFFF6B00),
          size: 30,
        ),
        SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white70,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  Widget _buildValuesSection() {
    return Column(
      children: [
        Text(
          'Our Values',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF002B5B),
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildValueItem('Every student is seen', Icons.visibility),
              _buildValueItem('Every question matters', Icons.help_outline),
              _buildValueItem('Every spark finds its flame', Icons.local_fire_department),
            ],
          ),
        ),
        SizedBox(height: 30),
        Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Color(0xFFFF6B00).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color(0xFFFF6B00).withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                'Trusted by parents. Loved by students.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF002B5B),
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Where marks open doors, but mindset shapes destinies.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildValueItem(String text, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: Color(0xFFFF6B00),
            size: 24,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}