import 'package:flutter/material.dart';
import 'package:mentora_app/presentation/edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: AppBar(elevation: 0, automaticallyImplyLeading: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 70),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 70,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfile()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1D24CA),
              foregroundColor: Colors.white,
            ),
            child: Text('Edit Profile'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                buildSectionTitle('Content'),
                buildListTile('Favourite', Icons.favorite, () {}),
                buildListTile('Bookmarks', Icons.bookmark, () {}),
                buildListTile('Download', Icons.download, () {}),
                SizedBox(height: 20),
                buildSectionTitle('Preferences'),
                buildListTile('Language', Icons.language, () {}),
                buildListTile('Dark Mode', Icons.dark_mode, () {
                  setState(() {
                    isDarkMode = !isDarkMode;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1D24CA), // Text color updated
        ),
      ),
    );
  }

  Widget buildListTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF1D24CA)),
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xFF1D24CA), // Text color updated
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF1D24CA)),
      onTap: onTap,
    );
  }
}
