import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mentora/Screens/quizzes.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Welcome to Mentora!",
      "description": "Embark on a journey to discover new skills and achieve your goals with ease.",
      "animation": "Assets/animation1.json"
    },
    {
      "title": "Learning Tailored to You",
      "description": "Get a customized learning experience designed to match your interests and career goals.",
      "animation": "Assets/animation2.json"
    },
    {
      "title": "Interactive & Engaging",
      "description": "Explore videos, quizzes, and challenges to make learning fun and effective.",
      "animation": "Assets/animation3.json"
    },
    {
      "title": "Join a Thriving Community",
      "description": "Connect with a global community of learners, mentors, and experts.",
      "animation": "Assets/animation4.json"
    },
    {
      "title": "Ready for a Quick Quiz!",
      "description": "Read each statement. If you agree with the statement, fill in the circle. There are no wrong answers!  Let's see what you've got!  Goodluck!",
      "animation": "Assets/animation5.json"
    },
  ];

  void _onNextPressed() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    else if (_currentPage == onboardingData.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuizzesPage()),
      );
    }
    else {
      // Navigate to the main app screen
      print("Onboarding Completed!");
    }
  }

  void _onSkipPressed() {
    _pageController.animateToPage(
      onboardingData.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(
                    onboardingData[index]["title"]!,
                    onboardingData[index]["description"]!,
                    onboardingData[index]["animation"]!,
                  );
                },
              ),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(String title, String description, String animation) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          // Profile Section
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('Assets/profile.png'), // Change to your profile image
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi,",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("Welcome to our LXP"),
                ],
              ),
            ],
          ),
          // Lottie Animation
          Expanded(
            child: Lottie.asset(animation, height: 200, width: 300),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF1D24CA)),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),

          // Subtitle
          Text(
            description,
            style: const TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: _onSkipPressed,
            child: const Text("Skip", style: TextStyle(color: Color(0xFF1D24CA))),
          ),
          Row(
            children: List.generate(
              onboardingData.length,
                  (index) => _buildIndicator(index == _currentPage),
            ),
          ),
          ElevatedButton(
            onPressed: _onNextPressed,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12),
              backgroundColor: Color(0xFF1D24CA),
            ),
            child: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 30 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF1D24CA) : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

