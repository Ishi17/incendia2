import 'package:flutter/material.dart';

class AcademicPage extends StatefulWidget {
  const AcademicPage({super.key});

  @override
  State<AcademicPage> createState() => _AcademicPageState();
}

class _AcademicPageState extends State<AcademicPage> {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1);

  int _currentIndex = 0;

  final List<Map<String, dynamic>> curriculums = [
    {
      'name': 'CBSE',
      'desc':
          'The Central Board of Secondary Education (CBSE) is a national level board that emphasizes analytical thinking, structured learning, and a solid foundation for competitive exams like JEE and NEET. It encourages theoretical clarity and a disciplined approach to academics.',
      'image': 'assets/images/cbse.png',
      'bgColor': Colors.orangeAccent,
      'showHint': true,
    },
    {
      'name': 'ICSE',
      'desc':
          'The Indian Certificate of Secondary Education (ICSE) is known for its comprehensive syllabus that balances sciences, mathematics, humanities, and languages. It places special focus on English proficiency, creative expression, and a well-rounded academic experience.',
      'image': 'assets/images/icse.png',
      'bgColor': Colors.lightBlueAccent,
      'showHint': false,
    },
    {
      'name': 'IB',
      'desc':
          'The International Baccalaureate (IB) program fosters global citizenship, critical thinking, and interdisciplinary inquiry. With internal assessments, extended essays, and real-world learning, IB prepares students for international universities and leadership roles.',
      'image': 'assets/images/ib.png',
      'bgColor': Colors.lightGreenAccent,
      'showHint': false,
    },
    {
      'name': 'State Boards',
      'desc':
          'State Boards tailor education to regional contexts, languages, and cultures while covering the required academic subjects. They offer flexibility and localized relevance, making them accessible and practical for students across diverse socio-economic backgrounds.',
      'image': 'assets/images/state.png',
      'bgColor': Colors.purpleAccent,
      'showHint': false,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int delta) {
    final next = (_currentIndex + delta).clamp(0, curriculums.length - 1);
    if (next == _currentIndex) return;
    _pageController.animateToPage(
      next,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
    setState(() => _currentIndex = next);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academics'),
        backgroundColor: const Color(0xFF002B5B),
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(),
            _buildGradesCaptionBox(),
            _buildCurriculumWithButtons(),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // --- Sections ---

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: const Color(0xFF002B5B),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Academics',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Empowering students with academic mastery, real-world relevance, and confidence.',
            style: TextStyle(
              fontSize: 12,
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
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: const Text(
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

  /// Replaces vertical swiping with Up/Down buttons that drive PageView.
  Widget _buildCurriculumWithButtons() {
    return SizedBox(
      height: 500,
      child: Row(
        children: [
          // LEFT (Fixed Caption)
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFF002B5B),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // RIGHT (PageView with buttons under text)
          Expanded(
            flex: 2,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (i) => setState(() => _currentIndex = i),
              itemCount: curriculums.length,
              itemBuilder: (context, index) {
                final item = curriculums[index];
                final isAsset = !item['image'].toString().startsWith('http');

                return Container(
                  color: (item['bgColor'] as Color?)?.withOpacity(0.12) ??
                      Colors.grey.shade100,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // IMAGE
                      Expanded(
                        flex: 1,
                        child: isAsset
                            ? Image.asset(item['image'])
                            : Image.network(item['image'],
                                fit: BoxFit.cover, height: double.infinity),
                      ),
                      const SizedBox(width: 20),

                      // TEXT + BUTTONS
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF002B5B),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              item['desc'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // ⬆️⬇️ Buttons below the text
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _navIconButton(
                                  icon: Icons.keyboard_arrow_up,
                                  enabled: _currentIndex > 0,
                                  onTap: () => _goTo(-1),
                                ),
                                const SizedBox(width: 12),
                                _navIconButton(
                                  icon: Icons.keyboard_arrow_down,
                                  enabled: _currentIndex < curriculums.length - 1,
                                  onTap: () => _goTo(1),
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            // index indicator
                            Center(
                              child: Text(
                                '${_currentIndex + 1} / ${curriculums.length}',
                                style: const TextStyle(
                                  color: Color(0xFF002B5B),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
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

  Widget _navIconButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return IconButton(
      onPressed: enabled ? onTap : null,
      icon: Icon(icon, size: 28, color: const Color(0xFF002B5B)),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white,
        disabledBackgroundColor: Colors.white54,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(10),
        shadowColor: Colors.black26,
        elevation: 2,
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: const Color(0xFF001122),
      child: Column(
        children: [
          const Text(
            'Interested in Applying?',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/admissions'),
            child: const Text('Apply Now'),
          ),
        ],
      ),
    );
  }
}
