import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/message_model.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_application_1/src/call/call_screen.dart';
import 'package:flutter_application_1/src/chat/cubit/chat_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
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
            if (state is VideoCallSuccessState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CallScreen(call: state.call)));
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        model.profileImage!,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(model.name!),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      ChatCubit.get(context).makeVideoCall(model);
                    },
                    icon: const Icon(Icons.video_call),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: ((context, index) => buildChatMessage(
                            ChatCubit.get(context).messages[index],
                          )),
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
                          if (controller.text.trim().isNotEmpty) {
                            ChatCubit.get(context).sendMessage(
                                message: controller.text.trim(),
                                receiverId: model.uId!);
                          }
                          controller.clear();
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
        child: Row(
          mainAxisAlignment: message.senderId == userModel!.uId!
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.senderId != userModel!.uId!)
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(model.profileImage!),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: message.senderId == userModel!.uId!
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: message.senderId == userModel!.uId!
                          ? const Color.fromARGB(255, 228, 228, 228)
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: message.isImage!
                        ? SizedBox(
                            width: 200,
                            child: Image.network(
                              message.message!,
                            ),
                          )
                        : Text(
                            "${message.message}",
                            style: TextStyle(
                                fontSize: 18,
                                color: message.senderId == userModel!.uId!
                                    ? Colors.black
                                    : Colors.white),
                          ),
                  ),
                  Text(message.dateTime!
                      .split(' ')
                      .last
                      .split('.')
                      .first
                      .substring(0, 5))
                ],
              ),
            ),
            if (message.senderId == userModel!.uId!)
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(userModel!.profileImage!),
              ),
          ],
        ),
      ),
    );
  }
}
