/// Purpose of this page is to switch between login and register page
import 'package:flutter/material.dart';
import 'package:fosscu_app/screens/auth_page_screens/login_page.dart';
import 'package:fosscu_app/screens/auth_page_screens/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {

  /// Initially show login page
  
  bool showLoginPage = true;

  /// Toggle  between Login and Register Page
  
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // if(showLoginPage){
    return LogInPage(
      onTap: togglePages
    );
    // } 
    // removing register page as we need only continue with google as an option
    // else {
    //   return RegisterPage(
    //     onTap: togglePages
    //   );
    // }
  }
}