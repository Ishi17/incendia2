import 'package:flutter/material.dart';
import 'package:incendia_webpage/components/custom_drawer.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../components/custom_navbar.dart';

class LifeSkillsPage extends StatelessWidget {
  const LifeSkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet =
        MediaQuery.of(context).size.width >= 768 &&
        MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      appBar: CustomNavbar(title: 'Life Skills', showBackButton: true),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeaderSection(isMobile, isTablet),
              _buildSkillsList(context, isMobile, isTablet),
              _buildTestimonialSection(isMobile, isTablet),
              _buildFooter(context, isMobile, isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(bool isMobile, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile
            ? 40
            : isTablet
            ? 50
            : 60,
        horizontal: isMobile ? 16 : 24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF002B5B), Color(0xFF1E3A8A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.psychology,
            size: isMobile
                ? 50
                : isTablet
                ? 60
                : 70,
            color: Color(0xFFFFB300),
          ),
          SizedBox(height: isMobile ? 15 : 20),
          Text(
            'Life Skills for the Real World',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile
                  ? 28
                  : isTablet
                  ? 32
                  : 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'Empowering students with critical thinking, communication, and emotional intelligence.',
            style: TextStyle(
              fontSize: isMobile
                  ? 14
                  : isTablet
                  ? 16
                  : 18,
              color: Colors.white.withOpacity(0.9),
              fontFamily: 'Inter',
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsList(BuildContext context, bool isMobile, bool isTablet) {
    final List<Map<String, dynamic>> skills = [
      {
        'title': 'Financial Literacy for Teens',
        'description':
            'Budgeting, saving, digital payments (UPI, wallets), understanding banks, avoiding scams.',
        'icon': Icons.account_balance,
        'color': Color(0xFFE8F4F8), // Soft Sky Blue
      },
      {
        'title': 'Digital Citizenship & Internet Safety',
        'description':
            'Cyberbullying, privacy settings, fake news, screen time balance, digital footprint.',
        'icon': Icons.security,
        'color': Color(0xFFF5F7FA), // Warm Off-White
      },
      {
        'title': 'Communication & Public Speaking',
        'description':
            'Storytelling, debates, presentations, body language, active listening.',
        'icon': Icons.record_voice_over,
        'color': Color(0xFFE8F4F8), // Soft Sky Blue
      },
      {
        'title': 'Time Management & Study Skills',
        'description':
            'Prioritizing tasks, planners, Pomodoro technique, overcoming distractions.',
        'icon': Icons.schedule,
        'color': Color(0xFFF5F7FA), // Warm Off-White
      },
      {
        'title': 'Leadership & Teamwork',
        'description':
            'Group roles, collaboration, leading projects, resolving conflicts.',
        'icon': Icons.group,
        'color': Color(0xFFE8F4F8), // Soft Sky Blue
      },
      {
        'title': 'Emotional Intelligence (EQ)',
        'description':
            'Identifying feelings, managing emotions, self-awareness, empathy exercises.',
        'icon': Icons.sentiment_satisfied,
        'color': Color(0xFFF5F7FA), // Warm Off-White
      },
      {
        'title': 'Basic Legal & Civic Awareness',
        'description':
            'Student rights, voting basics, equality, safety laws, RTI & digital consent.',
        'icon': Icons.gavel,
        'color': Color(0xFFE8F4F8), // Soft Sky Blue
      },
      {
        'title': 'Goal Setting & Self-Motivation',
        'description':
            'SMART goals, vision boards, intrinsic vs extrinsic motivation, habit loops.',
        'icon': Icons.flag,
        'color': Color(0xFFF5F7FA), // Warm Off-White
      },
      {
        'title': 'First Aid & Personal Safety',
        'description':
            'CPR basics, handling minor injuries, emergency contact awareness, street safety.',
        'icon': Icons.medical_services,
        'color': Color(0xFFE8F4F8), // Soft Sky Blue
      },
      {
        'title': 'Mindfulness & Mental Well-being',
        'description':
            'Meditation, stress management, gratitude journaling, self-reflection techniques.',
        'icon': Icons.self_improvement,
        'color': Color(0xFFF5F7FA), // Warm Off-White
      },
      {
        'title': 'Nutrition & Fireless Cooking',
        'description':
            'Healthy eating habits, decoding food labels, making simple no-flame recipes.',
        'icon': Icons.restaurant,
        'color': Color(0xFFE8F4F8), // Soft Sky Blue
      },
      {
        'title': 'Career Awareness & Future Readiness',
        'description':
            'Career exploration, 21st-century jobs, freelancing basics, resume writing.',
        'icon': Icons.work,
        'color': Color(0xFFF5F7FA), // Warm Off-White
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 20,
        vertical: isMobile ? 14 : 20,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double spacing = isMobile
              ? 12
              : isTablet
              ? 16
              : 20;
          final int columns = isMobile
              ? 1
              : isTablet
              ? 2
              : 3;
          final double totalSpacing = spacing * (columns - 1);
          final double cardBaseWidth =
              (constraints.maxWidth - totalSpacing) / columns;
          final double cardWidth = cardBaseWidth.clamp(240.0, 360.0);

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            alignment: WrapAlignment.center,
            children: skills.asMap().entries.map<Widget>((entry) {
              final index = entry.key;
              final skillData = entry.value;
              final rank = index + 1;

              return SizedBox(
                width: columns == 1 ? constraints.maxWidth : cardWidth,
                child: SkillCard(
                  title: skillData['title']!,
                  description: skillData['description']!,
                  icon: skillData['icon'],
                  color: skillData['color'],
                  rank: rank,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildTestimonialSection(bool isMobile, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile
            ? 20
            : isTablet
            ? 24
            : 32,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEEF2F7), Color(0xFFF8FAFC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.format_quote,
            size: isMobile ? 40 : 50,
            color: Color(0xFFFFB300),
          ),
          SizedBox(height: isMobile ? 15 : 20),
          Text(
            'What Our Students Say',
            style: TextStyle(
              fontSize: isMobile
                  ? 20
                  : isTablet
                  ? 22
                  : 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF002B5B),
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            '"Learning life skills here helped me become more confident and independent."',
            style: TextStyle(
              fontSize: isMobile
                  ? 14
                  : isTablet
                  ? 15
                  : 16,
              color: Color(0xFF333333),
              fontFamily: 'Inter',
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 15 : 20),
          Text(
            '- Sarah, Grade 11',
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              color: Color(0xFF666666),
              fontStyle: FontStyle.italic,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isMobile, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile
            ? 20
            : isTablet
            ? 24
            : 32,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF002B5B), Color(0xFF001122)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.rocket_launch,
            color: Color(0xFFFFB300),
            size: isMobile ? 40 : 50,
          ),
          SizedBox(height: isMobile ? 15 : 20),
          Text(
            'Interested in Life Skills Programs?',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile
                  ? 16
                  : isTablet
                  ? 18
                  : 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 8 : 12),
          Text(
            'Join thousands of students developing essential life skills for success',
            style: TextStyle(
              color: Colors.white70,
              fontSize: isMobile ? 14 : 16,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 20 : 24),
          isMobile
              ? SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/admissions'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFB300),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Apply Now',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/admissions'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFB300),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Apply Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class RankedLifeSkillCard extends StatelessWidget {
  const RankedLifeSkillCard({
    required this.rank,
    required this.width,
    required this.isMobile,
    required this.isTablet,
    required this.child,
    super.key,
  });

  final int rank;
  final double width;
  final bool isMobile;
  final bool isTablet;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double rankSize = isMobile
        ? 120
        : isTablet
        ? 150
        : 180;

    return SizedBox(
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: rankSize * 0.5,
            child: OverflowBox(
              alignment: Alignment.centerLeft,
              minWidth: rankSize,
              maxWidth: rankSize,
              minHeight: rankSize,
              maxHeight: rankSize,
              child: IgnorePointer(
                child: Transform.translate(
                  offset: Offset(-rankSize * 0.3, 0),
                  child: _DecorativeRank(
                    rank: rank,
                    isMobile: isMobile,
                    isTablet: isTablet,
                    customSize: rankSize,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: isMobile ? 6 : 8),
          Expanded(
            child: Container(key: const ValueKey('ranked-card'), child: child),
          ),
        ],
      ),
    );
  }
}

class _DecorativeRank extends StatelessWidget {
  const _DecorativeRank({
    required this.rank,
    required this.isMobile,
    required this.isTablet,
    this.customSize,
  });

  final int rank;
  final bool isMobile;
  final bool isTablet;
  final double? customSize;

  @override
  Widget build(BuildContext context) {
    final double rankSize =
        customSize ??
        (isMobile
            ? 150
            : isTablet
            ? 190
            : 230);
    final Paint rankStrokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = isMobile
          ? 4.0
          : isTablet
          ? 5.5
          : 6.5
      ..color = Colors.white.withOpacity(0.3);
    final Matrix4 rankTransform = Matrix4.diagonal3Values(1.05, 1.0, 1.0);

    return Transform(
      alignment: Alignment.centerRight,
      transform: rankTransform,
      child: Text(
        rank.toString().padLeft(2, '0'),
        key: const ValueKey('ranked-rank'),
        style: TextStyle(
          fontSize: rankSize,
          fontWeight: FontWeight.w900,
          height: 0.9,
          letterSpacing: -3,
          foreground: rankStrokePaint,
          shadows: [
            Shadow(
              offset: Offset(0, 2),
              blurRadius: 8,
              color: Colors.black.withOpacity(0.12),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int? rank;

  const SkillCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.rank,
    super.key,
  });

  @override
  _SkillCardState createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  YoutubePlayerController? _youtubeController;
  bool _videoInitialized = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _youtubeController?.close();
    _controller.dispose();
    super.dispose();
  }

  YoutubePlayerController _ensureYoutubeController() {
    if (_youtubeController == null) {
      _youtubeController = YoutubePlayerController.fromVideoId(
        videoId: 'DN5ZcGKwm7U',
        autoPlay: false,
        params: const YoutubePlayerParams(
          mute: true,
          showControls: false,
          showFullscreenButton: false,
        ),
      );
      _videoInitialized = true;
    }
    return _youtubeController!;
  }

  void _onEnter(bool hovering) {
    setState(() {
      isHovered = hovering;
      if (isHovered) {
        _controller.forward();
        _ensureYoutubeController()
          ..seekTo(seconds: 0)
          ..playVideo();
      } else {
        _controller.reverse();
        _youtubeController?.pauseVideo();
      }
    });
  }

  void _showSkillDetails() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D1531),
          ),
        ),
        content: Text(
          widget.description,
          style: TextStyle(
            fontSize: isMobile ? 13 : 14,
            height: 1.5,
            color: Color(0xFF1F2937),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close', style: TextStyle(color: Color(0xFF002B5B))),
          ),
        ],
      ),
    );
  }

  Widget _buildFront() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet =
        MediaQuery.of(context).size.width >= 768 &&
        MediaQuery.of(context).size.width < 1024;
    final String summary = widget.description.length > 120
        ? '${widget.description.substring(0, 120).trim()}…'
        : widget.description;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFeef2ff),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: EdgeInsets.all(isMobile ? 8 : 10),
          child: Icon(
            widget.icon,
            color: Color(0xFF0B1E33),
            size: isMobile
                ? 22
                : isTablet
                ? 26
                : 28,
          ),
        ),
        SizedBox(height: isMobile ? 10 : 12),
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile
                ? 14
                : isTablet
                ? 15
                : 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0D1531),
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: isMobile ? 6 : 8),
        Text(
          summary,
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: isMobile
                ? 12
                : isTablet
                ? 13
                : 14,
            color: Color(0xFF1F2937),
            fontFamily: 'Inter',
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildBack() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet =
        MediaQuery.of(context).size.width >= 768 &&
        MediaQuery.of(context).size.width < 1024;
    final double titleSize = isMobile
        ? 15
        : isTablet
        ? 17
        : 18;
    final bool hasController = _youtubeController != null;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Watch a quick glimpse',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0D1531),
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: isMobile ? 10 : 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(isMobile ? 12 : 14),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: hasController
                ? Stack(
                    children: [
                      YoutubePlayer(
                        controller: _youtubeController!,
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: _PlaybackControls(controller: _youtubeController!),
                      ),
                    ],
                  )
                : Container(
                    color: const Color(0xFFE5E7EB),
                    child: Center(
                      child: Text(
                        'Hover to load video',
                        style: TextStyle(
                          color: Color(0xFF0D1531),
                          fontSize: isMobile ? 12 : 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
        SizedBox(height: isMobile ? 8 : 10),
        TextButton.icon(
          onPressed: _showSkillDetails,
          icon: Icon(Icons.info_outline, color: Color(0xFF002B5B)),
          label: Text(
            'About ${widget.title}',
            style: TextStyle(
              color: Color(0xFF002B5B),
              fontSize: isMobile ? 12 : 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          hasController && _videoInitialized
              ? 'Placeholder video plays on hover'
              : 'Loads only when you hover',
          style: TextStyle(
            fontSize: isMobile ? 11 : 12,
            color: Color(0xFF1F2937),
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet =
        MediaQuery.of(context).size.width >= 768 &&
        MediaQuery.of(context).size.width < 1024;
    final rankText = widget.rank?.toString();

    Widget content = AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final scale = 1.0 + (0.045 * _animation.value);
        final lift = 6.0 * _animation.value;
        final shadowOpacity = 0.05 + (0.15 * _animation.value);
        final shadowBlur = 10.0 + (12.0 * _animation.value);
        final double cardHeight = isHovered
            ? (isMobile ? 250 : isTablet ? 280 : 320)
            : (isMobile ? 196 : isTablet ? 216 : 246);
        final bool hasRank = rankText != null;
        final bool showRankColumn = hasRank && !isHovered;
        final double rankColumnWidth = isMobile
            ? 110
            : isTablet
            ? 130
            : 150;
        final double numberFontSize = isMobile
            ? 70
            : isTablet
            ? 86
            : 104;
        final double strokeWidth = isMobile
            ? 5
            : isTablet
            ? 6
            : 7;
        final Color rankBackground = Color(0xFF050F1C);

        return Transform.translate(
          offset: Offset(0, -lift),
          child: Transform.scale(
            scale: scale,
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              height: cardHeight,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(shadowOpacity),
                    blurRadius: shadowBlur,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (showRankColumn)
                    Container(
                      width: rankColumnWidth,
                      decoration: BoxDecoration(
                        color: rankBackground,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(isMobile ? 12 : 16),
                          bottomLeft: Radius.circular(isMobile ? 12 : 16),
                        ),
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                rankText!,
                                style: TextStyle(
                                  fontSize: numberFontSize,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -1.5,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = strokeWidth
                                    ..color = Colors.black,
                                ),
                              ),
                              Text(
                                rankText!,
                                style: TextStyle(
                                  fontSize: numberFontSize,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -1.5,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (showRankColumn)
                    Container(width: 2, color: Colors.white.withOpacity(0.15)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : 18,
                        vertical: isMobile ? 14 : 16,
                      ),
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 280),
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: Container(
                          key: ValueKey(isHovered ? 'back' : 'front'),
                          alignment: Alignment.center,
                          child: isHovered ? _buildBack() : _buildFront(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    return GestureDetector(
      onTap: () {
        // Toggle expanded state on mobile when tapped
        if (isMobile) {
          _onEnter(!isHovered);
        }
      },
      child: MouseRegion(
        onEnter: isMobile ? null : (_) => _onEnter(true),
        onExit: isMobile ? null : (_) => _onEnter(false),
        child: content,
      ),
    );
  }
}

class _PlaybackControls extends StatelessWidget {
  const _PlaybackControls({required this.controller});

  final YoutubePlayerController controller;

  @override
  Widget build(BuildContext context) {
    return YoutubeValueBuilder(
      controller: controller,
      builder: (context, value) {
        final bool isPlaying = value.playerState == PlayerState.playing;
        return Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  if (isPlaying) {
                    controller.pauseVideo();
                  } else {
                    controller.playVideo();
                  }
                },
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 18,
                ),
                splashRadius: 18,
              ),
              IconButton(
                onPressed: () => controller.seekTo(seconds: 0),
                icon: const Icon(Icons.restart_alt, color: Colors.white, size: 18),
                splashRadius: 18,
              ),
            ],
          ),
        );
      },
    );
  }
}
