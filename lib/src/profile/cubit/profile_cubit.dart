import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);

  UserModel? user;
  File? pickedImage;

  void getUser() {
    emit(ProfileGetUserLoadingState());
    updateVerify().then((value) => FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .get()
            .then((value) {
          print(value.data());
          user = UserModel.fromJson(value.data()!);
          emit(ProfileGetUserSuccessState());
        }).catchError((error) {
          emit(ProfileGetUserErrorState(error.toString().split(']').last));
        }));
  }

  Future<void> updateVerify() async {
    bool i = FirebaseAuth.instance.currentUser!.emailVerified;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update({'isEmailVerified': i});
  }

  Future pickImage() async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      if (image == null) return;
      pickedImage = File(image.path);
      emit(ProfileImagePickedSuccessState());
    }).catchError((error) {
      emit(ProfileImagePickedErrorState(error.toString()));
    });
  }

    void uploadImage() {
    String imageName = pickedImage!.path.split('/').last;
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/$imageName')
        .putFile(pickedImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .update({'profileImage': value}).then((value) {
          print("sssssssssssssssssssss");
        });
      });

      emit(ProfileImageUploadedSccessState());
    }).catchError((error) {
      emit(ProfileImageUploadedErrorState(error.toString()));
    });
  }
}
