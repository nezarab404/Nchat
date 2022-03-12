import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/call_model.dart';
import 'package:flutter_application_1/src/home/cubit/home_cubit.dart';
import 'package:flutter_application_1/src/home/cubit/home_state.dart';
import 'package:flutter_application_1/src/pickup/pickup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickupLayout extends StatelessWidget {
  const PickupLayout({Key? key, required this.scaffold}) : super(key: key);
  final Widget scaffold;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return
              // state is! HomeGetUserSuccessState
              //     ? scaffold
              //     :
              StreamBuilder<DocumentSnapshot>(
            stream: HomeCubit.get(context).callStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.data() != null) {
                var call = CallModel.fromJson(
                  snapshot.data!.data() as Map<String, dynamic>,
                );
                if (!call.hasDialled!) {
                  return PickUpScreen(call: call);
                } else {
                  return scaffold;
                }
              }
              return scaffold;
            },
          );
        },
      );
    });
  }
}
