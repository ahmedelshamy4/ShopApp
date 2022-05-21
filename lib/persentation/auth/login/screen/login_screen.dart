import 'package:flutter/material.dart';

import '../widget/dont_hane_acount.dart';
import '../widget/login_button.dart';
import '../widget/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 100.0, right: 15.0, left: 15.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/background_login.png",
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 250.0,
                width: 250.0,
                child: Image.asset(
                  "assets/images/logo.png",
                ),
              ),
              const SizedBox(
                height: 70.0,
              ),
              const LoginForm(),
              const SizedBox(height: 40),
              const SubmitLogin(),
              const SingUp(),
            ],
          ),
        ),
      ),
    );
  }
}
