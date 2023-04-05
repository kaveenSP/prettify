import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> sendPicture(File picture) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('https://52e0-2402-4000-2380-58da-6143-391f-e9e4-3d21.in.ngrok.io/upload_image'),
  );
  
  request.files.add(await http.MultipartFile.fromPath('picture', picture.path));
  
  var response = await request.send();
  
  if (response.statusCode == 200) {
    print('Picture sent successfully!');
  } else {
    print('Failed to send picture: ${response.statusCode}');
  }
}