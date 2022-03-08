import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/message_model.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/shared/constants.dart';
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
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: ((context, index) => buildChatMessage(
                            ChatCubit.get(context).messages[index],
                          )),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: ChatCubit.get(context).messages.length,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: controller,
                          decoration: const InputDecoration(
                              fillColor: Colors.grey,
                              hintText: "type your message ..."),
                        ),
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
                      ),
                      IconButton(
                        onPressed: () {
                          ChatCubit.get(context)
                              .sendImage(receiverId: model.uId!);
                        },
                        icon: const Icon(Icons.photo),
                        color: Colors.blue,
                      ),
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

  Padding buildChatMessage(MessageModel message) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: message.senderId == userModel!.uId!
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: message.senderId == userModel!.uId!
                ? Colors.grey
                : const Color.fromARGB(255, 54, 120, 244),
            borderRadius: BorderRadius.only(
              topLeft: message.senderId == userModel!.uId!
                  ? const Radius.circular(15)
                  : const Radius.circular(0),
              topRight: message.senderId == userModel!.uId!
                  ? const Radius.circular(0)
                  : const Radius.circular(15),
              bottomRight: const Radius.circular(15),
              bottomLeft: const Radius.circular(15),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              message.isImage!
                  ? Image.network(
                      message.message!,
                      height: 400,
                      width: 200,
                    )
                  : Text(
                      "${message.message}",
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
              Text("${message.dateTime}")
            ],
          ),
        ),
      ),
    );
  }
}
