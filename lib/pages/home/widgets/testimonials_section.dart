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
  late PageController _pageController;
  int _currentIndex = 0;
  late final AnimationController _animController;
  Timer? _autoScrollTimer;

  double get _viewportFraction => widget.isMobile ? 0.92 : 0.32;

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
    Testimonial(
      text:
          'What stood out for us was the consistent feedback loop. We always know where our son is excelling and where he needs support, without any surprises.',
      author: 'Anita Sharma, Parent',
    ),
    Testimonial(
      text:
          'Incendia blends academics with life skills in a way that feels practical. My daughter has become more confident in presentations and teamwork.',
      author: 'Ravi Mehta, Parent',
    ),
    Testimonial(
      text:
          'The mentors genuinely care. They check in regularly, adapt lessons, and keep my child motivated—it feels like a true partnership.',
      author: 'Lena Matthews, Parent',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: _viewportFraction);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _startAutoScroll();
  }

  @override
  void didUpdateWidget(covariant TestimonialsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isMobile != oldWidget.isMobile) {
      final oldController = _pageController;
      _pageController = PageController(
        viewportFraction: _viewportFraction,
        initialPage: _currentIndex,
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _pageController.jumpToPage(_currentIndex);
        }
      });
      oldController.dispose();
    }
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
            height: widget.isMobile ? 280 : 300,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: _pageController,
                  padEnds: false,
                  clipBehavior: Clip.none,
                  itemCount: testimonials.length,
                  onPageChanged: (i) {
                    setState(() => _currentIndex = i);
                    // Reset auto-scroll timer when page changes
                    _startAutoScroll();
                  },
                  itemBuilder: (context, index) {
                    final t = testimonials[index];
                    final isFocused = index == _currentIndex;
                    final scale = widget.isMobile ? 1.0 : (isFocused ? 1.0 : 0.9);
                    final sideOpacity = widget.isMobile ? 1.0 : (isFocused ? 1.0 : 0.8);
                    final sidePadding = isFocused ? 28.0 : 22.0;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 8 : 12),
                      child: AnimatedScale(
                        scale: scale,
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOutCubic,
                          constraints: const BoxConstraints(maxWidth: 900),
                          padding: EdgeInsets.all(sidePadding),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isFocused
                                  ? const Color(0xFFFFB300).withOpacity(0.25)
                                  : const Color(0xFF002B5B).withOpacity(0.06),
                              width: isFocused ? 1.6 : 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF002B5B).withOpacity(
                                  isFocused ? 0.08 : 0.04,
                                ),
                                blurRadius: isFocused ? 28 : 18,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Opacity(
                            opacity: sideOpacity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    t.rating,
                                    (_) => const Icon(
                                      Icons.star,
                                      color: Color(0xFFFFB300),
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
                                      color: Color(0xFFFFB300),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                        ? const Color(0xFFFFB300)
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
