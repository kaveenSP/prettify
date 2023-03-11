import 'dart:ui';

import 'package:flutter/material.dart';
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
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Prettify'),
        centerTitle: true,
        backgroundColor: Colors.pink[100],
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.38,
            width: size.width,
            child: Row(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: Lottie.network(
                    'https://assets4.lottiefiles.com/packages/lf20_pt810qkq.json',
                  ),
                )
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
                )),
          ),

          SizedBox(
            height: 20,
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
                    child: Lottie.network(
                      'https://assets4.lottiefiles.com/packages/lf20_pt810qkq.json',
                    ),
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
          Container(
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
          SizedBox(
            height: 24,
          ),

          Center(
            child: ElevatedButton(
              style: buttonPrimary = ElevatedButton.styleFrom(
                  minimumSize: Size(345, 50),
                  primary: Color.fromARGB(255, 255, 166, 197),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => imagepickerscreen()));
              },
              child: Text('Get Started'),
            ),
          ),
        ],
      ),
    );
  }
}
