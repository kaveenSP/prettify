import'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class imagepickerscreen extends StatefulWidget {
  const imagepickerscreen({super.key});

  @override
  State<imagepickerscreen> createState() => _imagepickerscreenState();
}

class _imagepickerscreenState extends State<imagepickerscreen> {
  File? _image;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('image picker'),
        backgroundColor: Colors.pink[100],
      ),
      body: Center(
        child: Column(
          children: [
            _image != null ? Image.file(_image!,width: 250, height: 250, fit: BoxFit.cover,)  :Image.asset(
                'images/screen.jpg'),
            SizedBox(
              height: 30,
            ),
            CustomButton(
              title: 'Pick from gallery',
              icon: Icons.image_outlined,
              onClick: getImage,
            ),
            SizedBox(height: 10),
            CustomButton(  
              title: 'Pick from camera',
              icon: Icons.camera,
              onClick: () => {},
            ),
          ],
        ),
      ),
    );
  }

  Widget CustomButton({
    required String title,
    required IconData icon,
    required VoidCallback onClick,
  }) {
    return Container(
      width: 280,
      child: ElevatedButton(
        onPressed: onClick,
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 20,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class requried {}