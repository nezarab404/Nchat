import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/storage/shared_helper.dart';
import 'package:flutter_application_1/shared/validator.dart';
import 'package:flutter_application_1/src/home/home_screen.dart';
import 'package:flutter_application_1/src/login/login_screen.dart';
import 'package:flutter_application_1/src/register/cubit/register_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '/shared/component/components.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _username = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is CreateUserSuccessState) {
          SharedHelper.saveData(key: 'uId', value: state.uId)
              .then((value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  ));
        }

        if (state is SendEmailVerifySuccessState) {
          Fluttertoast.showToast(
            msg: "check your mail",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Register",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        MyTextField(
                          controller: _email,
                          label: "Email",
                          hint: "Please enter your email",
                          icon: Icons.email,
                          validator: (val) => Validator.emailValidator(val),
                        ),
                        MyTextField(
                          controller: _username,
                          label: "User Name",
                          hint: "Please enter your user name",
                          icon: Icons.person,
                          validator: (val) => Validator.nameValidator(val),
                        ),
                        MyTextField(
                          controller: _password,
                          label: "Password",
                          hint: "Please enter your password",
                          isPassword: true,
                          icon: Icons.lock,
                          validator: (val) => Validator.passwordValidator(val),
                        ),
                        MyTextField(
                          controller: _phone,
                          label: "Phone Number",
                          hint: "Please enter your phone number",
                          icon: Icons.call,
                          validator: (val) => Validator.phoneValidator(val),
                        ),
                        state is RegisterLoadingState
                            ? const Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                ),
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // showModalBottomSheet<bool>(
                                      //     context: context,
                                      //     builder: (context) {
                                      //       return Container(
                                      //         height: 700,
                                      //         color: Colors.white,
                                      //         child: WebViewPlus(
                                      //           javascriptMode:
                                      //               JavascriptMode.unrestricted,
                                      //           onWebViewCreated: (controller) {
                                      //             controller.loadUrl(
                                      //                 "assets/web_pages/index.html");
                                      //           },
                                      //           javascriptChannels: {
                                      //             JavascriptChannel(
                                      //                 name: 'Captcha',
                                      //                 onMessageReceived:
                                      //                     (JavascriptMessage
                                      //                         message) {
                                      //                   print("koko: $message");
                                      //                 })
                                      //           },
                                      //         ),
                                      //       );
                                      //     }).then((value) {
                                      //   print(value);
                                      RegisterCubit.get(context).register(
                                          email: _email.text,
                                          password: _password.text,
                                          username: _username.text,
                                          phone: _phone.text);
                                      // });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      "Lets Go!!",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("already have an account? "),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => LoginScreen()));
                                },
                                child: const Text("Login"))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
