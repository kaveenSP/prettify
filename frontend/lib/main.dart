import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prettify1/imagepickerscreen.dart';
import 'package:prettify1/util/category_card.dart';

import 'navigation_drawer.dart';
import 'package:lottie/lottie.dart';
import 'imagepickerscreen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonPrimary;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const NavigationDrawerLeft(),
      appBar: AppBar(
        title: const Text('Prettify'),
        centerTitle: true,
        backgroundColor: Color(0xFFF8BBD0),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: size.height * 0.38,
              width: size.width,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(top: 50, left: 10),
                    child: Image.asset(
                      'images/manfly.png',
                      height: 300,
                      width: 270,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.pink[100],
                  image: DecorationImage(
                      alignment: Alignment.centerLeft,
                      image: AssetImage("images/undraw.png")),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
            ),
          ),

          SizedBox(
            height: 10,
          ),

          //card in the main page
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: Image.asset('images/undraw.png')
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Want To Enhance Your beauty?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Prettify will help you for that, Join with us today !',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Read More ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Container(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryCard(
                    categoryName: 'Features ',
                    iconImagePath: 'images/icon1.png',
                  ),
                  CategoryCard(
                    categoryName: 'Eyebrows',
                    iconImagePath: 'images/icon2.png',
                  ),
                  CategoryCard(
                    categoryName: 'Oral aperture',
                    iconImagePath: 'images/icon3.png',
                  ),
                  CategoryCard(
                    categoryName: 'Hair Type',
                    iconImagePath: 'images/icon4.png',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),

          //new button bar
          Container(
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              buttonHeight: 70,
              buttonMinWidth: 100,
              buttonTextTheme: ButtonTextTheme.accent,
              buttonPadding: EdgeInsets.all(8.0),
              children: <Widget>[
                ElevatedButton(
                  style: buttonPrimary = ElevatedButton.styleFrom(
                      minimumSize: Size(160, 50),
                      primary: Color.fromARGB(255, 255, 166, 197),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                  onPressed: () => (ImageSource.gallery),
                  child: Text('Camera'),
                ),
                SizedBox(
                  width: 17,
                ),
                ElevatedButton(
                  style: buttonPrimary = ElevatedButton.styleFrom(
                      minimumSize: Size(160, 50),
                      primary: Color(0xFFFFA6C5),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => imagepickerscreen()));
                  },
                  child: Text('Gallery'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
