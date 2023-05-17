import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
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
              SizedBox(height: screenHeight * 0.05),
              const Text(
                'Become a New member of FOSSCU',
                style: TextStyle(color: greenColor),
              ),

              /// Email Field
              AuthField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              SizedBox(height: screenHeight * 0.01),

              /// Password Field
              AuthField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              SizedBox(height: screenHeight * 0.01),

              /// Confirm Password Field
              AuthField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
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
                  const Text('Already have an account?'),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
