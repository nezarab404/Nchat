import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_application_1/src/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  UserModel? user;
  List<UserModel> usersList = [];
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
    usersList = [];

    FirebaseFirestore.instance.collection('users').get().then((value) {
      // ignore: avoid_function_literals_in_foreach_calls
      value.docs.forEach((element) {
        print(element.data());
        if (element.data()['email'] != user!.email!) {
          usersList.add(UserModel.fromJson(element.data()));
        }
      });
      emit(HomeGetAllUsersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeGetAllUsersErrorState());
    });
  }
}
