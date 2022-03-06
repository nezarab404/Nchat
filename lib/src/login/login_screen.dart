import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/storage/shared_helper.dart';
import 'package:flutter_application_1/shared/validator.dart';
import 'package:flutter_application_1/src/login/cubit/login_cubit.dart';
import 'package:flutter_application_1/src/register/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/home_screen.dart';
import '/shared/component/components.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          SharedHelper.saveData(key: 'uId', value: state.uId)
              .then((value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  ));
        }
        if (state is LoginErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
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
                          "Login",
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
                          controller: _password,
                          label: "Password",
                          hint: "Please enter your password",
                          isPassword: true,
                          icon: Icons.lock,
                          validator: (val) => Validator.passwordValidator(val),
                        ),
                        state is LoginLoadingState
                            ?const Padding(
                              padding:  EdgeInsets.only(top:10),
                              child:  CircularProgressIndicator(),
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
                                      LoginCubit.get(context).login(
                                          email: _email.text,
                                          password: _password.text);
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
                            const Text("Don't have an account? "),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => RegisterScreen()));
                                },
                                child: const Text("Create account"))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Forget password ?"),
                            TextButton(
                                onPressed: () {},
                                child: const Text("Reset password"))
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
