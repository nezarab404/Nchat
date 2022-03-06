import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/storage/shared_helper.dart';
import 'package:flutter_application_1/src/home/cubit/home_cubit.dart';
import 'package:flutter_application_1/src/home/cubit/home_state.dart';
import 'package:flutter_application_1/src/login/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              child: const Text(
                "logout",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  SharedHelper.removeData(key: 'uId').then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  });
                });
              })
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("koko"),
              accountEmail: const Text("koko@g.com"),
              currentAccountPicture: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/connect-withme.appspot.com/o/2258594_1%20(2).jpg?alt=media&token=51a25145-6a51-4c07-b6be-29be3af768a0"),
            ),
          ],
        ),
      ),
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            alignment: Alignment.center,
            child: state is HomeGetUserLoadingState
                ? const CircularProgressIndicator()
                : Column(children: [
                  if(!HomeCubit.get(context).user!.isEmailVerified!)
                    Container(
                      width: double.infinity,
                      height: 50,
                      color: Colors.amber.withOpacity(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.info_outline,
                            color: Colors.red,
                          ),
                          Text(
                            "Pleas verify youe email",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          HomeCubit.get(context).pickedImage == null
                              ? NetworkImage(
                                  HomeCubit.get(context).user!.profileImage!)
                              : FileImage(HomeCubit.get(context).pickedImage!)
                                  as ImageProvider,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        HomeCubit.get(context).pickImage();
                      },
                      child: const Text("Pick"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        HomeCubit.get(context).uploadImage();
                      },
                      child: const Text("Upload"),
                    ),
                  ]),
          );
        },
      ),
    );
  }
}
