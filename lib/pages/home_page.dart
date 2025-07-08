import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() => _isScrolled = _scrollController.offset > 50);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool get isMobile => MediaQuery.of(context).size.width < 768;

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
                _buildOfferingsSection(),
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
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF002B5B)),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF6B00),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.school, color: Colors.white),
                ),
                SizedBox(width: 12),
                Text(
                  'EduHub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ...[
            'About',
            'Academic',
            'Life Skills',
            'Schedule',
            'Admissions',
            'Gallery',
            'Careers',
            'Contact',
          ].map(
            (item) => ListTile(
              title: Text(item, style: TextStyle(color: Color(0xFF002B5B))),
              onTap: () {
                String path = "/${item.toLowerCase().replaceAll(" ", "")}";
                print(path);
                Navigator.pushNamed(context, path);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: isMobile ? 60 : 80,
      floating: true,
      pinned: true,
      backgroundColor: _isScrolled ? Colors.white : Colors.transparent,
      elevation: _isScrolled ? 4 : 0,
      leading: isMobile ? null : SizedBox.shrink(),
      flexibleSpace: FlexibleSpaceBar(
        title: Row(
          children: [
            Container(
              width: isMobile ? 32 : 40,
              height: isMobile ? 32 : 40,
              decoration: BoxDecoration(
                color: Color(0xFFFF6B00),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.school,
                color: Colors.white,
                size: isMobile ? 20 : 24,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'EduHub',
              style: TextStyle(
                color: Color(0xFF002B5B),
                fontSize: isMobile ? 18 : 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        titlePadding: EdgeInsets.only(left: isMobile ? 60 : 24, bottom: 16),
      ),
      actions: isMobile
          ? null
          : [
              Container(
                margin: EdgeInsets.only(right: 24),
                child: Row(
                  children:
                      [
                            'About',
                            'Academic',
                            'Life Skills',
                            'Schedule',
                            'Admissions',
                            'Gallery',
                            'Careers',
                            'Contact',
                          ]
                          .map(
                            (item) => TextButton(
                              onPressed: () {
                                String path =
                                    "/${item.toLowerCase().replaceAll(" ", "")}";
                                print(path);
                                Navigator.pushNamed(context, path);
                              },
                              child: Text(
                                item,
                                style: TextStyle(
                                  color:  Color(0xFF002B5B)
                                     ,
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
      height: isMobile ? 500 : 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF002B5B), Color(0xFF004080)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 20 : 24),
          child: isMobile ? _buildMobileHero() : _buildDesktopHero(),
        ),
      ),
    );
  }

  Widget _buildMobileHero() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Empowering Students\nfor Academic Excellence',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        Text(
          'Comprehensive education programs combining academic mastery with essential life skills.',
          style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9)),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 32),
        Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF6B00),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Start Your Journey',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Learn More', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopHero() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  children: [
                    TextSpan(
                      text: 'Empowering Students\n',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: 'for Academic Excellence',
                      style: TextStyle(color: Color(0xFFFF6B00)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Comprehensive education programs combining academic mastery with essential life skills.',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF6B00),
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                    ),
                    child: Text(
                      'Start Your Journey',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white),
                    ),
                    child: Text(
                      'Learn More',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 48),
        Expanded(
          flex: 2,
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.play_circle_outline,
              size: 80,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOfferingsSection() {
    final offerings = [
      {
        'icon': Icons.book,
        'title': 'Academic Mastery',
        'desc': 'Board-wise curriculum for CBSE, ICSE & State boards',
      },
      {
        'icon': Icons.psychology,
        'title': 'Life Skills',
        'desc': 'Critical thinking, communication & problem-solving',
      },
      {
        'icon': Icons.schedule,
        'title': 'Flexible Schedule',
        'desc': 'Convenient timings across multiple locations',
      },
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 40 : 80),
      child: Column(
        children: [
          Text(
            'Our Programs',
            style: TextStyle(
              fontSize: isMobile ? 28 : 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002B5B),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Comprehensive education solutions tailored for every student',
            style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          isMobile
              ? Column(
                  children: offerings
                      .map(
                        (item) => Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: _buildOfferingCard(item),
                        ),
                      )
                      .toList(),
                )
              : GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 32,
                  mainAxisSpacing: 32,
                  children: offerings
                      .map((item) => _buildOfferingCard(item))
                      .toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildOfferingCard(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Color(0xFFFF6B00).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(item['icon'], size: 28, color: Color(0xFFFF6B00)),
          ),
          SizedBox(height: 16),
          Text(
            item['title'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF002B5B),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            item['desc'],
            style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCtaSection() {
    return Container(
      padding: EdgeInsets.all(isMobile ? 40 : 80),
      color: Color(0xFF002B5B),
      child: Column(
        children: [
          Text(
            'Ready to Begin Your Journey?',
            style: TextStyle(
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Join thousands of students who have transformed their academic performance.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          isMobile
              ? Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF6B00),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        'Apply Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        'Contact Us',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF6B00),
                      ),
                      child: Text(
                        'Apply Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white),
                      ),
                      child: Text(
                        'Contact Us',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(isMobile ? 30 : 48),
      color: Color(0xFF001122),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Color(0xFFFF6B00),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            Icons.school,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'EduHub',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Empowering students with academic excellence and essential life skills.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isMobile) ...[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Links',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16),
                      ...[
                        'About Us',
                        'Academic',
                        'Life Skills',
                        'Admissions',
                      ].map(
                        (item) => Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            item,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resources',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16),
                      ...['Schedule', 'Gallery', 'Careers', 'Contact'].map(
                        (item) => Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            item,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 24),
          Divider(color: Colors.white.withOpacity(0.2)),
          SizedBox(height: 16),
          Text(
            '© 2025 EduHub. All rights reserved.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
