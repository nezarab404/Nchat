import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/call_model.dart';
import 'package:flutter_application_1/src/call/call_screen.dart';
import 'package:flutter_application_1/src/pickup/cubit/pickup_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickUpScreen extends StatelessWidget {
  const PickUpScreen({Key? key, required this.call}) : super(key: key);
  final CallModel call;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickupCubit, PickupStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 43, 42, 42),
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 90),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Incomming ...',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),
                CircleAvatar(
                  radius: 90,
                  backgroundImage: NetworkImage(call.callerImg!),
                ),
                const SizedBox(height: 30),
                Text(
                  call.callerName!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CallScreen(call: call)));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: const Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        PickupCubit.get(context).endingCall(call);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: const Icon(
                          Icons.call_end,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
