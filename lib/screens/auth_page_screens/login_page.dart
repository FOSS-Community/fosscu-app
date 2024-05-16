import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';
import 'package:fosscu_app/services/auth/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

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

  bool isLoading = false;
  /// Email Text Controller
  // final emailController = TextEditingController();

  // /// Password Text Controller
  // final passwordController = TextEditingController();

  /// Sign user in method
  // void signUserIn() async {
  //   /// Loading
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       });

  //   /// try sign in
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );

  //     /// pop loading
  //     // ignore: use_build_context_synchronously
  //     Navigator.pop(context);
  //   } on FirebaseAuthException catch (e) {
  //     /// pop loading
  //     Navigator.pop(context);

  //     /// Show error message
  //     errorMessage(e.code);
  //   }
  // }

  /// Method to show error message

  // void errorMessage(String message) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text(message),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
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

                Container(
                  margin: EdgeInsets.all(screenWidth * 0.1).copyWith(bottom: 0),
                  child: Text(
                    'Welcome to FOSS Community',
                    style: GoogleFonts.leagueSpartan(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.06),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(screenWidth * 0.1)
                      .copyWith(top: 0, bottom: 0),
                  child: Text(
                    'where the spirit of open source thrives!',
                    style: GoogleFonts.leagueSpartan(
                        color: greenColor,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.0425),
                  ),
                ),
                SizedBox(height: screenHeight * 0.15,),
                // /// Email Field
                // AuthField(
                //   icon: Icons.mail,
                //   controller: emailController,
                //   hintText: ' email',
                //   obscureText: false,
                // ),

                // SizedBox(height: screenHeight * 0.03),

                /// Password Field
                // AuthField(
                //   icon: Icons.key,
                //   controller: passwordController,
                //   hintText: ' password',
                //   obscureText: true,
                // ),

                // SizedBox(height: screenHeight * 0.02),

                // /// Forgot Password

                // const Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         'Forgot Password?',
                //         style: TextStyle(
                //           color: Colors.white,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // SizedBox(height: screenHeight * 0.02),

                // /// Sign in Button
                // AuthButton(
                //   onTap: signUserIn,
                //   text: 'Sign in',
                // ),

                // SizedBox(height: screenHeight * 0.01),

                /// Sign In With Services

                /// Not a member
                // SizedBox(height: screenHeight * 0.02),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text(
                //       'Not a member? ',
                //       style: TextStyle(color: Colors.white),
                //     ),
                //     GestureDetector(
                //       onTap: widget.onTap,
                //       child: const Text(
                //         ' Register Now',
                //         style: TextStyle(
                //             color: Colors.blueAccent,
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: screenHeight * 0.05),
                GestureDetector(
                  onTap: () {
                    AuthService().signInWithGoogle();
                    setState(() {
                    isLoading = true;
                    });
                  },
                  child: Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.07,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: brightGreyColor,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: !isLoading? const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                    ):const Center(child: CircularProgressIndicator(color: Colors.white,))
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
