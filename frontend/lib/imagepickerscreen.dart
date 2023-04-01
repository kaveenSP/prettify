import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image;

  Future getImage() async {
    final image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
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
        title: Text('Image Picker'),
        backgroundColor: Colors.pink[100],
      ),
      body: Center(
        child: Column(
          children: [
            _image != null
                ? Image.file(
                    _image!,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  )
                : Image.asset('images/screen.jpg'),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: CustomButton(
                title: 'Pick from gallery',
                icon: Icons.image_outlined,
                onClick: getImage,
                color: Colors.pink, // set the button color here
              ),
            ),
            SizedBox(height: 10),
            CustomButton(
              title: 'Pick from camera',
              icon: Icons.camera,
              onClick: () => {},
              color: Colors.pink, // set the button color here
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onClick;
  final Color color; // add a required color parameter

  const CustomButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onClick,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          primary: color, // set the button color
        ),
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