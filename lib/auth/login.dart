import 'dart:async';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:npassignment/shared/app_theme_shared.dart';
import 'package:npassignment/shared/dialogs.dart';
import 'package:npassignment/shared/utility.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => DialogShared.doubleButtonDialog(
          context, "Are you sure you want to exit", () {
        SystemNavigator.pop();
      }, () {
        Navigator.pop(context);
      }),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppThemeShared.appBar(title: "Login", context: context),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 18),
                Image.asset(
                  'assets/images/logo.jpg',
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 250,
                  fit: BoxFit.fill,
                ),
                // Center(
                //   child: SizedBox(
                //     width: MediaQuery.of(context).size.width * 0.85,
                //     child: Text(
                //       "Please Login to Continue",
                //       textAlign: TextAlign.center,
                //       style: Theme.of(context)
                //           .textTheme
                //           .headline1!
                //           .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
                Center(
                  child: Form(
                      key: loginFormKey,
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: AppThemeShared.textFormField(
                              context: context,
                              validator: Utility.phoneNumberValidator,
                              keyboardType: TextInputType.number,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              hintText: 'Please enter your phone number',
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10)
                              ],
                              suffixIcon: const Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: AppThemeShared.textFormField(
                                  context: context,
                                  obscureText: obscureText,
                                  validator: Utility.passwordValidator,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  hintText: 'Please enter your password',
                                  suffixIcon: GestureDetector(
                                    onTap: () => setState(() {
                                      obscureText = !obscureText;
                                    }),
                                    child: Icon(
                                      obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                  ))),
                          const SizedBox(height: 20),
                          AppThemeShared.argonButtonShared(
                            context: context,
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.8,
                            borderRadius: 12,
                            color: AppThemeShared.buttonColor,
                            buttonText: "Login",
                            onTap: (startLoading, stopLoading, buttonState) {
                              if (buttonState == ButtonState.Idle) {
                                final valid =
                                    loginFormKey.currentState!.validate();
                                startLoading();

                                if (valid) {
                                  //This delay is only to show the loading button animation
                                  Timer(const Duration(milliseconds: 500), () {
                                    Navigator.pushNamed(
                                        context, "/allproducts");
                                    stopLoading();
                                  });
                                } else {
                                  stopLoading();
                                }
                              }
                            },
                          ),
                        ],
                      )),
                ),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey[900],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "Or login with",
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey[900],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.asset(
                            'assets/images/googleIcon.png',
                            fit: BoxFit.fill,
                          )),
                      SizedBox(
                          height: 60,
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/facebookIcon.png',
                              fit: BoxFit.fill,
                            ),
                          )),
                    ],
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
