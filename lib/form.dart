import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const PhoneInputScreen(
        
      ),
    );
  }
}
