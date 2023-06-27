import 'package:flutter/material.dart';
import 'package:hunger/provider/otp_validation.dart';
import 'package:hunger/res/component/my_button.dart';
import 'package:hunger/res/component/my_textfield.dart';
import 'package:hunger/res/component/squar_tile.dart';
import 'package:hunger/services/firebase_services/auth/auth_service.dart';
import 'package:hunger/util/route/routes_name.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  //logo
                  const Icon(
                    Icons.app_registration,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //welcome text
                  Text(
                    'Register your account!',
                    style: TextStyle(color: Colors.grey[700], fontSize: 15),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //user text field
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //user text field
                          MyTextField(
                            type: TextFiledType.email,
                            controller: _emailController,
                            isPassword: false,
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          //password text field
                          MyTextField(
                            type: TextFiledType.password,
                            controller: _passwordController,
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline_sharp),
                            isPassword: true,
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //signup button
                  Consumer<OtpValidation>(builder: (context, value, child){
                    return MyButton(
                      onPressed: () {
                        final isValidate = _formKey.currentState!.validate();

                        if (isValidate) {
                          value.sendOtp(userEmail: _emailController.text.trim());
                          Navigator.pushNamed(context, RoutesName.pinCodeVerificationScreen, arguments: {
                            'email':_emailController.text.trim(),
                            'password': _passwordController.text
                          });
                        } else {
                          debugPrint('invalid argument');
                        }
                      },
                      text: 'Signup',
                    );
                  }),
                  const SizedBox(
                    height: 25,
                  ),
                  //or continue with
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey[500],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //apple and google button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //apple button
                      SquareTile(
                        imagePath: 'assets/icons/apple.png',
                        onTap: () {},
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      //google button
                      SquareTile(
                        imagePath: 'assets/icons/google.png',
                        onTap: ()=> MyAuthService().signInWithGoogle(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  //not a member? register
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: RichText(
                          text: TextSpan(
                              text: 'Already have an account?',
                              style: TextStyle(color: Colors.grey[500]),
                              children: const [
                            TextSpan(
                                text: ' Login',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600))
                          ])),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
