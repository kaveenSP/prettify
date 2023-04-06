import 'dart:io';
import 'package:path/path.dart' as path;
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prettify1/homepage.dart';
import 'package:prettify1/imagepickerscreen.dart';
import 'package:prettify1/login/Login_Screen.dart';
import 'package:prettify1/login/SignUp_Screen.dart';
import 'package:prettify1/util/category_card.dart';
import 'package:http/http.dart' as http;

import 'navigation_drawer.dart';
import 'package:lottie/lottie.dart';
import 'imagepickerscreen.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

String baseUrl = '';

main() async {
  baseUrl = "https://94d0-112-134-149-113.in.ngrok.io";
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: Home(),
      home: AnimatedSplashScreen(
        splash: Image.asset('images/logonew.png'),
        nextScreen: const TutorialScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
        duration: 3000,
      ),
     ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TutorialScreen(),
    );
  }
}

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  int _currentPageIndex = 0;
  CarouselController _carouselController = CarouselController();

  final List<String> _imageList = [
    'images/img1.jpeg',
    'images/img2.jpeg',
    'images/img3.jpeg',
  ];

  final List<String> _descriptionList = [
    'Welcome to Prettify',
    'Worried about acne?',
    'We got you covered',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 55.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CarouselSlider(
                  items: _imageList.asMap().entries.map(
                    (entry) {
                      int index = entry.key;
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80.0,
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFA6C5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(entry.value),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 1,
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.7),
                                      Colors.white.withOpacity(0.1),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                  options: CarouselOptions(
                    height: double.infinity,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                  ),
                  carouselController: _carouselController,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                _descriptionList[_currentPageIndex],
                style: GoogleFonts.poppins(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                child: Text(
                  _currentPageIndex == _imageList.length - 1
                      ? 'Get Started'
                      : 'Skip Tutorial',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFFFA6C5)),
                  fixedSize: MaterialStateProperty.all<Size>(Size(350, 50)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewPage()),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: _imageList.asMap().entries.map((entry) {
                  int index = entry.key;
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPageIndex == index
                          ? Colors.blue
                          : Colors.grey.withOpacity(0.5),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  const NewPage({Key? key}) : super(key: key);

  final Color pink = const Color(0xFFFFA6C5);
  final Color green = const Color(0xFFDFFFD8);
  final Color blue = const Color(0xFFB4E4FF);
  final Color darkBlue = const Color(0xFF95BDFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 100.0,
              ),
              child: Image.asset(
                'images/logonew.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Welcome to Prettify',
                style: GoogleFonts.poppins(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.login),
                label: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );},
                style: ElevatedButton.styleFrom(
                    primary: pink,
                    onPrimary: Colors.white,
                    minimumSize: Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: ElevatedButton.icon(
                icon: Icon(Icons.person_add),
                label: Text(
                  'Sign Up',
                  style: GoogleFonts.poppins(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupScreen()),
            );},
                style: ElevatedButton.styleFrom(
                    primary: pink,
                    onPrimary: Colors.white,
                    minimumSize: Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.person),
                label: Text(
                  'Continue as guest',
                  style: GoogleFonts.poppins(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );},
                style: ElevatedButton.styleFrom(
                    primary: pink,
                    onPrimary: Colors.white,
                    minimumSize: Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
              ),
            ),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}































































































































































































































































