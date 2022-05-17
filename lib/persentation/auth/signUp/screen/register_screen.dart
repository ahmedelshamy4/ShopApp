import 'package:flutter/material.dart';
import 'package:flutter_shop_store/persentation/auth/signUp/widget/register_button.dart';

import '../widget/already_have_acount.dart';
import '../widget/register_form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: SingleChildScrollView(
          child: Column(
            children: const [
              RegisterForm(),
              SizedBox(height: 30.0),
              RegisterButton(),
              SizedBox(height: 10.0),
              SignIn(),
            ],
          ),
        ),
      ),
    );
  }
}
