import 'package:flutter/material.dart';
import 'package:hunger/data/response/status.dart';
import 'package:hunger/provider/login_provider.dart';
import 'package:hunger/res/component/my_button.dart';
import 'package:hunger/res/component/my_textfield.dart';
import 'package:hunger/res/component/squar_tile.dart';
import 'package:hunger/util/route/routes_name.dart';
import 'package:hunger/util/textfield_validator_util.dart';
import 'package:hunger/util/utils.dart';
import 'package:provider/provider.dart';
import '../../services/firebase_services/auth/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
              child: Consumer<LoginProvider>(
                  builder: (context, value, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          //logo
                          const Icon(
                            Icons.lock,
                            size: 100,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //welcome text
                          Text(
                            'Welcome back you\'ve been missed!',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 15),
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                          //user text field
                          Column(
                            children: [
                              //user text field
                              MyTextField(
                                type: TextFiledType.email,
                                controller: _emailController,
                                isPassword: false,
                                hintText: 'Email',
                                prefixIcon: const Icon(Icons.email_outlined),
                                errorMessage: value.invalidEmail,
                                onChanged: (email) {
                                  String? error = TextFieldValidatorUtil()
                                      .validateEmail(email: email);
                                  value.setInvalidEmailText(error);
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              //password text field
                              MyTextField(
                                type: TextFiledType.password,
                                controller: _passwordController,
                                hintText: 'Password',
                                prefixIcon:
                                    const Icon(Icons.lock_outline_sharp),
                                isPassword: true,
                                errorMessage: value.invalidPassword,
                                onChanged: (password) {
                                  String? error = TextFieldValidatorUtil()
                                      .validatePassword(password: password);
                                  value.setInvalidPasswordText(error);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),

                          //forgot password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RoutesName.forgotPasswordScreen);
                                  },
                                  child: const Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //login button
                          MyButton(
                            onPressed: () async {
                              await value.loginByEmailAndPassword(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text);

                              switch (value.loginResult.status) {
                                case Status.loading:
                                  debugPrint("STATE -> loading State");
                                  break;

                                case Status.success:
                                  debugPrint("STATE -> success State ${value.loginResult.data}");
                                  break;

                                case Status.error:
                                  debugPrint(
                                      "STATE -> error State-> ${value.loginResult.message}");
                                  if(!mounted) return;
                                  Utils.showFlushBar(context: context, message: value.loginResult.message.toString());
                                  break;

                                default:
                                  debugPrint("STATE -> default State");
                              }
                            },
                            text: 'Login',
                            child: value.loginResult.status == Status.loading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : null,
                          ),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                onTap: () => MyAuthService().signInWithGoogle(),
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
                                Navigator.pushNamed(
                                    context, RoutesName.signupScreen);
                              },
                              child: RichText(
                                  text: TextSpan(
                                      text: 'Not a member?',
                                      style: TextStyle(color: Colors.grey[500]),
                                      children: const [
                                    TextSpan(
                                        text: '  Register now',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600))
                                  ])),
                            ),
                          )
                        ],
                      )),
            ),
          ),
        ),
      ),
    );
  }
}
