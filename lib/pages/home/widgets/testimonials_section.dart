import 'dart:async';
import 'package:flutter/material.dart';

class Testimonial {
  final String text;
  final String author;
  final int rating;

  const Testimonial({
    required this.text,
    required this.author,
    this.rating = 5,
  });
}

class TestimonialsSection extends StatefulWidget {
  final bool isMobile;

  const TestimonialsSection({super.key, required this.isMobile});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  int _currentIndex = 0;
  late final AnimationController _animController;
  Timer? _autoScrollTimer;

  final List<Testimonial> testimonials = const [
    Testimonial(
      text:
          'Incendia has transformed my child\'s learning experience. The personalized approach and dedicated teachers have helped unlock her true potential.',
      author: 'Sarah Johnson, Parent',
    ),
    Testimonial(
      text:
          'The balance between academics and life skills development is exceptional. My son has grown not just academically but as a confident individual.',
      author: 'Michael Chen, Parent',
    ),
    Testimonial(
      text:
          'The innovative teaching methods and supportive environment have made learning enjoyable for my daughter. She looks forward to school every day!',
      author: 'Emily Rodriguez, Parent',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      final nextIndex = (_currentIndex + 1) % testimonials.length;
      _goTo(nextIndex);
    });
  }

  void _pauseAutoScroll() {
    _autoScrollTimer?.cancel();
  }

  void _resumeAutoScroll() {
    _startAutoScroll();
  }

  void _goTo(int index) {
    if (!mounted) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeOutCubic,
    );
    // Note: onPageChanged will update _currentIndex when animation completes
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = widget.isMobile ? 20.0 : 40.0;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: horizontalPadding,
      ),
      color: const Color(0xFFF8F9FA),
      child: Column(
        children: [
          const Text(
            'What Parents Say',
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
                  itemCount: testimonials.length,
                  onPageChanged: (i) {
                    setState(() => _currentIndex = i);
                    // Reset auto-scroll timer when page changes
                    _startAutoScroll();
                  },
                  itemBuilder: (context, index) {
                    final t = testimonials[index];
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
                                color: const Color(
                                  0xFF002B5B,
                                ).withOpacity(0.06),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  t.rating,
                                  (_) => const Icon(
                                    Icons.star,
                                    color: Color(0xFFFF6B00),
                                    size: 22,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 360),
                                transitionBuilder: (child, anim) {
                                  return FadeTransition(
                                    opacity: anim,
                                    child: SlideTransition(
                                      position:
                                          Tween<Offset>(
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
                                  t.text,
                                  key: ValueKey(t.text),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF002B5B),
                                    fontSize: 16.5,
                                    height: 1.6,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 360),
                                child: Text(
                                  '— ${t.author}',
                                  key: ValueKey(t.author),
                                  style: const TextStyle(
                                    color: Color(0xFFFF6B00),
                                    fontWeight: FontWeight.w600,
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
                if (!widget.isMobile)
                  Positioned(
                    left: 0,
                      child: Opacity(
                      opacity: 1.0,
                      child: IconButton(
                        tooltip: 'Previous',
                        onPressed: () {
                          final prevIndex = (_currentIndex - 1 + testimonials.length) % testimonials.length;
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
                if (!widget.isMobile)
                  Positioned(
                    right: 0,
                    child: Opacity(
                      opacity: 1.0,
                      child: IconButton(
                        tooltip: 'Next',
                        onPressed: () {
                          final nextIndex = (_currentIndex + 1) % testimonials.length;
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
              testimonials.length,
              (i) => GestureDetector(
                onTap: () => _goTo(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: _currentIndex == i ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == i
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
}