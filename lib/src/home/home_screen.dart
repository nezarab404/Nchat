import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_application_1/shared/storage/shared_helper.dart';
import 'package:flutter_application_1/src/add_friend/add_friend_screen.dart';
import 'package:flutter_application_1/src/home/cubit/home_cubit.dart';
import 'package:flutter_application_1/src/home/cubit/home_state.dart';
import 'package:flutter_application_1/src/login/login_screen.dart';
import 'package:flutter_application_1/src/profile/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
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
                    uId = '';

                    FirebaseAuth.instance.signOut().then((value) {
                      SharedHelper.removeData(key: 'uId').then((value) {
                        HomeCubit.get(context).usersList = [];
                        HomeCubit.get(context).user = null;
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
                // UserAccountsDrawerHeader(
                //   accountName: Text(HomeCubit.get(context).user!.name!),
                //   accountEmail: Text(HomeCubit.get(context).user!.email!),
                //   currentAccountPicture:
                //       Image.network(HomeCubit.get(context).user!.profileImage!),
                //   currentAccountPictureSize: const Size.square(100),
                //   onDetailsPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (_) => const ProfileScreen()));
                //   },
                // ),
              ],
            ),
          ),
          body: Container(
            alignment: Alignment.center,
            child: state is HomeGetUserLoadingState
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return buildUserItem();
                      },
                      separatorBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Divider(
                            height: 25,
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.person_add),
            onPressed: () {
              HomeCubit.get(context).getAllUsers();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddFriendScreen(),
                  ));
            },
          ),
        );
      },
    );
  }

  Widget buildUserItem() => InkWell(
        onTap: () {},
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          title: Text("name"),
        ),
      );
}
