import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_application_1/models/message_model.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  List<MessageModel> messages = [];
  File? pickedImage;

  void sendMessage({
    required String message,
    required String receiverId,
  }) {
    MessageModel model = MessageModel(
        message: message,
        receiverId: receiverId,
        senderId: uId,
        dateTime: DateTime.now().toString());
    print(model.toMap());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessagesSuccessState());
    });
  }

  Future pickImage() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      if (image == null) return;
      pickedImage = File(image.path);
      emit(ImagePickedSuccessState());
    }).catchError((error) {
      emit(ImagePickedErrorState());
    });
  }

  void sendImage({required String receiverId}) {
    pickImage().then((value) {
      String imageName = pickedImage!.path.split('/').last;
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('chats/')
          .child("$receiverId/$imageName")
          .putFile(pickedImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          MessageModel model = MessageModel(
              message: value,
              senderId: uId,
              receiverId: receiverId,
              dateTime: DateTime.now().toString(),
              isImage: true);

          FirebaseFirestore.instance
              .collection('users')
              .doc(uId)
              .collection('chats')
              .doc(receiverId)
              .collection('messages')
              .add(model.toMap())
              .then((value) {
            emit(SendImageMessageSuccessState());
          }).catchError((error) {
            emit(SendImageMessageErrorState());
          });
        });
      });
    });
  }
}
