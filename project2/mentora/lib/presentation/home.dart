import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/presentation/chatbot.dart';
import 'package:mentora_app/presentation/community.dart';
import 'package:mentora_app/presentation/profile.dart';
import 'package:mentora_app/presentation/road_map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreenContent(),
    RoadMap(),
    Community(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF1D24CA),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Roadmap'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _screens[_selectedIndex],
      ),
      floatingActionButton:
      _selectedIndex == 0
          ? OpenContainer(
        closedColor: Color(0xFF1D24CA),
        closedShape: CircleBorder(),
        transitionDuration: Duration(milliseconds: 400),
        openBuilder: (context, action) => ChatBot(),
        closedBuilder:
            (context, action) => FloatingActionButton(
          backgroundColor: Color(0xFF1D24CA),
          elevation: 5,
          child: Icon(
            Icons.chat_bubble,
            color: Colors.white,
            size: 24,
          ),
          onPressed: action,
        ),
      )
          : null,
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            _buildHeaderSection(context),
            SizedBox(height: 25),
            _buildGamificationBoard(context),
            SizedBox(height: 25),
            _buildRoadmapProgressSection(context),
            SizedBox(height: 25),
            _buildCoursesEnrolledSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 35,
          backgroundImage: AssetImage(AssetsManager.profile),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi,",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Welcome to our LXP",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGamificationBoard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: _boxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildGamificationItem('assets/images/Badges.png', 'Badges', '1'),
          _buildGamificationItem(
            'assets/images/Experience.png',
            'Experience Points',
            '10',
          ),
          _buildGamificationItem('assets/images/Coins.png', 'Coins', '50'),
        ],
      ),
    );
  }

  Widget _buildGamificationItem(String iconPath, String title, String value) {
    return Column(
      children: [
        Image.asset(iconPath, width: 30, height: 30),
        SizedBox(height: 5),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 12),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildRoadmapProgressSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: _boxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Roadmap Progress',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '57%',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Container(
              height: 50,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 1),
                        FlSpot(1, 1.5),
                        FlSpot(2, 1.2),
                        FlSpot(3, 1.8),
                        FlSpot(4, 1.6),
                      ],
                      isCurved: true,
                      color: Color(0xFF1D24CA),
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoursesEnrolledSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Courses Enrolled', style: _sectionTitleStyle()),
          SizedBox(height: 10),
          _buildCourseItem('AWS Fundamentals', 0.55, 'assets/images/aws.png'),
          SizedBox(height: 10),
          _buildCourseItem(
            'Cyber Security Basics',
            0.75,
            'assets/images/cybersecurity.png',
          ),
        ],
      ),
    );
  }

  Widget _buildCourseItem(String courseName, double progress, String iconPath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(iconPath, width: 24, height: 24),
            SizedBox(width: 10),
            Expanded(
              child: Text(courseName, style: GoogleFonts.poppins(fontSize: 14)),
            ),
            SizedBox(width: 10),
            Text(
              '${(progress * 100).toInt()}%',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1D24CA)),
          ),
        ),
      ],
    );
  }

  TextStyle _sectionTitleStyle() =>
      GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold);
}

BoxDecoration _boxDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 5,
      ),
    ],
  );
}
