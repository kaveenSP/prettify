import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:prettify1/main.dart';
import 'package:prettify1/pages/editProfileScreen.dart';

class settings_screen extends StatelessWidget {
  const settings_screen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF8BBD0),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); //navigate to the previous screen
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Center(
          child: Text("Settings"),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(image: AssetImage("images/avatar.png")),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Shenal Fernando",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "shenalF22@gmail.com",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: 200,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFFF8BBD0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    )
                    // child: ElevatedButton(
                    //   onPressed: () {},
                    //   style: ElevatedButton.styleFrom(
                    //       backgroundColor: Color(0xFFF8BBD0),
                    //       side: BorderSide.none,
                    //       shape: const StadiumBorder()),
                    //   child: const Text(
                    //     "Edit Profile",
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    // ),
                    ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  child: Container(
                    height: 50,
                    width: 200,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xFFF8BBD0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Delete Account',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
