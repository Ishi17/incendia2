// Replace the contents of your current HomePage file with this.
// Suggested filename: lib/pages/home_page.dart or lib/homepage_final.dart

import 'dart:async';
import 'package:flutter/material.dart';

/// =========================
/// Design tokens & routes
/// =========================
const Color kPrimaryBlue = Color(0xFF002B5B);
const Color kAccentOrange = Color(0xFFFF6B00);
const Color kTextDark = Color(0xFF333333);
const Color kTextMuted = Color(0xFF666666);
const Color kScaffold = Color(0xFFF5F5F5);

class Routes {
  static const home = '/';
  static const about = '/about';
  static const academic = '/academic';
  static const lifeSkills = '/lifeskills';
  static const schedule = '/schedule';
  static const admissions = '/admissions';
  static const gallery = '/gallery';
  static const careers = '/careers';
  static const contact = '/contact';
}

/// =========================
/// Responsive helper
/// =========================
class Responsive {
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 768;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1024;
}

/// =========================
/// Lead form (modal)
/// =========================
Future<void> showLeadForm(BuildContext context) async {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phone = '';
  String grade = '';

  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Book Free Counseling'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter name' : null,
              onSaved: (v) => name = v!.trim(),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
              validator: (v) => (v == null || v.trim().length < 6) ? 'Enter phone' : null,
              onSaved: (v) => phone = v!.trim(),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Grade (optional)'),
              onSaved: (v) => grade = v?.trim() ?? '',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState!.save();
              // TODO: wire this to your LeadService or webhook
              await Future.delayed(const Duration(milliseconds: 300)); // simulate network
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Thanks! We will contact you soon')));
              Navigator.pop(context);
            }
          },
          child: const Text('Book Now'),
        ),
      ],
    ),
  );
}

/// =========================
/// Navbar & Drawer (self-contained)
/// =========================
class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  final bool scrolled;
  final VoidCallback? onPrimaryCta;
  const CustomNavbar({Key? key, this.scrolled = false, this.onPrimaryCta}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return AppBar(
      backgroundColor: Colors.white.withOpacity(scrolled ? 0.98 : 0.0),
      elevation: scrolled ? 6 : 0,
      titleSpacing: 20,
      title: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.pushNamed(context, Routes.home),
              child: Row(
                children: const [
                  Icon(Icons.local_fire_department, color: kPrimaryBlue, size: 28),
                  SizedBox(width: 8),
                  Text('Incendia', style: TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),
            const Spacer(),
            if (!isMobile) ..._desktopNav(context) else _mobileMenuButton(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _desktopNav(BuildContext context) {
    return [
      _NavItem(label: 'About', route: Routes.about),
      _NavItem(label: 'Academics', route: Routes.academic),
      _NavItem(label: 'Life Skills', route: Routes.lifeSkills),
      _NavItem(label: 'Admissions', route: Routes.admissions),
      _NavItem(label: 'Gallery', route: Routes.gallery),
      _NavItem(label: 'Careers', route: Routes.careers),
      _NavItem(label: 'Contact', route: Routes.contact),
      const SizedBox(width: 12),
      ElevatedButton(
        onPressed: onPrimaryCta ?? () => showLeadForm(context),
        style: ElevatedButton.styleFrom(backgroundColor: kAccentOrange),
        child: const Text('Book Free Counseling'),
      ),
    ];
  }

  Widget _mobileMenuButton(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
        icon: const Icon(Icons.menu, color: kPrimaryBlue),
        onPressed: () => Scaffold.of(context).openDrawer(),
        tooltip: 'Open menu',
      );
    });
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final String route;
  const _NavItem({Key? key, required this.label, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () => Navigator.pushNamed(context, route), child: Text(label, style: const TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.w600)));
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            ListTile(leading: const Icon(Icons.home), title: const Text('Home'), onTap: () => Navigator.pushNamed(context, Routes.home)),
            ListTile(leading: const Icon(Icons.info), title: const Text('About'), onTap: () => Navigator.pushNamed(context, Routes.about)),
            ListTile(leading: const Icon(Icons.school), title: const Text('Academics'), onTap: () => Navigator.pushNamed(context, Routes.academic)),
            ListTile(leading: const Icon(Icons.contact_page), title: const Text('Admissions'), onTap: () => Navigator.pushNamed(context, Routes.admissions)),
            ListTile(leading: const Icon(Icons.photo_library), title: const Text('Gallery'), onTap: () => Navigator.pushNamed(context, Routes.gallery)),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Book Free Counseling')),
            ),
          ],
        ),
      ),
    );
  }
}

/// =========================
/// Trust strip
/// =========================
class TrustStrip extends StatelessWidget {
  final bool isMobile;
  const TrustStrip({Key? key, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: isMobile ? 12 : 20, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: const [
                _TrustCounter(number: '15+', label: 'Years'),
                SizedBox(width: 24),
                _TrustCounter(number: '10K+', label: 'Students'),
                SizedBox(width: 24),
                _TrustCounter(number: '95%', label: 'Parent satisfaction'),
              ]),
              ElevatedButton.icon(
                onPressed: () => showLeadForm(context),
                icon: const Icon(Icons.phone),
                label: const Text('Book Free Counseling'),
                style: ElevatedButton.styleFrom(backgroundColor: kAccentOrange),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TrustCounter extends StatelessWidget {
  final String number;
  final String label;
  const _TrustCounter({Key? key, required this.number, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(number, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: kPrimaryBlue, fontWeight: FontWeight.bold)),
      Text(label, style: Theme.of(context).textTheme.bodyMedium),
    ]);
  }
}

/// =========================
/// Hero Section
/// =========================
class HeroSection extends StatelessWidget {
  final bool isMobile;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final void Function(String)? navigateTo;
  final VoidCallback? onPrimaryCta;

  const HeroSection({
    Key? key,
    required this.isMobile,
    required this.fadeAnimation,
    required this.slideAnimation,
    this.navigateTo,
    this.onPrimaryCta,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxWidth = 1100.0;
    return Container(
      color: kScaffold,
      padding: EdgeInsets.symmetric(vertical: isMobile ? 24 : 48, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: isMobile ? _buildMobile(context) : _buildDesktop(context),
        ),
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: SlideTransition(
            position: slideAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Transforming Students Into Confident, Future-Ready Leaders', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 16),
                Text('Personalized learning, life skills, and academic excellence — Book your free counseling session today.', style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 24),
                Row(children: [
                  ElevatedButton(onPressed: onPrimaryCta ?? () => showLeadForm(context), child: const Text('Book Free Counseling')),
                  const SizedBox(width: 16),
                  OutlinedButton(onPressed: () => navigateTo?.call('admissions'), child: const Text('Admissions')),
                ]),
              ]),
            ),
          ),
        ),
        const SizedBox(width: 28),
        Expanded(
          flex: 4,
          child: SlideTransition(
            position: slideAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16)],
                  image: const DecorationImage(
                    image: AssetImage('assets/images/incendia.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SlideTransition(position: slideAnimation, child: FadeTransition(opacity: fadeAnimation, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Transforming Students Into Confident, Future-Ready Leaders', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        Text('Personalized learning, life skills, and academic excellence — Book your free counseling session today.', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: ElevatedButton(onPressed: onPrimaryCta ?? () => showLeadForm(context), child: const Text('Book Free Counseling'))),
        ]),
      ]))),
      const SizedBox(height: 16),
      Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16)],
          image: const DecorationImage(image: AssetImage('assets/images/incendia.jpg'), fit: BoxFit.cover),
        ),
      ),
    ]);
  }
}

/// =========================
/// Combined services (cards)
/// =========================
class CombinedServicesOfferings extends StatelessWidget {
  final bool isMobile;
  final AnimationController? animationController;
  const CombinedServicesOfferings({Key? key, required this.isMobile, this.animationController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      _ServiceCard(title: 'Academic Excellence', subtitle: 'CBSE / ICSE / State', icon: Icons.school),
      _ServiceCard(title: 'Life Skills', subtitle: 'Communication & Leadership', icon: Icons.psychology),
      _ServiceCard(title: 'Exam Prep', subtitle: 'JEE / NEET / Olympiads', icon: Icons.book),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: isMobile
              ? Column(children: items.map((w) => Padding(padding: const EdgeInsets.only(bottom: 12), child: w)).toList())
              : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: items),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const _ServiceCard({Key? key, required this.title, required this.subtitle, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        constraints: const BoxConstraints(minWidth: 240, maxWidth: 360),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12)]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(width: 56, height: 56, decoration: BoxDecoration(color: kAccentOrange.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: kAccentOrange)),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryBlue)),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(fontSize: 14, color: kTextMuted)),
        ]),
      ),
    );
  }
}

/// =========================
/// Testimonials carousel
/// =========================
class TestimonialsSection extends StatefulWidget {
  final bool isMobile;
  const TestimonialsSection({Key? key, required this.isMobile}) : super(key: key);

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  int _index = 0;
  late Timer _timer;

  final _testimonials = const [
    {'quote': 'Incendia transformed my child\'s confidence in 3 months.', 'author': 'R. Kumar (Parent)'},
    {'quote': 'Practical learning and caring teachers — highly recommended.', 'author': 'S. Mehta'},
    {'quote': 'Great results and life skills focus.', 'author': 'P. Sharma'},
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _index = (_index + 1) % _testimonials.length;
      _pageController.animateToPage(_index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: widget.isMobile ? 16 : 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(children: [
            Align(alignment: Alignment.centerLeft, child: Text('What parents say', style: Theme.of(context).textTheme.headlineMedium)),
            const SizedBox(height: 12),
            SizedBox(
              height: 140,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _testimonials.length,
                itemBuilder: (context, i) {
                  final t = _testimonials[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: kScaffold, borderRadius: BorderRadius.circular(12)),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('“${t['quote']}”', style: const TextStyle(fontSize: 15, color: kTextDark)),
                        const Spacer(),
                        Text(t['author']!, style: const TextStyle(fontWeight: FontWeight.bold, color: kPrimaryBlue)),
                      ]),
                    ),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}

/// =========================
/// CTA Section
/// =========================
class CtaSection extends StatelessWidget {
  final bool isMobile;
  final void Function(String)? navigateTo;
  final VoidCallback? onPrimaryAction;
  const CtaSection({Key? key, required this.isMobile, this.navigateTo, this.onPrimaryAction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: EdgeInsets.symmetric(vertical: isMobile ? 20 : 28, horizontal: 16),
      color: kPrimaryBlue,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Ready to transform your child?', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white)),
                const SizedBox(height: 8),
                Text('Book a free counseling session and get a personalized plan.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70)),
              ]),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: onPrimaryAction ?? () => showLeadForm(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)),
              child: Text('Book Free Counseling', style: TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.bold)),
            ),
          ]),
        ),
      ),
    );
  }
}

/// =========================
/// Footer
/// =========================
class FooterSection extends StatelessWidget {
  final bool isMobile;
  const FooterSection({Key? key, required this.isMobile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: isMobile ? 24 : 40, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const Icon(Icons.local_fire_department, color: kPrimaryBlue),
              const SizedBox(width: 8),
              Text('Incendia', style: const TextStyle(color: kPrimaryBlue, fontWeight: FontWeight.bold, fontSize: 18)),
            ]),
            const SizedBox(height: 16),
            Text('© ${DateTime.now().year} Incendia. All rights reserved.', style: const TextStyle(color: kTextMuted)),
            const SizedBox(height: 8),
            Wrap(spacing: 12, children: [
              TextButton(onPressed: () => Navigator.pushNamed(context, Routes.about), child: const Text('About')),
              TextButton(onPressed: () => Navigator.pushNamed(context, Routes.contact), child: const Text('Contact')),
              TextButton(onPressed: () => Navigator.pushNamed(context, Routes.admissions), child: const Text('Admissions')),
            ]),
          ]),
        ),
      ),
    );
  }
}

/// =========================
/// Mobile sticky CTA
/// =========================
class _MobileStickyCTA extends StatelessWidget {
  final VoidCallback onTap;
  const _MobileStickyCTA({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 56,
            decoration: BoxDecoration(color: kAccentOrange, borderRadius: BorderRadius.circular(12), boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 3)),
            ]),
            child: const Center(child: Text('Book Free Counseling', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))),
          ),
        ),
      ),
    );
  }
}

/// =========================
/// HomePage (final)
/// =========================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  Timer? _scrollDebounce;

  late final AnimationController _heroAnimationController;
  late final AnimationController _cardAnimationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _heroAnimationController = AnimationController(duration: const Duration(milliseconds: 900), vsync: this);
    _cardAnimationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _heroAnimationController, curve: Curves.easeOut));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _heroAnimationController, curve: Curves.easeOut));

    _heroAnimationController.forward();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = _scrollController.offset > 50;
    if (_isScrolled != scrolled) {
      _scrollDebounce?.cancel();
      _scrollDebounce = Timer(const Duration(milliseconds: 80), () {
        if (mounted) setState(() => _isScrolled = scrolled);
      });
    }

    if (_scrollController.offset > 150 && !_cardAnimationController.isCompleted) {
      _cardAnimationController.forward();
    }
  }

  @override
  void dispose() {
    _scrollDebounce?.cancel();
    _scrollController.dispose();
    _heroAnimationController.dispose();
    _cardAnimationController.dispose();
    super.dispose();
  }

  void _navigateTo(String pageName) {
    switch (pageName.toLowerCase()) {
      case 'home':
        Navigator.pushNamed(context, Routes.home);
        return;
      case 'about':
        Navigator.pushNamed(context, Routes.about);
        return;
      case 'academic':
        Navigator.pushNamed(context, Routes.academic);
        return;
      case 'life skills':
      case 'lifeskills':
      case 'life-skills':
        Navigator.pushNamed(context, Routes.lifeSkills);
        return;
      case 'schedule':
        Navigator.pushNamed(context, Routes.schedule);
        return;
      case 'admissions':
      case 'admission':
        Navigator.pushNamed(context, Routes.admissions);
        return;
      case 'gallery':
        Navigator.pushNamed(context, Routes.gallery);
        return;
      case 'careers':
        Navigator.pushNamed(context, Routes.careers);
        return;
      case 'contact':
        Navigator.pushNamed(context, Routes.contact);
        return;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(72), child: CustomNavbar(scrolled: _isScrolled, onPrimaryCta: () => showLeadForm(context))),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(children: [
          HeroSection(isMobile: isMobile, fadeAnimation: _fadeAnimation, slideAnimation: _slideAnimation, navigateTo: _navigateTo, onPrimaryCta: () => showLeadForm(context)),
          TrustStrip(isMobile: isMobile),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Column(children: [
              CombinedServicesOfferings(isMobile: isMobile, animationController: _cardAnimationController),
              const SizedBox(height: 12),
              TestimonialsSection(isMobile: isMobile),
              const SizedBox(height: 12),
              CtaSection(isMobile: isMobile, navigateTo: _navigateTo, onPrimaryAction: () => showLeadForm(context)),
            ]),
          ),
          const SizedBox(height: 24),
          FooterSection(isMobile: isMobile),
          if (isMobile) _MobileStickyCTA(onTap: () => showLeadForm(context)),
          const SizedBox(height: 16),
        ]),
      ),
    );
  }
}