import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: IconButton(onPressed: () {}, icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text('Edit Profile'),
        backgroundColor: Color(0xFFF8BBD0),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Full Name"),
                      prefixIcon: Icon(LineAwesomeIcons.user),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("E-mail"),
                      prefixIcon: Icon(LineAwesomeIcons.envelope_1),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Phone No"),
                      prefixIcon: Icon(LineAwesomeIcons.phone),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Password"),
                      prefixIcon: Icon(LineAwesomeIcons.fingerprint),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
