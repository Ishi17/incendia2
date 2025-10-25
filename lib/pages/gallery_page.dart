// Gallery Page
import 'package:flutter/material.dart';
import '../components/custom_navbar.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
    
    return Scaffold(
      appBar: CustomNavbar(
        title: 'Gallery',
        showBackButton: true,
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 12 : 16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isMobile ? 20 : isTablet ? 24 : 28),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF002B5B), Color(0xFF1E3A8A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.photo_library, 
                    size: isMobile ? 50 : isTablet ? 60 : 70, 
                    color: Color(0xFFFF6B00)
                  ),
                  SizedBox(height: isMobile ? 15 : 20),
                  Text(
                    'Campus Gallery',
                    style: TextStyle(
                      fontSize: isMobile ? 24 : isTablet ? 28 : 32, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 8 : 12),
                  Text(
                    'Explore our modern facilities and learning spaces',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : isTablet ? 16 : 18,
                      color: Colors.white.withOpacity(0.9),
                      fontFamily: 'Inter',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: isMobile ? 20 : isTablet ? 25 : 30),
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 768;
                final isTablet = constraints.maxWidth >= 768 && constraints.maxWidth < 1024;
                final crossAxisCount = isMobile ? 2 : isTablet ? 3 : 4;
                
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: isMobile ? 12 : isTablet ? 16 : 20,
                  mainAxisSpacing: isMobile ? 12 : isTablet ? 16 : 20,
                  childAspectRatio: isMobile ? 0.9 : isTablet ? 1.0 : 1.1,
                  children: [
                    _buildGalleryItem(Icons.class_, 'Classrooms', 'Modern learning spaces', isMobile, isTablet),
                    _buildGalleryItem(Icons.library_books, 'Library', 'Extensive book collection', isMobile, isTablet),
                    _buildGalleryItem(Icons.science, 'Laboratory', 'Well-equipped labs', isMobile, isTablet),
                    _buildGalleryItem(Icons.sports_soccer, 'Sports', 'Athletic facilities', isMobile, isTablet),
                    _buildGalleryItem(Icons.computer, 'Computer Lab', 'Latest technology', isMobile, isTablet),
                    _buildGalleryItem(Icons.restaurant, 'Cafeteria', 'Healthy meals', isMobile, isTablet),
                    _buildGalleryItem(Icons.theater_comedy, 'Auditorium', 'Events and presentations', isMobile, isTablet),
                    _buildGalleryItem(Icons.pool, 'Swimming Pool', 'Recreational activities', isMobile, isTablet),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryItem(IconData icon, String title, String subtitle, bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : isTablet ? 14 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 10 : isTablet ? 12 : 14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: isMobile ? 6 : isTablet ? 8 : 10,
            offset: Offset(0, isMobile ? 2 : isTablet ? 3 : 4),
          ),
          BoxShadow(
            color: Color(0xFFFF6B00).withOpacity(0.1),
            blurRadius: isMobile ? 10 : isTablet ? 15 : 20,
            offset: Offset(0, isMobile ? 3 : isTablet ? 5 : 7),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: isMobile ? 40 : isTablet ? 45 : 50,
            height: isMobile ? 40 : isTablet ? 45 : 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF6B00), Color(0xFFFF8533)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(isMobile ? 10 : isTablet ? 11 : 12),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFF6B00).withOpacity(0.3),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon, 
              color: Colors.white, 
              size: isMobile ? 20 : isTablet ? 22 : 24
            ),
          ),
          SizedBox(height: isMobile ? 8 : isTablet ? 10 : 12),
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 12 : isTablet ? 13 : 14, 
              fontWeight: FontWeight.bold, 
              color: Color(0xFF002B5B),
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: isMobile ? 3 : isTablet ? 4 : 5),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: isMobile ? 9 : isTablet ? 10 : 11, 
              color: Color(0xFF666666),
              fontFamily: 'Inter',
              height: 1.2,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}