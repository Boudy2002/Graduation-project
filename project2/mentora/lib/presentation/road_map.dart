import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentora_app/presentation/analytics.dart';
import 'package:mentora_app/presentation/courses.dart';

class RoadMap extends StatefulWidget {
  const RoadMap({super.key});

  @override
  State<RoadMap> createState() => _RoadMapState();
}

class _RoadMapState extends State<RoadMap> {
  final List<Map<String, dynamic>> roadmapItems = [
    {'title': 'Deep Learning', 'status': 'locked'},
    {'title': 'Machine Learning', 'status': 'locked'},
    {'title': 'Python', 'status': 'locked'},
    {'title': 'Economy', 'status': 'locked'},
    {'title': 'Advanced Statistics', 'status': 'current'},
    {'title': 'Statistics', 'status': 'completed'},
    {'title': 'Linear Algebra', 'status': 'completed'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(roadmapItems.length * 2 - 1, (index) {
              return index.isEven
                  ? _buildRoadmapItem(
                roadmapItems[index ~/ 2]['title'],
                roadmapItems[index ~/ 2]['status'],
              )
                  : _buildConnector();
            }),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Data Scientist',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1D24CA),
        ),
      ),
      leading: IconButton(
        icon: Icon(FontAwesomeIcons.book, color: Color(0xFF1D24CA)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Courses()),
          );
        },
      ),
      actions: [
        IconButton(
          icon: Icon(FontAwesomeIcons.chartLine, color: Color(0xFF1D24CA)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Analytics()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildConnector() {
    return Container(height: 30, width: 4, color: Colors.grey.shade400);
  }

  Widget _buildRoadmapItem(String title, String status) {
    IconData? icon;
    Color iconColor;

    switch (status) {
      case 'completed':
        icon = Icons.check_circle;
        iconColor = Colors.green;
        break;
      case 'current':
        icon = Icons.chat;
        iconColor = Colors.green;
        break;
      case 'locked':
      default:
        icon = Icons.lock;
        iconColor = Color(0xFFDADADA);
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFF1D24CA),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (status == 'locked')
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              Positioned(
                top: 2,
                right: 2,
                child: Icon(icon, color: iconColor, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
