import 'package:first_flutter_application/pages/home_page.dart';
import 'package:first_flutter_application/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:async';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignUpState();
}

class _SignUpState extends State<SignIn> {
  bool _passwordVisible = false;
  bool _invalidInput = false;
  bool _invalidEmail = false;
  bool _invalidPassword = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _warningText = '';

  // void onSignInTap() {}
  void swapPasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void onSignInTap() {
    if (!EmailValidator.validate(_emailController.text)) {
      setState(() {
        _invalidInput = true;
        _invalidEmail = true;

        Timer(const Duration(seconds: 3), () {
          setState(() {
            _invalidInput = false;
            _invalidEmail = false;
          });
        });
        _warningText = "Please enter a valid email";
      });
    } else if (_passwordController.text.isEmpty) {
      setState(() {
        _invalidInput = true;
        _invalidPassword = true;

        Timer(const Duration(seconds: 3), () {
          setState(() {
            _invalidInput = false;
            _invalidPassword = false;
          });
        });
        _warningText = "Password can't be empty!";
      });
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(17, 17, 17, 1),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 84,
                ),
                SvgPicture.asset(
                  'lib/images/started.svg',
                  semanticsLabel: 'Hero Image',
                  height: 200,
                  width: 200,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: _invalidEmail
                                ? const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  )
                                : const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(215, 252, 112, 1),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: _invalidPassword
                                ? const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  )
                                : const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(215, 252, 112, 1),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: swapPasswordVisibility,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _invalidInput,
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text(
                        _warningText,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: GestureDetector(
                    onTap: () {
                      onSignInTap();
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(215, 252, 112, 1),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 150),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(27, 32, 51, 1),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}