import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hunger/provider/otp_validation.dart';
import 'package:hunger/util/utils.dart';
import 'package:hunger/view/otp/component/otp_dialog.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../services/firebase_services/auth/auth_service.dart';

class PinCodeVerificationScreen extends StatefulWidget {
  final Map data;

  const PinCodeVerificationScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  PinCodeVerificationScreenState createState() =>
      PinCodeVerificationScreenState();
}

class PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  final TextEditingController _pinCodeEditingController =
      TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String pinCode = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    _pinCodeEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: GestureDetector(
          onTap: () {},
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Consumer<OtpValidation>(
              builder: (context, value, child) {
                return ListView(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    //logo
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset('assets/icons/apple.png'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    //email address verification text
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Email Address Verification',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    //enter the code sent
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8),
                      child: RichText(
                        text: TextSpan(
                            text: "Enter the code sent to ",
                            children: [
                              TextSpan(
                                  text: "${widget.data['email']}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ],
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 15)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //pin code text field
                    Form(
                      key: formKey,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 30),
                          //pin code field
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: Colors.green.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 6,

                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              inactiveFillColor: Colors.grey.shade200,
                              inactiveColor: Colors.grey,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: _pinCodeEditingController,
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (val) {
                              debugPrint(val);
                              setState(() {
                                pinCode = val;
                              });
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        hasError
                            ? "*Please fill up all the cells properly"
                            : "",
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //resend otp button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive the code? ",
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            value.sendOtp(userEmail: widget.data['email']);
                            Utils.snackBar(
                                context: context, message: "OTP resend!!");
                          },
                          child: const Text(
                            "RESEND",
                            style: TextStyle(
                                color: Color(0xFF91D3B3),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),

                    //verify button
                    Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 30),
                      decoration: BoxDecoration(
                          color: Colors.green.shade300,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.green.shade200,
                                offset: const Offset(1, -2),
                                blurRadius: 5),
                            BoxShadow(
                                color: Colors.green.shade200,
                                offset: const Offset(-1, 2),
                                blurRadius: 5)
                          ]),
                      child: ButtonTheme(
                        height: 50,
                        child: TextButton(
                          onPressed: () async {
                            formKey.currentState!.validate();
                            // conditions for validating
                            debugPrint("otp : ${value.otp}");
                            if (value.otp != _pinCodeEditingController.text ||
                                _pinCodeEditingController.text.isEmpty) {
                              errorController!.add(ErrorAnimationType
                                  .shake); // Triggering error shake animation
                              setState(() => hasError = true);
                            } else {
                              setState(() {
                                hasError = false;
                              });
                              //create new user
                              await MyAuthService().createUserWithEmailAndPassword(
                                      email: widget.data['email'],
                                      password: widget.data['password'])
                                  ? showDialog(
                                      context: context,
                                      builder: (context) => const OtpDialog())
                                  : Utils.snackBar(
                                      context: context,
                                      message:
                                          'Maybe the email address is already use');
                              //show alert dialog
                              ;
                            }
                          },
                          child: Center(
                              child: Text(
                            "VERIFY".toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),
                    //clear button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                            child: TextButton(
                          child: const Text("Clear"),
                          onPressed: () {
                            _pinCodeEditingController.clear();
                          },
                        )),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
