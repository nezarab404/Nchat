import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/call_model.dart';
import 'package:flutter_application_1/src/call/cubit/call_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({Key? key, required this.call}) : super(key: key);
  final CallModel call;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CallCubit, CallStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black38,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Call has been made",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    CallCubit.get(context).endingCall(call);
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.call_end,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
