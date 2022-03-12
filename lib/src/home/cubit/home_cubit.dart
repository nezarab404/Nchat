// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_application_1/src/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  String koko = "koko";

  UserModel? user;
  List<UserModel> allUsersList = [];
  List<UserModel> chatUsers = [];
  File? pickedImage;
  String? imageURL;
  void getUser() {
    emit(HomeGetUserLoadingState());
    updateVerify().then((value) => FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .get()
            .then((value) {
          print(value.data());
          user = userModel = UserModel.fromJson(value.data()!);
          emit(HomeGetUserSuccessState());
          getMyChats();
        }).catchError((error) {
          emit(HomeGetUserErrorState(error.toString().split(']').last));
        }));
  }

  Future<void> updateVerify() async {
    bool i = FirebaseAuth.instance.currentUser!.emailVerified;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update({'isEmailVerified': i});
  }

  // Future pickImage() async {
  //   await ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
  //     if (image == null) return;
  //     pickedImage = File(image.path);
  //     emit(ProfileImagePickedSuccessState());
  //   }).catchError((error) {
  //     emit(ProfileImagePickedErrorState());
  //   });
  // }

  // void uploadImage() {
  //   String imageName = pickedImage!.path.split('/').last;
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('users/$imageName')
  //       .putFile(pickedImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       imageURL = value;
  //       FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(uId)
  //           .update({'profileImage': value}).then((value) {
  //         print("sssssssssssssssssssss");
  //       });
  //     });

  //     emit(ProfileImageUploadedSccessState());
  //   }).catchError((error) {
  //     emit(ProfileImageUploadedErrorState());
  //   });
  // }

  void getAllUsers() {
    emit(HomeGetAllUsersLoadingState());
    allUsersList = [];

    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        print(element.data());
        if (element.data()['email'] != user!.email!) {
          allUsersList.add(UserModel.fromJson(element.data()));
        }
      });
      emit(HomeGetAllUsersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeGetAllUsersErrorState(error.toString()));
    });
  }

  void getMyChats() {
    emit(HomeGetMyChatsLoadingState());
    print('gettttttttttttttttttttttttttttt$uId');
    FirebaseFirestore.instance
        .collection('users')
   
        .get()
        .then((value) {
      print("pppppppppppppppp : ${value.docs}");
      koko = value.toString();
      value.docs.forEach((element) {
        print("******************************************");
        print('\n\n\n${element.data()['email']}\n\n\n');
        if (element.data()['uId'] != userModel!.uId) {
          print('koko');
          chatUsers.add(UserModel.fromJson(element.data()));
        }
      });
      emit(HomeGetMyChatsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeGetMyChatsErrorState(error.toString()));
    });
  }

  Stream<DocumentSnapshot> callStream() {
    return FirebaseFirestore.instance
        .collection('calls')
        .doc(userModel?.uId)
        .snapshots();
  }
}
