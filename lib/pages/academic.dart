import 'package:flutter/material.dart';
 

class AcademicPage extends StatefulWidget {
  const AcademicPage({super.key});

  @override
  State<AcademicPage> createState() => _AcademicPageState();
}

class _AcademicPageState extends State<AcademicPage> {
  late final PageController _carouselController;
  int _currentIndex = 0;
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
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  void _goTo(int delta) {
    final next = (_currentIndex + delta).clamp(0, curriculums.length - 1);
    if (next == _currentIndex) return;
    _carouselController.animateToPage(
      next,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
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
            _buildCurriculumCarousel(),
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
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Empowering students with academic mastery, real-world relevance, and confidence.',
            style: TextStyle(
              fontSize: 16,
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
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Column(
        children: const [
          Text(
            'Grades 9–12',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF002B5B),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6),
          Text(
            'Curriculum options tailored for every learner',
            style: TextStyle(fontSize: 14, color: Color(0xFF445566)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  Widget _buildCurriculumCarousel() {
    return SizedBox(
      height: 460,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _carouselController,
            itemCount: curriculums.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (context, index) {
              final item = curriculums[index];
              final List<String> highlights =
                  (item['highlights'] as List<dynamic>).cast<String>();

              return AnimatedBuilder(
                animation: _carouselController,
                builder: (context, child) {
                  final page = _carouselController.hasClients
                      ? (_carouselController.page ?? _currentIndex.toDouble())
                      : _currentIndex.toDouble();
                  final distance = (index - page).abs();
                  final clamped = distance.clamp(0.0, 1.0);

                  // Exactly 3 visible: center big, sides smaller & fainter
                  final scale = 0.8 + (0.2 * (1.0 - clamped)); // 0.8..1.0
                  final opacity = 0.5 + (0.5 * (1.0 - clamped)); // 0.5..1.0

                  return Opacity(
                    opacity: opacity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                      child: Transform.scale(
                        scale: scale,
                        alignment: Alignment.center,
                        child: _CurriculumCard(
                          name: item['name'] as String,
                          desc: item['desc'] as String,
                          image: item['image'] as String,
                          bgColor: item['bgColor'] as Color,
                          highlights: highlights,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),

          Positioned(
            left: 16,
            child: IconButton(
              onPressed: () => _goTo(-1),
              icon: const Icon(Icons.chevron_left, size: 32),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                shadowColor: Colors.black26,
                elevation: 2,
              ),
            ),
          ),
          Positioned(
            right: 16,
            child: IconButton(
              onPressed: () => _goTo(1),
              icon: const Icon(Icons.chevron_right, size: 32),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                shadowColor: Colors.black26,
                elevation: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      color: const Color(0xFF001122),
      child: Column(
        children: [
          const Text(
            'Ready to take the next step?',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/admissions'),
                child: const Text('Apply Now'),
              ),
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/contact'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white70),
                ),
                child: const Text('Talk to a Counselor'),
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
    return Center(
      child: Container(
        width: 960,
        height: 380,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(color: bgColor.withOpacity(0.9)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(image, fit: BoxFit.contain, height: 200),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF002B5B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      desc,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF334155),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: highlights
                          .map((h) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: bgColor.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  h,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF002B5B),
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
      ),
    );
  }
}
