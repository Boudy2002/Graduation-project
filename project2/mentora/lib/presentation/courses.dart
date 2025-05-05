import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentora_app/presentation/home.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  final TextEditingController _searchController = TextEditingController();
  List<Course> courses = [
    Course('AWS Fundamentals', 'assets/aws.png', 119, 4.5),
    Course('Cybersecurity Fundamentals', 'assets/cybersecurity.png', 99, 4.7),
    Course('Software Testing Fundamentals', 'assets/ISTQB.png', 89, 4.3),
    Course('Cisco Networks Fundamentals', 'assets/CCNA.png', 129, 4.6),
  ];
  List<Course> filteredCourses = [];
  String selectedSort = 'New';

  @override
  void initState() {
    super.initState();
    filteredCourses = List.from(courses);
  }

  void _filterCourses(String query) {
    setState(() {
      filteredCourses =
          courses
              .where(
                (course) =>
                course.name.toLowerCase().contains(query.toLowerCase()),
          )
              .toList();
    });
  }

  void _sortCourses(String criteria) {
    setState(() {
      selectedSort = criteria;
      if (criteria == 'Price Ascending') {
        filteredCourses.sort((a, b) => a.price.compareTo(b.price));
      } else if (criteria == 'Price Descending') {
        filteredCourses.sort((a, b) => b.price.compareTo(a.price));
      } else {
        filteredCourses = List.from(courses);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft, color: Color(0xFF1D24CA)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        ),

        title: Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFF1D24CA), width: 1.5),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _filterCourses,
            textAlign: TextAlign.left, // Center the text
            style: TextStyle(color: Color(0xFF1D24CA)), // Change text color
            decoration: InputDecoration(
              icon: Icon(Icons.search, color: Color(0xFF1D24CA)),
              hintText: 'Find Your Certificate',
              hintStyle: TextStyle(color: Color(0xFF1D24CA)),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSortButtons(),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCourses.length,
                itemBuilder: (context, index) {
                  final course = filteredCourses[index];
                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    margin: EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.asset(
                            course.image,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.attach_money,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                      Text(
                                        '${course.price}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: List.generate(5, (i) {
                                      return Icon(
                                        i < course.rating.round()
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.amber,
                                        size: 18,
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSortButton('New'),
        _buildSortButton('Price Ascending'),
        _buildSortButton('Price Descending'),
      ],
    );
  }

  Widget _buildSortButton(String text) {
    bool isActive = selectedSort == text;
    return GestureDetector(
      onTap: () => _sortCourses(text),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF1D24CA) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? Color(0xFF1D24CA) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class Course {
  final String name;
  final String image;
  final double price;
  final double rating;

  Course(this.name, this.image, this.price, this.rating);
}
