import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prettify1/imagepickerscreen.dart';
import 'package:prettify1/util/category_card.dart';
import 'package:http/http.dart' as http;

import 'navigation_drawer.dart';
import 'package:lottie/lottie.dart';
import 'imagepickerscreen.dart';



class Home extends StatelessWidget {
  const Home({super.key});

  Future<Uint8List?> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    // Do something with the picked image file
    if (pickedFile != null) {
      print(pickedFile.path);
      
      // Add the image to the request as a file
      final file = File(pickedFile.path);
      // Create a multipart request using the http.MultipartRequest class
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://10.0.2.2:8000/upload_image'), // replace with your API endpoint  //10.0.2.2 is only for emulator
      );

      
      final stream = http.ByteStream(file.openRead());
      final length = await file.length();
      final multipartFile = http.MultipartFile('image', stream, length,
          filename: path.basename(file.path));
      request.files.add(multipartFile);

      // Send the request
      try{
        final response = await request.send();
        if (response.statusCode == 200) {
         // Get the image bytes from the response
      final bytes = await response.stream.toBytes();
      // Create a Uint8List from the image bytes
      final imageBytes = Uint8List.fromList(bytes);
      // Return the image bytes

      
      return imageBytes;
      } else {
        // Handle errors
        // ...
      }
      }catch(e){
        print(e);
      }
      

      
    }
  }


  // DELETE ACCOUNT FLUTTER SERVICE

Future<void> deleteAccount(String email) async {
  final response = await http.delete(Uri.parse('https://your-api-endpoint/users/$email'));
  if (response.statusCode == 200) {
    print('Account deleted successfully');
  } else {
    throw Exception('Failed to delete account: ${response.statusCode}');
  }
}
  //END OF DELETE ACCOUNT FLUTTER SERVICE


  Future<Uint8List?> getCameraImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    // Do something with the picked image file
    if (pickedFile != null) {
      print(pickedFile.path);
     
      // Add the image to the request as a file
      final file = File(pickedFile.path);
      // Create a multipart request using the http.MultipartRequest class
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://10.0.2.2:8000/upload_image'), // replace with your API endpoint  //10.0.2.2 is only for emulator
      );

      
      final stream = http.ByteStream(file.openRead());
      final length = await file.length();
      final multipartFile = http.MultipartFile('image', stream, length,
          filename: path.basename(file.path));
      request.files.add(multipartFile);

      // Send the request
      try{
        final response = await request.send();
      if (response.statusCode == 200) {
      // Get the image bytes from the response
      final bytes = await response.stream.toBytes();
      // Create a Uint8List from the image bytes
      final imageBytes = Uint8List.fromList(bytes);
      // Return the image bytes

      
      return imageBytes;
    } else {
      // Handle errors
      return null;
    }
      }catch(e){
        print(e);
      }
      

    }else{
      return null;
    }
  }

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
              // child: Row(
              //   children: [
              //     Container(
              //       alignment: Alignment.bottomLeft,
              //       padding: EdgeInsets.only(top: 50, left: 0),
              //       child: Image.asset("images/imgdes.png"),
              //     ),
              //   ],
              // ),

              child: Stack(
                children: [
                  Container(
                    height: 230,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "images/imgdes.png",
                        ),
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                    margin: EdgeInsets.only(top: 90),
                  ),
                  Positioned(
                    top: 40,
                    left: 50,
                    child: Text(
                      "Welcome To Prettify",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              decoration: BoxDecoration(
                  color: Color(0xFFF8BBD0),
                  image: DecorationImage(
                    alignment: Alignment.centerLeft,
                    image: AssetImage("images/undraw.png"),
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
            ),
          ),

          SizedBox(
            height: 5,
          ),

          //card in the main page
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFF8BBD0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      child: Image.asset('images/cardimg.png')),
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
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Prettify will help you for that, Join with us today !',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
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
            height: 20,
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
                      minimumSize: Size(160, 60),
                      primary: Color.fromARGB(255, 255, 166, 197),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                  onPressed: () async{
                    Uint8List? imageBytes = await getCameraImage();
                  

                    try{
                      showDialog(context: context, builder: ((context) => AlertDialog(content: Image.memory(imageBytes!),)));
                    }catch (e){
                      showDialog(context: context, builder: ((context) => AlertDialog(content: Text("something went wrong"),)));
                    }
                  },
                  child: Text('Camera'),
                ),
                SizedBox(
                  width: 17,
                ),
                ElevatedButton(
                  style: buttonPrimary = ElevatedButton.styleFrom(
                      minimumSize: Size(160, 60),
                      primary: Color(0xFFFFA6C5),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                  onPressed: () async{
                    Uint8List? imagebytes = await getImage();
                    try{
                      showDialog(context: context, builder: ((context) => AlertDialog(content: Image.memory(imagebytes!),)));
                    }catch (e){
                      showDialog(context: context, builder: ((context) => AlertDialog(content: Text("something went wrong"),)));
                    }
                    
                    //Navigator.push(
                    //context,
                    //MaterialPageRoute(
                    //builder: (context) => ImagePickerScreen()));
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
