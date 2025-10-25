import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AdmissionsPage extends StatefulWidget {
  const AdmissionsPage({super.key});

  @override
  _AdmissionsPageState createState() => _AdmissionsPageState();
}

class _AdmissionsPageState extends State<AdmissionsPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: 0.8);

  void _scrollToNextCard(int totalPages) {
    setState(() {
      _currentPage = (_currentPage + 1) % totalPages;
    });
    _pageController.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  final List<Map<String, String>> benefits = [
    {
      'title': 'Real-World Skills',
      'desc': 'Gain financial literacy, communication, and problem-solving abilities.',
    },
    {
      'title': 'Student-Centered',
      'desc': 'Our program is designed to be interactive, inclusive, and empowering.',
    },
    {
      'title': 'Future Readiness',
      'desc': 'We prepare students for careers, relationships, and adult life.',
    },
    {
      'title': 'Expert Mentors',
      'desc': 'Guidance from experienced educators who care deeply about growth.',
    },
    {
      'title': 'Small Batch Sizes',
      'desc': 'Get personalized attention and peer interaction that matters.',
    },
    {
      'title': 'Holistic Development',
      'desc': 'Focus on emotional, social, and cognitive growth equally.',
    },
  ];

  final List<String> targetGroups = [
    'High School Students',
    'Parents of Teens',
    'Educators & Counselors',
  ];

  final List<Map<String, String>> steps = [
    {'step': '1', 'text': 'Explore Courses'},
    {'step': '2', 'text': 'Fill Application Form'},
    {'step': '3', 'text': 'Attend Orientation'},
    {'step': '4', 'text': 'Begin Your Journey'},
  ];

  final List<Map<String, String>> faqs = [
    {
      'question': 'Who can apply?',
      'answer':
          'Students aged 12–18, parents, and educators can enroll in our programs.',
    },
    {
      'question': 'Are the courses online or offline?',
      'answer': 'We offer both online modules and in-person workshops.',
    },
    {
      'question': 'Is there a fee?',
      'answer':
          'Some programs are free; others have nominal fees based on duration.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admissions'),
        backgroundColor: Color(0xFF002B5B),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeroBanner(),
              _buildWhyJoinCarousel(),
              _buildWhoCanApplyCards(),
              _buildAdmissionFlowchart(),
              _buildRegistrationForm(),
              _buildFAQs(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: Color(0xFF002B5B),
      child: Center(
        // centers the Column itself
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // centers children inside column
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ready to Transform Your Future?',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center, // centers the text
            ),
            SizedBox(height: 16),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Build Confidence.',
                  textStyle: TextStyle(fontSize: 20, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                TypewriterAnimatedText(
                  'Learn Real-Life Skills.',
                  textStyle: TextStyle(fontSize: 20, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                TypewriterAnimatedText(
                  'Become Future-Ready.',
                  textStyle: TextStyle(fontSize: 20, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ],
              repeatForever: true,
              pause: Duration(milliseconds: 1500),
              isRepeatingAnimation: true,
            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildWhyJoinCarousel() {
    final Color accentColor = Color(0xFFFF6B00); // Incendia brand orange
    final int cardsPerPage = 3;
    final int totalPages = (benefits.length / cardsPerPage).ceil();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Why Join Incendia',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'At Incendia, we don’t just offer tuition — we build confidence, clarity, and capability.',
            style: TextStyle(color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),

          // 🔁 Horizontal PageView with 3 cards per page
          SizedBox(
            height: 260,
            child: PageView.builder(
              controller: _pageController,
              itemCount: totalPages,
              itemBuilder: (context, pageIndex) {
                int start = pageIndex * cardsPerPage;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(cardsPerPage, (i) {
                    int cardIndex = start + i;
                    if (cardIndex >= benefits.length) return Expanded(child: SizedBox());
                    final item = benefits[cardIndex];
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                          border: Border.all(color: accentColor.withOpacity(0.2)),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.school, size: 32, color: accentColor),
                            SizedBox(height: 12),
                            Text(
                              item['title']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Text(
                              item['desc']!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),

          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => _scrollToNextCard(totalPages),
              icon: Text("Next", style: TextStyle(color: accentColor)),
              label: Icon(Icons.arrow_forward, color: accentColor),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildWhoCanApplyCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Who Can Apply?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.deepPurple.shade100),
            ),
            padding: EdgeInsets.all(20),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[800],
                  height: 1.5,
                ),
                children: [
                  TextSpan(text: 'We welcome students from '),
                  TextSpan(
                    text: 'Grades 9 to 12 across all boards',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: '. Limited seats ensure '),
                  TextSpan(
                    text: 'personalized attention',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: ' in every classroom.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdmissionFlowchart() {
    final List<Map<String, String>> steps = [
      {
        'step': '1',
        'title': 'Submit Enquiry',
        'desc': 'Fill out the form below or call us directly.',
      },
      {
        'step': '2',
        'title': 'Free Consultation',
        'desc': 'Our academic counselor will understand your needs.',
      },
      {
        'step': '3',
        'title': 'Batch Allocation',
        'desc':
            'We suggest the right batch and schedule based on your board and grade.',
      },
      {
        'step': '4',
        'title': 'Registration & Fees',
        'desc':
            'Once finalized, complete the registration and pay the fees to confirm your seat.',
      },
    ];

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Admission Process',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Column(
                children: List.generate(steps.length, (index) {
                  final step = steps[index];
                  final isLast = index == steps.length - 1;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left column: avatar and vertical line
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            radius: 16,
                            child: Text(
                              step['step']!,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          if (!isLast)
                            Container(
                              width: 2,
                              height: 60,
                              color: Colors.deepPurple.shade200,
                            ),
                        ],
                      ),
                      SizedBox(width: 16),
                      // Right column: title and description
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4), // aligns with top of avatar
                            Text(
                              step['title']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              step['desc']!,
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
       
  Widget _buildRegistrationForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Enquiry / Registration Form',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _requiredField('Student’s Name'),
          _requiredField('Grade'),
          _requiredField('Board'),
          _requiredField('Parent’s Name'),
          _requiredField('Contact'),
          _requiredField('Preferred Timing to call (Weekday/Weekend)'),
          _requiredField('Subjects'),
          _requiredField('Message or Comments', maxLines: 3),
          SizedBox(height: 16),
          ElevatedButton(onPressed: () {}, child: Text('Submit')),
        ],
      ),
    );
  }

  Widget _requiredField(String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.star, color: Colors.redAccent, size: 12),
        ),
      ),
    );
  }

  Widget _buildFAQs() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'FAQs',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          ...faqs.map(
            (faq) => ExpansionTile(
              title: Text(faq['question']!),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(faq['answer']!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: Colors.grey.shade200,
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Text('Contact Us', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('info@lifeskills.org | +91 98765 43210'),
          SizedBox(height: 12),
          Text('© 2025 Life Skills Program'),
        ],
      ),
    );
  }
}
