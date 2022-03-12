import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/src/chat/chat_screen.dart';
import 'package:flutter_application_1/src/home/cubit/home_cubit.dart';
import 'package:flutter_application_1/src/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFriendScreen extends StatelessWidget {
  const AddFriendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: state is HomeGetAllUsersLoadingState
              ? const Center(child: CircularProgressIndicator())
              : HomeCubit.get(context).allUsersList.isEmpty
                  ? const Center(
                      child: Text("There is no Friends !!!"),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return buildUserItem(
                            context,
                            HomeCubit.get(context).allUsersList[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: HomeCubit.get(context).allUsersList.length,
                      ),
                    ),
        );
      },
    );
  }

  Widget buildUserItem(BuildContext context, UserModel model) => InkWell(
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) =>  ChatScreen(model:model)));
        },
        child: ListTile(
          leading: CircleAvatar(
            radius: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Image.network(
                model.profileImage!,
                fit: BoxFit.fill,
              ),
            ),
          ),
          title: Text(model.name!),
        ),
      );
}
