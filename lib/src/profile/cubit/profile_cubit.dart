import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      emit(ProfileImagePickedErrorState());
    });
  }
}
