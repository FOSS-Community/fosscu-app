import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';
import 'package:fosscu_app/widgets/auth_widgets/auth_button.dart';
import 'package:fosscu_app/widgets/auth_widgets/auth_field.dart';

class LogInPage extends StatefulWidget {
  final Function()? onTap;
  const LogInPage({
    required this.onTap,
    super.key,
  });

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  /// Email Text Controller
  final emailController = TextEditingController();

  /// Password Text Controller
  final passwordController = TextEditingController();

  /// Sign user in method
  void signUserIn() async {
    /// Loading
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    /// try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      /// pop loading
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      /// pop loading
      Navigator.pop(context);

      /// Show error message
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
              SvgPicture.asset(
                fosscu,
                height: screenHeight * 0.2,
                width: screenWidth * 0.2,
              ),
              const Text(
                'Become a member of FOSSCU',
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

              SizedBox(height: screenHeight * 0.02),

              /// Forgot Password

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: brightGreyColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.01),

              /// Sign in Button
              AuthButton(
                onTap: signUserIn,
                text: 'Sign in',
              ),

              SizedBox(height: screenHeight * 0.01),

              /// Sign In With Services

              /// Not a member
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a member?'),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      ' Register Now',
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
