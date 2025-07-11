import 'package:flutter/material.dart';

class AcademicPage extends StatelessWidget {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1);

  final List<Map<String, dynamic>> curriculums = [
    {
      'name': 'CBSE',
      'desc':
          'The Central Board of Secondary Education (CBSE) is a national level board that emphasizes analytical thinking, structured learning, and a solid foundation for competitive exams like JEE and NEET. It encourages theoretical clarity and a disciplined approach to academics.',
      'image': 'assets/images/cbse.png',
      'bgColor': Colors.orange.shade50,
      'showHint': true,
    },
    {
      'name': 'ICSE',
      'desc':
          'The Indian Certificate of Secondary Education (ICSE) is known for its comprehensive syllabus that balances sciences, mathematics, humanities, and languages. It places special focus on English proficiency, creative expression, and a well-rounded academic experience.',
      'image': 'assets/images/icse.png',
      'bgColor': Colors.blue.shade50,
      'showHint': false,
    },
    {
      'name': 'IB',
      'desc':
          'The International Baccalaureate (IB) program fosters global citizenship, critical thinking, and interdisciplinary inquiry. With internal assessments, extended essays, and real-world learning, IB prepares students for international universities and leadership roles.',
      'image': 'assets/images/ib.png',
      'bgColor': Colors.green.shade50,
      'showHint': false,
    },
    {
      'name': 'State Boards',
      'desc':
          'State Boards tailor education to regional contexts, languages, and cultures while covering the required academic subjects. They offer flexibility and localized relevance, making them accessible and practical for students across diverse socio-economic backgrounds.',
      'image': 'assets/images/state.png',
      'bgColor': Colors.purple.shade50,
      'showHint': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Academics'),
        backgroundColor: Color(0xFF002B5B),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(),
            _buildGradesCaptionBox(),
            _buildCurriculumVerticalSwiper(),
            _buildFooter(context),
          ],
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
            'Academics',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Empowering students with academic mastery, real-world relevance, and confidence.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGradesCaptionBox() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Text(
        'We cater to students in Grades 9–12 across multiple boards.',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF002B5B),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCurriculumVerticalSwiper() {
    return Container(
      height: 600,
      child: Row(
        children: [
          // LEFT (Fixed Caption)
          Expanded(
            flex: 1,
            child: Container(
              color: Color(0xFF002B5B),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Curriculums We Offer',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Explore the diverse academic programs that Incendia supports.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // RIGHT (Vertical Swiper)
          Expanded(
            flex: 2,
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: curriculums.length,
              itemBuilder: (context, index) {
                final item = curriculums[index];
                final isAsset = !item['image'].toString().startsWith('http');

                return Container(
                  color: item['bgColor'],
                  padding: EdgeInsets.all(32),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: isAsset
                            ? Image.asset(item['image'])
                            : Image.network(
                                item['image'],
                                fit: BoxFit.cover,
                                height: double.infinity,
                              ),
                      ),
                      SizedBox(width: 32),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF002B5B),
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              item['desc'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                                height: 1.5,
                              ),
                            ),
                            if (item['showHint'] == true) ...[
                              SizedBox(height: 32),
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Swipe up to see more',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Icon(Icons.keyboard_arrow_down_rounded,
                                        size: 32, color: Colors.grey[600]),
                                  ],
                                ),
                              )
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
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
            'Interested in Applying?',
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
