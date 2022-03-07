import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/profile/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            //backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: ProfileCubit.get(context).pickedImage ==
                              null
                          ? NetworkImage(
                              ProfileCubit.get(context).user!.profileImage!)
                          : FileImage(ProfileCubit.get(context).pickedImage!)
                              as ImageProvider,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          ProfileCubit.get(context).pickImage();
                        },
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  ProfileCubit.get(context).user!.name!,
                  style: Theme.of(context).textTheme.headline4,
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text("Bio"),
                  subtitle: Text(ProfileCubit.get(context).user!.bio!),
                  tileColor: Color.fromARGB(8, 0, 0, 0),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text("Email"),
                  subtitle: Text(ProfileCubit.get(context).user!.email!),
                  tileColor: Color.fromARGB(8, 0, 0, 0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
