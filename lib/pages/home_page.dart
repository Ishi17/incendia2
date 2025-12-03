import 'dart:async';

import 'package:flutter/material.dart';
import 'package:incendia_webpage/pages/about_page.dart';
import 'package:incendia_webpage/pages/academic.dart';
import 'package:incendia_webpage/pages/admissions_page.dart';
import 'package:incendia_webpage/pages/careers_page.dart';
import 'package:incendia_webpage/pages/contact_us_page.dart';
import 'package:incendia_webpage/pages/gallery_page.dart';
import 'package:incendia_webpage/pages/life_skills_page.dart';
import 'package:incendia_webpage/pages/schedule_page.dart';
import 'package:incendia_webpage/pages/home/widgets/cta_section.dart';
import 'package:incendia_webpage/pages/home/widgets/footer_section.dart';
import 'package:incendia_webpage/pages/home/widgets/hero_section.dart';
import 'package:incendia_webpage/pages/home/widgets/testimonials_section.dart';
import 'package:incendia_webpage/components/custom_navbar.dart';
import 'package:incendia_webpage/components/custom_drawer.dart';

// Main HomePage
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  late AnimationController _heroAnimationController;
  late AnimationController _cardAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  Timer? _popupTimer;
  bool _showUrgencyPopup = false;

  @override
  void initState() {
    super.initState();

    _heroAnimationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _cardAnimationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heroAnimationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.2), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _heroAnimationController,
            curve: Curves.easeOut,
          ),
        );

    _heroAnimationController.forward();

    _scrollController.addListener(() {
      setState(() => _isScrolled = _scrollController.offset > 50);

      if (_scrollController.offset > 150 &&
          !_cardAnimationController.isCompleted) {
        _cardAnimationController.forward();
      }
    });

    // Show the popup after the user has been on the page for a bit (desktop/tablet only)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || isMobile) return;
      _popupTimer = Timer(const Duration(seconds: 15), () {
        if (!mounted) return;
        setState(() => _showUrgencyPopup = true);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _heroAnimationController.dispose();
    _cardAnimationController.dispose();
    _popupTimer?.cancel();
    super.dispose();
  }

  bool get isMobile => MediaQuery.of(context).size.width < 768;
  bool get isTablet => MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
  bool get isDesktop => MediaQuery.of(context).size.width >= 1024;

  void _navigateTo(String pageName) {
    Widget page;
    switch (pageName.toLowerCase()) {
      case 'home':
        return; // Already on home page
      case 'about':
        page = const AboutUsPage();
        break;
      case 'academic':
        page = const AcademicPage();
        break;
      case 'life skills':
        page = const LifeSkillsPage();
        break;
      case 'schedule':
        page = const SchedulePage();
        break;
      case 'admissions':
        page = const AdmissionsPage();
        break;
      case 'gallery':
        page = const GalleryPage();
        break;
      case 'careers':
        page = const CareersPage();
        break;
      case 'contact':
        page = const ContactUsPage();
        break;
      case 'services':
      case 'services and programs':
      case 'our services and programs':
        return;
      default:
        return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void _dismissUrgencyPopup() {
    if (!_showUrgencyPopup) return;
    _popupTimer?.cancel();
    setState(() => _showUrgencyPopup = false);
  }

  void _handlePopupCta() {
    _dismissUrgencyPopup();
    _navigateTo('Admissions');
  }

  void _showConsultationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _ConsultationDialog(isMobile: isMobile);
      },
    );
  }

  Widget _buildServicesPreview({required bool isMobile}) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 20 : 40,
      ),
      color: const Color(0xFFF8F9FA),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: [
          _ServicePreviewCard(
            item: {
              'icon': Icons.person,
              'title': 'Personalized Learning',
              'desc': 'Tailored curriculum for individual needs',
              'category': 'Service',
              'color': const Color(0xFFFF6B00),
            },
            isMobile: isMobile,
          ),
          _ServicePreviewCard(
            item: {
              'icon': Icons.book,
              'title': 'Academic Mastery',
              'desc': 'Board-wise curriculum',
              'category': 'Program',
              'color': const Color(0xFF4CAF50),
            },
            isMobile: isMobile,
          ),
          _ServicePreviewCard(
            item: {
              'icon': Icons.psychology,
              'title': 'Life Skills',
              'desc': 'Critical thinking & communication',
              'category': 'Program',
              'color': const Color(0xFF2196F3),
            },
            isMobile: isMobile,
          ),
          _ServicePreviewCard(
            item: {
              'icon': Icons.computer,
              'title': 'Modern Technology',
              'desc': 'Cutting-edge learning tools',
              'category': 'Service',
              'color': const Color(0xFFFF6B00),
            },
            isMobile: isMobile,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavbar(
        isScrolled: _isScrolled,
        onConsultationPressed: _showConsultationDialog,
      ),
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(
                  isMobile: isMobile,
                  fadeAnimation: _fadeAnimation,
                  slideAnimation: _slideAnimation,
                  navigateTo: _navigateTo,
                  onConsultationPressed: _showConsultationDialog,
                  shouldStartCounting: true,
                ),
                _IncendiaDifferenceSection(isMobile: isMobile),
                TestimonialsSection(isMobile: isMobile),
                CtaSection(
                  isMobile: isMobile,
                  navigateTo: _navigateTo,
                  onConsultationPressed: _showConsultationDialog,
                ),
                FooterSection(isMobile: isMobile),
              ],
            ),
          ),
          if (_showUrgencyPopup && !isMobile)
            Positioned.fill(
              child: _UrgencyPopup(
                isMobile: isMobile,
                onClose: _dismissUrgencyPopup,
                onAction: _handlePopupCta,
              ),
            ),
        ],
      ),
    );
  }


  // Extracted to ServicesSection widget (widgets/services_section.dart)

// Extracted to OfferingsSection widget (widgets/offerings_section.dart)

// Extracted to StatsSection widget (widgets/stats_section.dart)

// Extracted to TestimonialsSection widget (widgets/testimonials_section.dart)

// Extracted to CtaSection widget (widgets/cta_section.dart)
}

class _IncendiaDifferenceSection extends StatelessWidget {
  final bool isMobile;

  const _IncendiaDifferenceSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final cardWidth = isMobile ? double.infinity : 600.0;
    final qualitiesTraditional = [
      'Focuses solely on academics',
      'Rigid, one-size-fits-all approach',
      'Limited preparation for life beyond school',
    ];
    final qualitiesIncendia = [
      'Balanced development of academics and life skills',
      'Engaging, personalized learning experience',
      'Holistic preparation for future success',
    ];

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF102A45), Color(0xFF14365C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 56,
        horizontal: isMobile ? 16 : 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'The Incendia Difference',
            style: TextStyle(
              fontSize: isMobile ? 28 : 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 18 : 26),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: isMobile ? 14 : 100,
            runSpacing: isMobile ? 16 : 24,
            children: [
              _ComparisonCard(
                title: 'Traditional Tuition',
                subtitle: 'What most centers offer',
                gradientColors: const [Color(0xFF1A365D), Color(0xFF23497A)],
                textColor: Colors.white,
                items: qualitiesTraditional,
                width: cardWidth,
              ),
              _ComparisonCard(
                title: 'Incendia',
                subtitle: 'Where future-ready learners grow',
                gradientColors: const [Color(0xFF1A365D), Color(0xFF23497A)],
                textColor: Colors.white,
                items: qualitiesIncendia,
                width: cardWidth,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final Color textColor;
  final List<String> items;
  final double width;

  const _ComparisonCard({
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    required this.textColor,
    required this.items,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      constraints: const BoxConstraints(minHeight: 220),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: textColor.withOpacity(0.9),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13.5,
              color: textColor.withOpacity(0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: textColor.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UrgencyPopup extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onClose;
  final VoidCallback onAction;

  const _UrgencyPopup({
    required this.isMobile,
    required this.onClose,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: 1,
      child: GestureDetector(
        onTap: onClose,
        behavior: HitTestBehavior.opaque,
        child: Container(
          color: Colors.black.withOpacity(0.55),
          child: Center(
            child: GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.translucent,
              child: SafeArea(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isMobile ? 340 : 420,
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(24),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 20 : 28,
                        vertical: isMobile ? 20 : 24,
                      ),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF002B5B), Color(0xFF001735)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.local_fire_department,
                                  color: Color(0xFFFF6B00),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: onClose,
                                icon: const Icon(Icons.close, color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Only 2 seats left!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobile ? 22 : 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Secure your child’s seat in the upcoming batch before enrollment closes.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: isMobile ? 14 : 16,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: onAction,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFF6B00),
                                    padding: EdgeInsets.symmetric(
                                      vertical: isMobile ? 14 : 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Text(
                                    'Secure Seat',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              TextButton(
                                onPressed: onClose,
                                child: Text(
                                  'Maybe Later',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ServicePreviewCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final bool isMobile;

  const _ServicePreviewCard({
    required this.item,
    required this.isMobile,
  });

  @override
  State<_ServicePreviewCard> createState() => _ServicePreviewCardState();
}

class _ServicePreviewCardState extends State<_ServicePreviewCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showItemDialog() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Service detail',
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: _ServiceItemDialog(item: widget.item),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curvedAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.08),
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.9, end: 1.0).animate(curvedAnimation),
              child: child,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.item['color'] as Color;
    final icon = widget.item['icon'] as IconData;
    final title = widget.item['title'] as String;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: InkWell(
            onTap: _showItemDialog,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: widget.isMobile ? 150 : 180,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: color.withOpacity(0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF002B5B),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ServiceItemDialog extends StatelessWidget {
  final Map<String, dynamic> item;

  const _ServiceItemDialog({required this.item});

  @override
  Widget build(BuildContext context) {
    // Get detailed content for each item
    String getDetailedContent(String title) {
      switch (title) {
        case 'Academic Mastery':
          return 'Our comprehensive academic programs cover all major educational boards including CBSE, ICSE, and State boards. We provide structured learning paths with regular assessments, mock tests, and personalized feedback to ensure academic excellence and board exam success.';
        case 'Life Skills':
          return 'Beyond academics, we focus on developing essential life skills including critical thinking, communication, leadership, and emotional intelligence. These skills prepare students for real-world challenges and help them become well-rounded individuals ready for future success.';
        case 'Exam Prep':
          return 'Focused preparation for board exams, competitive tests, and entrance examinations. Our exam prep program includes mock tests, time management strategies, and personalized study plans to help students achieve their best results.';
        case 'Career Guidance':
          return 'Expert career counseling and guidance to help students explore career paths, understand industry requirements, and make informed decisions about their future. We provide resume building, interview preparation, and career readiness support.';
        default:
          return item['desc'] as String;
      }
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 20,
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Color(0xFFF8F9FA)],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: (item['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: item['color'] as Color,
                size: 35,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              item['title'] as String,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF002B5B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: (item['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item['category'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: item['color'] as Color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              getDetailedContent(item['title'] as String),
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF666666),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: item['color'] as Color,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Got it!',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConsultationDialog extends StatefulWidget {
  final bool isMobile;

  const _ConsultationDialog({
    required this.isMobile,
  });

  @override
  State<_ConsultationDialog> createState() => _ConsultationDialogState();
}

class _ConsultationDialogState extends State<_ConsultationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      
      // Simulate API call
      Future.delayed(const Duration(seconds: 1), () {
        if (!mounted) return;
        setState(() => _isSubmitting = false);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Thank you! We will contact you soon.'),
            backgroundColor: Color(0xFF002B5B),
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: widget.isMobile ? 340 : 420,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF002B5B), Color(0xFF001735)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 20 : 28,
            vertical: widget.isMobile ? 20 : 24,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.calendar_today,
                        color: Color(0xFFFF6B00),
                        size: 24,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.white),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Book your free consultation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.isMobile ? 22 : 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Fill in your details and we\'ll get back to you shortly.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: widget.isMobile ? 14 : 16,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF6B00),
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                    hintText: 'Enter your phone number',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    prefixIcon: Icon(
                      Icons.phone_outlined,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF6B00),
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.trim().length < 10) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFFF6B00),
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B00),
                      padding: EdgeInsets.symmetric(
                        vertical: widget.isMobile ? 14 : 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      disabledBackgroundColor: const Color(0xFFFF6B00).withOpacity(0.6),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// // About Page
// class AboutPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('About Incendia', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: Color(0xFF002B5B),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Color(0xFF002B5B), Color(0xFF004080)]),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Icon(Icons.school, size: 60, color: Color(0xFFFF6B00)),
//                   SizedBox(height: 20),
//                   Text(
//                     'About Incendia',
//                     style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Transforming Education Since 2009',
//                     style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.8)),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             _buildSection('Our Mission', 
//               'To empower every student with comprehensive education that combines academic excellence with essential life skills, preparing them for future success in an ever-evolving world.'),
//             _buildSection('Our Vision', 
//               'To be the leading educational institution that transforms learning experiences through innovative teaching methods, personalized attention, and holistic development.'),
//             _buildSection('Our Values', '''
// • Excellence in Education
// • Personalized Learning Approach
// • Innovation in Teaching Methods
// • Character Development
// • Community Engagement
// • Lifelong Learning'''),
//             SizedBox(height: 20),
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(25),
//               decoration: BoxDecoration(
//                 color: Color(0xFFF8F9FA),
//                 borderRadius: BorderRadius.circular(15),
//                 border: Border.all(color: Color(0xFFFF6B00).withOpacity(0.2)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Why Choose Incendia?',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF002B5B)),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     '✓ 15+ years of educational excellence\n✓ 10,000+ successful students\n✓ 95% success rate in board examinations\n✓ Expert faculty with proven track record\n✓ Modern infrastructure and technology\n✓ Personalized attention for every student\n✓ Comprehensive life skills development\n✓ Strong parent-teacher collaboration',
//                     style: TextStyle(fontSize: 16, color: Color(0xFF666666), height: 1.8),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSection(String title, String content) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 25),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF002B5B)),
//           ),
//           SizedBox(height: 10),
//           Text(
//             content,
//             style: TextStyle(fontSize: 16, color: Color(0xFF666666), height: 1.6),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Academic Page
// class AcademicPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Academic Programs', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: Color(0xFF002B5B),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Color(0xFF002B5B), Color(0xFF004080)]),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Icon(Icons.book, size: 60, color: Color(0xFFFF6B00)),
//                   SizedBox(height: 20),
//                   Text(
//                     'Academic Excellence',
//                     style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             _buildAcademicCard('CBSE Curriculum', 'Classes 6-12', 
//               'Comprehensive CBSE curriculum with focus on conceptual learning and board exam preparation.'),
//             _buildAcademicCard('ICSE Curriculum', 'Classes 6-12', 
//               'Detailed ICSE syllabus coverage with emphasis on language skills and analytical thinking.'),
//             _buildAcademicCard('State Board', 'Classes 6-12', 
//               'State board preparation with local language support and cultural integration.'),
//             _buildAcademicCard('Competitive Exams', 'JEE/NEET/Others', 
//               'Specialized coaching for engineering and medical entrance examinations.'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAcademicCard(String title, String subtitle, String description) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20),
//       padding: EdgeInsets.all(25),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Color(0xFFFF6B00).withOpacity(0.2)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFFF6B00).withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(Icons.school, color: Color(0xFFFF6B00), size: 28),
//               ),
//               SizedBox(width: 15),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF002B5B)),
//                     ),
//                     Text(
//                       subtitle,
//                       style: TextStyle(fontSize: 16, color: Color(0xFFFF6B00), fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 15),
//           Text(
//             description,
//             style: TextStyle(fontSize: 16, color: Color(0xFF666666), height: 1.5),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Life Skills Page
// class LifeSkillsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Life Skills', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: Color(0xFF002B5B),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Color(0xFF002B5B), Color(0xFF004080)]),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Icon(Icons.psychology, size: 60, color: Color(0xFFFF6B00)),
//                   SizedBox(height: 20),
//                   Text(
//                     'Life Skills Development',
//                     style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             _buildSkillCard('Communication Skills', Icons.chat_bubble_outline, 
//               'Develop effective verbal and written communication abilities for personal and professional success.'),
//             _buildSkillCard('Critical Thinking', Icons.lightbulb_outline, 
//               'Enhance analytical and problem-solving skills to make informed decisions.'),
//             _buildSkillCard('Leadership', Icons.person_outline, 
//               'Build leadership qualities and learn to inspire and motivate others.'),
//             _buildSkillCard('Time Management', Icons.schedule, 
//               'Master the art of managing time effectively and prioritizing tasks.'),
//             _buildSkillCard('Emotional Intelligence', Icons.favorite_outline, 
//               'Develop self-awareness and empathy to build better relationships.'),
//             _buildSkillCard('Digital Literacy', Icons.computer, 
//               'Stay updated with technology and digital tools for modern learning.'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSkillCard(String title, IconData icon, String description) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20),
//       padding: EdgeInsets.all(25),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Color(0xFFFF6B00).withOpacity(0.2)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [Color(0xFFFF6B00), Color(0xFFFF8533)]),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Icon(icon, color: Colors.white, size: 30),
//           ),
//           SizedBox(width: 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF002B5B)),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   description,
//                   style: TextStyle(fontSize: 14, color: Color(0xFF666666), height: 1.5),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Schedule Page
// class SchedulePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Schedule', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: Color(0xFF002B5B),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Color(0xFF002B5B), Color(0xFF004080)]),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Icon(Icons.schedule, size: 60, color: Color(0xFFFF6B00)),
//                   SizedBox(height: 20),
//                   Text(
//                     'Class Schedule',
//                     style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             _buildScheduleCard('Morning Batch', '8:00 AM - 12:00 PM', 
//               'Perfect for early risers with fresh minds ready to learn.'),
//             _buildScheduleCard('Afternoon Batch', '1:00 PM - 5:00 PM', 
//               'Ideal timing for students comfortable with afternoon sessions.'),
//             _buildScheduleCard('Evening Batch', '6:00 PM - 9:00 PM', 
//               'Convenient for working students and after school hours.'),
//             _buildScheduleCard('Weekend Classes', 'Saturday & Sunday', 
//               'Special weekend batches for comprehensive revision and practice.'),
//             Container(
//               margin: EdgeInsets.only(top: 20),
//               padding: EdgeInsets.all(25),
//               decoration: BoxDecoration(
//                 color: Color(0xFFF8F9FA),
//                 borderRadius: BorderRadius.circular(15),
//                 border: Border.all(color: Color(0xFFFF6B00).withOpacity(0.2)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Additional Information',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF002B5B)),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     '• Flexible batch timings available\n• Small class sizes for personalized attention\n• Make-up classes for missed sessions\n• Online and offline options available',
//                     style: TextStyle(fontSize: 16, color: Color(0xFF666666), height: 1.6),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildScheduleCard(String title, String time, String description) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20),
//       padding: EdgeInsets.all(25),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Color(0xFFFF6B00).withOpacity(0.2)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: [Color(0xFFFF6B00), Color(0xFFFF8533)]),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(Icons.access_time, color: Colors.white, size: 28),
//               ),
//               SizedBox(width: 15),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF002B5B)),
//                     ),
//                     Text(
//                       time,
//                       style: TextStyle(fontSize: 16, color: Color(0xFFFF6B00), fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 15),
//           Text(
//             description,
//             style: TextStyle(fontSize: 16, color: Color(0xFF666666), height: 1.5),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Admissions Page
// class AdmissionsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admissions', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         backgroundColor: Color(0xFF002B5B),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Color(0xFF002B5B), Color(0xFF004080)]),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Icon(Icons.how_to_reg, size: 60, color: Color(0xFFFF6B00)),
//                   SizedBox(height: 20),
//                   Text(
//                     'Admissions Open',
//                     style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Join the Incendia Family Today!',
//                     style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.8)),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             _buildAdmissionCard('Step 1', 'Fill Application Form', 
//               'Complete our online application form with student details and academic history.'),
//             _buildAdmissionCard('Step 2', 'Document Submission', 
//               'Submit required documents including previous academic records and ID proof.'),
//             _buildAdmissionCard('Step 3', 'Assessment Test', 
//               'Appear for a simple assessment test to determine the appropriate learning level.'),
//             _buildAdmissionCard('Step 4', 'Counseling Session', 
//               'Meet with our counselors to discuss goals and choose the right program.'),
//             _buildAdmissionCard('Step 5', 'Fee Payment', 
//               'Complete the admission process with fee payment and receive confirmation.'),
//             Container(
//               margin: EdgeInsets.only(top: 20),
//               padding: EdgeInsets.all(25),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Color(0xFFFF6B00), Color(0xFFFF8533)]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Column(
//                 children: [
//                   Text(
//                     'Ready to Start?',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Contact us today for admission assistance',
//                     style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9)),
//                   ),
//                   SizedBox(height: 15),
//                   ElevatedButton(
//                     onPressed: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Admission form will open soon!')),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//                     ),
//                     child: Text(
//                       'Apply Now',
//                       style: TextStyle(color: Color(0xFF002B5B), fontWeight: FontWeight.bold, fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAdmissionCard(String step, String title, String description) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 20),
//       padding: EdgeInsets.all(25),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Color(0xFFFF6B00).withOpacity(0.2)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [Color(0xFFFF6B00), Color(0xFFFF8533)]),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Center(
//               child: Text(
//                 step.split(' ')[1],
//                 style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           SizedBox(width: 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF002B5B)),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   description,
//                   style: TextStyle(fontSize: 14, color: Color(0xFF666666), height: 1.5),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
