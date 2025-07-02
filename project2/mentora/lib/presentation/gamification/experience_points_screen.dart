import 'package:flutter/material.dart';
import 'package:mentora_app/core/assets_manager.dart';
import 'leaderboard_screen.dart';

class ExperiencePointsScreen extends StatelessWidget {
  const ExperiencePointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF1D24CA);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: primaryBlue),
                    ),
                    const Text(
                      'Experience Points',
                      style: TextStyle(
                        color: primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
                      child: Icon(Icons.person, color: primaryBlue),
                    ),
                  ],
                ),
              ),
          
              // XP graphic section
              const SizedBox(height: 10),
              Image.asset(AssetsManager.experiencePoints,),
              const SizedBox(height: 10),
              const Text(
                '150 / 400',
                style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Your Experience Points',
                style: TextStyle(
                  color: primaryBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
          
              const SizedBox(height: 30),
          
              // XP Levels
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    _buildXPLevelTile('L1', '900'),
                    const SizedBox(height: 12),
                    _buildXPLevelTile('L2', '1200'),
                    const SizedBox(height: 12),
                    _buildXPLevelTile('L3', '2400'),
                  ],
                ),
              ),

              SizedBox(height: 50,),

              // Leader Board Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LeaderboardScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Leader Board',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildXPLevelTile(String level, String points) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$level /',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            '/$points',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Image.asset(AssetsManager.lock, width: 36, height: 36),
        ],
      ),
    );
  }
}
