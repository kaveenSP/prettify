import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prettify1/Fade_Animation.dart';
import 'package:prettify1/homepage.dart';
import 'package:prettify1/login/Forgot_Password_Screen.dart';
import 'package:prettify1/login/SignUp_Screen.dart';
import 'package:prettify1/main.dart';
import 'package:prettify1/models/loginUser.dart';
import 'package:prettify1/services/create_user.dart';

import '../Hex_Color.dart';

enum FormData {
  Email,
  password,
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color enabled = const Color.fromARGB(255, 247, 200, 224);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.black;
  Color backgroundColor = const Color(0xFFFFA6C5);
  bool ispasswordev = true;
  FormData? selected;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 0.4, 0.7, 0.9],
            colors: [
              HexColor("#FFFFA6C5"),
              HexColor("#FFFFA6C5"),
              HexColor("#FFFFA6C5"),
              HexColor("#FFFFA6C5"),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Container(
                    width: 400,
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FadeAnimation(
                          delay: 0.8,
                          child: Lottie.network(
                            'https://assets4.lottiefiles.com/packages/lf20_1t8na1gy.json',
                            width: 150,
                            height: 150,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: const Text(
                            "Please log in to continue",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                letterSpacing: 0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.Email
                                  ? enabled
                                  : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: emailController,
                              onTap: () {
                                setState(() {
                                  selected = FormData.Email;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.person_outlined,
                                  color: selected == FormData.Email
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                ),
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                    color: selected == FormData.Email
                                        ? enabledtxt
                                        : deaible,
                                    fontSize: 12),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.Email
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: selected == FormData.password
                                    ? enabled
                                    : backgroundColor),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: passwordController,
                              onTap: () {
                                setState(() {
                                  selected = FormData.password;
                                });
                              },
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.lock_open_outlined,
                                    color: selected == FormData.password
                                        ? enabledtxt
                                        : deaible,
                                    size: 20,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: ispasswordev
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: selected == FormData.password
                                                ? enabledtxt
                                                : deaible,
                                            size: 20,
                                          )
                                        : Icon(
                                            Icons.visibility,
                                            color: selected == FormData.password
                                                ? enabledtxt
                                                : deaible,
                                            size: 20,
                                          ),
                                    onPressed: () => setState(
                                        () => ispasswordev = !ispasswordev),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      color: selected == FormData.password
                                          ? enabledtxt
                                          : deaible,
                                      fontSize: 12)),
                              obscureText: ispasswordev,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.password
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextButton(
                              onPressed: () async {
                                Navigator.pop(context);

                                LoginUser newLoginUser = new LoginUser(
                                    name: emailController.text,
                                    password: passwordController.text);
                                var isLegit =
                                    await ServiceUser.getUser(newLoginUser);
                                if (isLegit) {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return Home();
                                  }));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: Text(
                                                "Incorrect USername and Password !"),
                                          ));
                                }
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFA6C5),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0, horizontal: 80),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0))),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                //End of Center Card
                //Start of outer card
                const SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  delay: 1,
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ForgotPasswordScreen();
                      }));
                    }),
                    child: const Text("Forget Password",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0.5,
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                FadeAnimation(
                  delay: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Don't have an account? ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            letterSpacing: 0.5,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return SignupScreen();
                          }));
                        },
                        child: Text("Sign up",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.9),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                fontSize: 18)),
                      ),
                    ],
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
