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


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Educational Academy',
      theme: ThemeData(
        primaryColor: Color(0xFF002B5B),
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Color(0xFF002B5B),
          ),
          headlineMedium: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Color(0xFF002B5B),
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            color: Color(0xFF333333),
            height: 1.6,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
            height: 1.5,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFF6B00),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      home: HomePage(),
      routes: {
        '/about': (context) => AboutUsPage(),
        '/academic': (context) => PlaceholderPage('Academic Mastery'),
        '/lifeskills': (context) => PlaceholderPage('Life Skills Program'),
        '/schedule': (context) => PlaceholderPage('Schedule & Locations'),
        '/admissions': (context) => PlaceholderPage('Admissions'),
        '/gallery': (context) => PlaceholderPage('Gallery'),
        '/careers': (context) => PlaceholderPage('Careers'),
        '/contact': (context) => PlaceholderPage('Contact Us'),
      },
    );
  }
}


class PlaceholderPage extends StatelessWidget {
  final String title;

  PlaceholderPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color(0xFF002B5B),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 64, color: Color(0xFFFF6B00)),
            SizedBox(height: 16),
            Text(
              '$title Page',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF002B5B),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Coming Soon',
              style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
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
