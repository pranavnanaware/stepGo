import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:step/color_schemes.dart';
import 'package:step/screens/login_page.dart';
import 'package:step/vm/login_controller.dart';

class RegisterPage extends StatefulHookConsumerWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  static bool passwordVisible = true;
  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.reply_sharp,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 35.0, right: 35.0, top: 35.0, bottom: 15.0),
                  child: Text(
                    "Welcome!",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 35.0, right: 35.0, bottom: 70),
                  child: Text(
                    "We are happy to see you.",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, bottom: 10, top: 10),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: secondaryColor,
                    style: const TextStyle(color: tertiaryColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: transitionColor,
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                      hintStyle: const TextStyle(color: secondaryColor),
                      hintText: "Email",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, bottom: 10, top: 10),
                  child: TextFormField(
                    controller: passwordController,
                    cursorColor: secondaryColor,
                    style: const TextStyle(color: tertiaryColor),
                    obscureText: !passwordVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: secondaryColor,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                      suffixIconColor: secondaryColor,
                      filled: true,
                      fillColor: transitionColor,
                      enabled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: secondaryColor,
                          width: 2.0,
                        ),
                      ),
                      hintStyle: const TextStyle(color: secondaryColor),
                      hintText: "Password",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: secondaryColor),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: Text(
                  "Sign In",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 50.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(350, 60)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  ref.read(loginControllerProvider.notifier).signUp(
                      emailController.text.trim(),
                      passwordController.text.trim());
                },
                child: Text(
                  "Register",
                  style: GoogleFonts.poppins(color: primaryColor, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
