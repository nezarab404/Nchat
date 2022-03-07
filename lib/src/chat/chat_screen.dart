import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/src/chat/cubit/chat_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key, required this.model}) : super(key: key);
  final UserModel model;
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ChatCubit.get(context).getMessages(receiverId: model.uId!);
        return BlocConsumer<ChatCubit, ChatStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: ((context, index) => buildChatMessage()),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: 10,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        controller: controller,
                        decoration: const InputDecoration(
                            fillColor: Colors.grey,
                            hintText: "type your message ..."),
                      )),
                      IconButton(
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            ChatCubit.get(context).sendMessage(
                                message: controller.text,
                                receiverId: model.uId!);
                          }
                          controller.text = '';
                        },
                        icon: const Icon(Icons.send),
                        color: Colors.blue,
                      )
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Padding buildChatMessage() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 54, 120, 244),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "hello",
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
