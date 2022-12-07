import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:step/color_schemes.dart';
import 'package:step/screens/register_page.dart';
import 'package:step/vm/login_controller.dart';
import 'package:step/vm/login_state.dart';

class LoginPage extends StatefulHookConsumerWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  static bool passwordVisible = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(loginControllerProvider, ((previous, state) {
      if (state is LoginStateError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
        ));
      }
    }));

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
      body: Center(
          child: Expanded(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 35.0, right: 35.0, top: 35.0, bottom: 15.0),
              child: Text(
                "Let's Sign You In.",
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35.0),
              child: Text(
                "Welcome back. \nYou have been missed!",
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, bottom: 10, top: 10),
              child: TextFormField(
                controller: emailController,
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
                  hintText: "Username",
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
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
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
            const SizedBox(
              height: 120,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: secondaryColor),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Register",
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
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, bottom: 50.0),
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
                    ref.read(loginControllerProvider.notifier).login(
                        emailController.text.trim(),
                        passwordController.text.trim());
                  },
                  child: Text(
                    "Sign In",
                    style:
                        GoogleFonts.poppins(color: primaryColor, fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
