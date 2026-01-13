import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:incendia_webpage/pages/academic.dart';
import 'package:incendia_webpage/pages/careers_page.dart';
import 'package:incendia_webpage/pages/contact_us_page.dart';
import 'package:incendia_webpage/pages/gallery_page.dart';
import 'package:incendia_webpage/pages/life_skills_page.dart';
import 'package:incendia_webpage/pages/admissions_page.dart';
import 'package:incendia_webpage/pages/about_page.dart';
import 'package:incendia_webpage/pages/home_page.dart';
import 'package:incendia_webpage/pages/schedule_page.dart';
import 'package:incendia_webpage/utils/close_guard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const _exitWarningMessage =
      'Wait! Limited spots left—register now before admissions close.';

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  bool _showExitWarning = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      registerBeforeUnloadGuard(
        onAttempt: _handleCloseAttempt,
        message: _exitWarningMessage,
      );
    }
  }

  @override
  void dispose() {
    if (kIsWeb) {
      unregisterBeforeUnloadGuard();
    }
    super.dispose();
  }

  void _handleCloseAttempt() {
    if (!mounted) return;
    setState(() => _showExitWarning = true);
  }

  void _dismissExitWarning() {
    if (!mounted) return;
    setState(() => _showExitWarning = false);
  }

  void _openAdmissions() {
    _dismissExitWarning();
    _navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => const AdmissionsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const appTitle =
        'Incendia | Premium Tuition Centre in Bangalore for Grades 9-12 | CBSE, ICSE, IB + Life Skills';

    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: appTitle,
      onGenerateTitle: (_) => appTitle,
      theme: ThemeData(
        primaryColor: const Color(79
                                 ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          headlineLarge: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
          headlineMedium: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
          bodyLarge: const TextStyle(
            fontSize: 18,
            color: Color(0xFF0F172A),
            height: 1.6,
          ),
          bodyMedium: const TextStyle(
            fontSize: 16,
            color: Color(0xFF475569),
            height: 1.5,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0EA5E9),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      builder: (context, child) {
        final content = child ?? const SizedBox.shrink();
        return Stack(
          children: [
            content,
            if (_showExitWarning)
              ExitWarningOverlay(
                onRegister: _openAdmissions,
                onStay: _dismissExitWarning,
              ),
          ],
        );
      },
      home: const HomePage(),
      routes: {
        '/about': (context) => const AboutUsPage(),
        '/academic': (context) => const AcademicPage(),
        '/lifeskills': (context) => const LifeSkillsPage(),
        '/schedule': (context) => const SchedulePage(),
        '/admissions': (context) => const AdmissionsPage(),
        '/gallery': (context) => const GalleryPage(),
        '/careers': (context) => const CareersPage(),
        '/contact': (context) => const ContactUsPage(),
      },
    );
  }
}

class ExitWarningOverlay extends StatelessWidget {
  final VoidCallback onRegister;
  final VoidCallback onStay;

  const ExitWarningOverlay({
    required this.onRegister,
    required this.onStay,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': Icons.schedule,
        'color': Color(0xFFF97316),
        'title': 'Event starts in 3 days',
        'subtitle': 'Don’t wait until it’s too late',
      },
      {
        'icon': Icons.event_available_rounded,
        'color': Color(0xFFE11D48),
        'title': 'Only 200 spots left',
        'subtitle': 'Last event sold out in 36 hours',
      },
      {
        'icon': Icons.attach_money,
        'color': Color(0xFF22C55E),
        'title': '100% Free (normally ₹99,700 value)',
        'subtitle': 'No credit card required',
      },
    
    ];

    return Positioned.fill(
      child: Material(
        color: Colors.black.withOpacity(0.66),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Container(
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                color: const Color(0xFF070B16),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Wait! Before You Go...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: onStay,
                        icon: const Icon(Icons.close_rounded, color: Colors.white70),
                        splashRadius: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Are you sure you want to miss this opportunity?',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...features.map((feature) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: (feature['color'] as Color).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              feature['icon'] as IconData,
                              color: feature['color'] as Color,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  feature['title'] as String,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  feature['subtitle'] as String,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 6),
                  ElevatedButton(
                    onPressed: onRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22C55E),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: const Text('Last Chance — Register Now'),
                  ),
                  TextButton(
                    onPressed: onStay,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white70,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text("No thanks, I don't want to learn AI"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color(0xFF1F2937),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 64, color: Color(0xFF0EA5E9)),
            SizedBox(height: 16),
            Text(
              '$title Page',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Coming Soon',
              style: TextStyle(fontSize: 16, color: Color(0xFF475569)),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
