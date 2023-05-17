/// Purpose of this page is to switch between login and register page
import 'package:flutter/material.dart';

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
    if(showLoginPage){
    return LoginPage(
      onTap: togglePages()
    );
    } 
    else {
      return RegisterPage(
        onTap: togglePages()
      );
    }
  }
}