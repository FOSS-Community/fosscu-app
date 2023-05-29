import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';
import 'package:fosscu_app/services/auth/auth_service.dart';
import 'package:fosscu_app/widgets/auth_widgets/auth_button.dart';
import 'package:fosscu_app/widgets/auth_widgets/auth_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    required this.onTap,
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /// Email Controller
  final emailController = TextEditingController();

  /// Password Controller
  final passwordController = TextEditingController();

  /// Confirm Password Controller
  final confirmPasswordController = TextEditingController();

  // sign user up method
  void signUserUp() async {
    // loading
    showDialog(
      context: context,
      builder: (context) {
        // ignore: avoid_unnecessary_containers
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try creating the user
    try {
      // check password confirmation
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        // show error

        errorMessage("Passwords don't match!");
      }

      // pop loading
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop loading
      Navigator.pop(context);
      // WRONG EMAIL

      // show error
      errorMessage(e.code);
    }
  }

  /// Method to show error message

  void errorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.08),
              SvgPicture.asset(
                fosscu,
                height: screenHeight * 0.25,
                width: screenWidth * 0.25,
              ),
              SizedBox(height: screenHeight * 0.1),

              /// Email Field
              AuthField(
                icon: Icons.mail,
                controller: emailController,
                hintText: ' email',
                obscureText: false,
              ),

              SizedBox(height: screenHeight * 0.01),

              /// Password Field
              AuthField(
                icon: Icons.key,
                controller: passwordController,
                hintText: ' password',
                obscureText: true,
              ),

              SizedBox(height: screenHeight * 0.01),

              /// Confirm Password Field
              AuthField(
                icon: Icons.key,
                controller: confirmPasswordController,
                hintText: ' confirm password',
                obscureText: true,
              ),

              SizedBox(height: screenHeight * 0.02),

              /// Sign up Button
              AuthButton(
                onTap: signUserUp,
                text: 'Sign up',
              ),

              SizedBox(height: screenHeight * 0.01),

              /// Sign In With Services

              /// Already a member
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      ' Login Now',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
              GestureDetector(
                onTap: () => AuthService().signInWithGoogle(),
                child: Container(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: brightGreyColor,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                      ),
                      Text(
                        'Continue with Google!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
