import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> sendPicture(File picture) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('http://your-python-backend-url.com/api/upload_picture'),
  );
  
  request.files.add(await http.MultipartFile.fromPath('picture', picture.path));
  
  var response = await request.send();
  
  if (response.statusCode == 200) {
    print('Picture sent successfully!');
  } else {
    print('Failed to send picture: ${response.statusCode}');
  }
}