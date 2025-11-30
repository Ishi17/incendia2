import 'dart:async';
import 'package:flutter/material.dart';
import 'package:incendia_webpage/components/custom_drawer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../components/custom_navbar.dart';

class AdmissionsPage extends StatefulWidget {
  const AdmissionsPage({super.key});

  @override
  _AdmissionsPageState createState() => _AdmissionsPageState();
}

class _AdmissionsPageState extends State<AdmissionsPage> {
  int _currentPage = 0;
  late final PageController _pageController;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      final nextIndex = (_currentPage + 1) % benefits.length;
      _goTo(nextIndex);
    });
  }

  void _goTo(int index) {
    if (!mounted) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeOutCubic,
    );
  }

  final List<Map<String, String>> benefits = [
    {
      'title': 'Real-World Skills',
      'desc':
          'Gain financial literacy, communication, and problem-solving abilities.',
    },
    {
      'title': 'Student-Centered',
      'desc':
          'Our program is designed to be interactive, inclusive, and empowering.',
    },
    {
      'title': 'Future Readiness',
      'desc': 'We prepare students for careers, relationships, and adult life.',
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
      appBar: CustomNavbar.withAnnouncement(
        title: 'How to Apply',
        showBackButton: true,
      ),
      drawer: CustomDrawer(),
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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final horizontalPadding = isMobile ? 20.0 : 40.0;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: horizontalPadding,
      ),
      color: const Color(0xFFF8F9FA),
      child: Column(
        children: [
          const Text(
            'Why Join Incendia',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF002B5B),
            ),
          ),
          const SizedBox(height: 28),

          // Carousel area
          SizedBox(
            height: 280,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: benefits.length,
                  onPageChanged: (i) {
                    setState(() => _currentPage = i);
                    // Reset auto-scroll timer when page changes
                    _startAutoScroll();
                  },
                  itemBuilder: (context, index) {
                    final item = benefits[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.96, end: 1.0),
                        duration: const Duration(milliseconds: 420),
                        curve: Curves.easeOutCubic,
                        builder: (context, scale, child) {
                          return Transform.scale(scale: scale, child: child);
                        },
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 900),
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF002B5B).withOpacity(0.06),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon or visual element
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF6B00).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFFFF6B00),
                                  size: 30,
                                ),
                              ),
                              const SizedBox(height: 20),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 360),
                                transitionBuilder: (child, anim) {
                                  return FadeTransition(
                                    opacity: anim,
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0, 0.03),
                                        end: Offset.zero,
                                      ).animate(
                                        CurvedAnimation(
                                          parent: anim,
                                          curve: Curves.easeOutCubic,
                                        ),
                                      ),
                                      child: child,
                                    ),
                                  );
                                },
                                child: Text(
                                  item['title']!,
                                  key: ValueKey(item['title']!),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF002B5B),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 360),
                                child: Text(
                                  item['desc']!,
                                  key: ValueKey(item['desc']!),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF002B5B),
                                    fontSize: 16.5,
                                    height: 1.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Left arrow (desktop only)
                if (!isMobile)
                  Positioned(
                    left: 0,
                    child: Opacity(
                      opacity: 1.0,
                      child: IconButton(
                        tooltip: 'Previous',
                        onPressed: () {
                          final prevIndex = (_currentPage - 1 + benefits.length) % benefits.length;
                          _goTo(prevIndex);
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 18,
                            color: Color(0xFF002B5B),
                          ),
                        ),
                      ),
                    ),
                  ),

                // Right arrow (desktop only)
                if (!isMobile)
                  Positioned(
                    right: 0,
                    child: Opacity(
                      opacity: 1.0,
                      child: IconButton(
                        tooltip: 'Next',
                        onPressed: () {
                          final nextIndex = (_currentPage + 1) % benefits.length;
                          _goTo(nextIndex);
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                            color: Color(0xFF002B5B),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              benefits.length,
              (i) => GestureDetector(
                onTap: () => _goTo(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: _currentPage == i ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? const Color(0xFFFF6B00)
                        : const Color(0xFFCCCCCC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhoCanApplyCards() {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24.0 : 40.0,
        vertical: 40.0,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 700),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Who Can Apply?',
                style: TextStyle(
                  fontSize: isMobile ? 26 : 32,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF002B5B),
                ),
              ),
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(isMobile ? 28 : 36),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xFF002B5B).withOpacity(0.1),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF002B5B).withOpacity(0.08),
                      blurRadius: 24,
                      offset: Offset(0, 8),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon
                    Container(
                      width: isMobile ? 50 : 60,
                      height: isMobile ? 50 : 60,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF6B00).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.school,
                        color: Color(0xFFFF6B00),
                        size: isMobile ? 26 : 30,
                      ),
                    ),
                    SizedBox(width: 20),
                    // Content
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 18,
                            color: Color(0xFF002B5B),
                            height: 1.6,
                          ),
                          children: [
                            TextSpan(
                              text: 'We welcome students from ',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            TextSpan(
                              text: 'Grades 9 to 12 across all boards',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF002B5B),
                              ),
                            ),
                            TextSpan(
                              text: '. Limited seats ensure ',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            TextSpan(
                              text: 'personalized attention',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFF6B00),
                              ),
                            ),
                            TextSpan(
                              text: ' in every classroom.',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildAdmissionFlowchart() {
    final List<Map<String, dynamic>> steps = [
      {
        'step': '1',
        'title': 'Submit Application',
        'desc': 'Complete our online application form with your academic background and goals',
        'color': Color(0xFF1976D2), // Medium blue
      },
      {
        'step': '2',
        'title': 'Assessment Test',
        'desc': 'Take our comprehensive assessment to determine your current skill level',
        'color': Color(0xFF1565C0), // Deeper blue
      },
      {
        'step': '3',
        'title': 'Interview',
        'desc': 'Meet with our academic advisor to discuss your learning objectives.',
        'color': Color(0xFF0D47A1), // Darkest blue
      },
      {
        'step': '4',
        'title': 'Enrollment',
        'desc': 'Receive your acceptance and begin your personalized learning journey.',
        'color': Color(0xFFFF6B00), // Orange
      },
    ];

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Admissions Process',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF002B5B),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                'Follow these simple steps to begin your educational journey with us',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48),
              // Horizontal flow with connecting line
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;
                  final isTablet = constraints.maxWidth < 900;
                  
                  if (isMobile) {
                    // Stack vertically on mobile with connecting lines
                    return Column(
                      children: List.generate(steps.length, (index) {
                        final step = steps[index];
                        final isLast = index == steps.length - 1;
                        
                        return Column(
                          children: [
                            _buildStepCard(
                              step: step['step']!,
                              title: step['title']!,
                              desc: step['desc']!,
                              circleColor: step['color'] as Color,
                              isMobile: true,
                            ),
                            if (!isLast) ...[
                              SizedBox(height: 12),
                              Container(
                                width: 2,
                                height: 24,
                                color: Color(0xFF002B5B).withOpacity(0.25),
                              ),
                              SizedBox(height: 12),
                            ],
                          ],
                        );
                      }),
                    );
                  }
                  
                  // Horizontal flow for desktop/tablet
                  return SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        // Horizontal connecting line - clean and straight
                        Positioned(
                          top: 50, // Center of the circles
                          left: 50,
                          right: 50,
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                              color: Color(0xFF002B5B).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        // Steps row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(steps.length, (index) {
                            final step = steps[index];
                            
                            return Expanded(
                              child: _buildStepCard(
                                step: step['step']!,
                                title: step['title']!,
                                desc: step['desc']!,
                                circleColor: step['color'] as Color,
                                isMobile: false,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 64),
              // Timeframes section - clean and neat box
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 32),
                decoration: BoxDecoration(
                  color: Color(0xFFE8F4F8), // Light blue
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xFF002B5B).withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 600;
                    
                    if (isMobile) {
                      return Column(
                        children: [
                          _buildTimeframeItem('24–48hrs', 'Application Review Time', isMobile),
                          SizedBox(height: 32),
                          _buildTimeframeItem('90min', 'Assessment Duration', isMobile),
                          SizedBox(height: 32),
                          _buildTimeframeItem('7 days', 'Complete Process', isMobile),
                        ],
                      );
                    }
                    
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: _buildTimeframeItem('24–48hrs', 'Application Review Time', isMobile)),
                        Container(
                          width: 1,
                          height: 70,
                          color: Color(0xFF002B5B).withOpacity(0.15),
                        ),
                        Expanded(child: _buildTimeframeItem('90min', 'Assessment Duration', isMobile)),
                        Container(
                          width: 1,
                          height: 70,
                          color: Color(0xFF002B5B).withOpacity(0.15),
                        ),
                        Expanded(child: _buildTimeframeItem('7 days', 'Complete Process', isMobile)),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepCard({
    required String step,
    required String title,
    required String desc,
    required Color circleColor,
    required bool isMobile,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isMobile ? 70 : 100,
          height: isMobile ? 70 : 100,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: circleColor.withOpacity(0.4),
                blurRadius: 12,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              step,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 28 : 36,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: isMobile ? 17 : 19,
            fontWeight: FontWeight.bold,
            color: Color(0xFF002B5B),
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 4 : 12),
          child: Text(
            desc,
            style: TextStyle(
              fontSize: isMobile ? 12 : 13,
              color: Colors.grey[600],
              height: 1.4,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeframeItem(String time, String label, bool isMobile) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          time,
          style: TextStyle(
            fontSize: isMobile ? 32 : 36,
            fontWeight: FontWeight.w900,
            color: Color(0xFF002B5B),
            letterSpacing: -0.5,
            height: 1.0,
          ),
        ),
        SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: isMobile ? 14 : 15,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
       
  Widget _buildRegistrationForm() {
    final timingOptions = [
      'Weekdays: Morning (8am-11am)',
      'Weekdays: Afternoon (12pm-4pm)',
      'Weekdays: Evening (5pm-8pm)',
      'Weekends: Morning (9am-12pm)',
      'Weekends: Afternoon (1pm-4pm)',
    ];

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
          _TimingMultiSelect(options: timingOptions),
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
      child: _HoverableAdmissionField(label: label, maxLines: maxLines),
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

class _TimingMultiSelect extends StatefulWidget {
  final List<String> options;

  const _TimingMultiSelect({required this.options});

  @override
  State<_TimingMultiSelect> createState() => _TimingMultiSelectState();
}

class _TimingMultiSelectState extends State<_TimingMultiSelect> {
  final List<String> _selected = [];

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Preferred Timing (multi-select)',
          border: baseBorder,
          enabledBorder: baseBorder,
          focusedBorder: baseBorder.copyWith(
            borderSide: const BorderSide(color: Color(0xFF002B5B), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(
              _selected.isEmpty ? 'Select one or more' : _selected.join(', '),
              style: const TextStyle(color: Color(0xFF002B5B)),
            ),
            icon: const Icon(Icons.expand_more, color: Color(0xFF002B5B)),
            items: widget.options
                .map(
                  (opt) => DropdownMenuItem<String>(
                    value: opt,
                    child: Row(
                      children: [
                        Checkbox(
                          value: _selected.contains(opt),
                          activeColor: const Color(0xFF002B5B),
                          onChanged: (_) => _toggleSelection(opt),
                        ),
                        Flexible(
                          child: Text(
                            opt,
                            style: const TextStyle(color: Color(0xFF1A202C)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) _toggleSelection(value);
            },
          ),
        ),
      ),
    );
  }

  void _toggleSelection(String option) {
    setState(() {
      if (_selected.contains(option)) {
        _selected.remove(option);
      } else {
        _selected.add(option);
      }
    });
  }
}

class _HoverableAdmissionField extends StatefulWidget {
  final String label;
  final int maxLines;

  const _HoverableAdmissionField({
    required this.label,
    this.maxLines = 1,
  });

  @override
  State<_HoverableAdmissionField> createState() => _HoverableAdmissionFieldState();
}

class _HoverableAdmissionFieldState extends State<_HoverableAdmissionField> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextField(
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: const Icon(Icons.star, color: Colors.redAccent, size: 12),
          border: baseBorder,
          enabledBorder: baseBorder,
          focusedBorder: baseBorder.copyWith(
            borderSide: const BorderSide(color: Color(0xFF002B5B), width: 2),
          ),
          filled: true,
          fillColor: _isHovered ? Colors.grey.shade100 : Colors.white,
        ),
      ),
    );
  }
}
