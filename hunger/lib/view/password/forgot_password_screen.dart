import 'package:flutter/material.dart';
import 'package:hunger/res/component/my_button.dart';
import 'package:hunger/res/component/my_textfield.dart';
import 'package:hunger/res/values/colors.dart';
import 'package:hunger/view/password/component/forgot_pw_dialog.dart';
import '../../services/firebase_services/auth/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('Password Rest'),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter your email please, we\'ll send you password recovery link',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              //email field
              Form(
                  key: _formKey,
                  child: MyTextField(
                    type: TextFiledType.email,
                    controller: _emailController,
                    isPassword: false,
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                  )),

              const SizedBox(
                height: 30,
              ),

              //send button
              SizedBox(
                width: width / 2,
                child: MyButton(
                    onPressed: () {
                      MyAuthService()
                          .resetPassword(email: _emailController.text)
                          .then((value) {
                        value == true
                            ? showDialog(
                                context: context,
                                builder: (context) => const ForgotPwDialog(
                                      anime: 'assets/anime/email.json',
                                      message:
                                          'Recovery link sent, check your email',
                                    ))
                            : showDialog(
                                context: context,
                                builder: (context) => ForgotPwDialog(
                                      anime: 'assets/anime/error.json',
                                      message: value.toString(),
                                    ));
                      });
                    },
                    text: 'Send',
                    backgroundColor: const Color(green)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
