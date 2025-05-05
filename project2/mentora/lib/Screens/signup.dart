import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentora/Screens/landing.dart';

class SignUpPage extends StatefulWidget{
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{
  void _validate(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LandingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _validate,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: GoogleFonts.itim().fontFamily,
                ),
                backgroundColor: Color(0xFF1D24CA),
              ),
              child: Text("Login"),
            ),
          ]
        ),
      ),
    );
  }
}