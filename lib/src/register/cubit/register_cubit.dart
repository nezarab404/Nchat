import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void register({
    required String email,
    required String password,
    required String username,
    required String phone,
  }) async {
    try {
      emit(RegisterLoadingState());
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        // emit(RegisterSuccessState());
        print('${value.user!.email}');
        uId = value.user!.uid;
        createUser(
            email: email,
            username: username,
            phone: phone,
            uId: value.user!.uid);
      }).catchError((error) {
        emit(RegisterErrorState(error.toString().split(']').last));
      });
    } catch (error) {
      emit(RegisterErrorState(error.toString().split(']').last));
    }
  }

  void createUser({
    required String email,
    required String username,
    required String phone,
    required String uId,
  }) {
    UserModel model =
        UserModel(email: email, name: username, phone: phone, uId: uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
        emit(SendEmailVerifySuccessState());
        emit(CreateUserSuccessState(uId));
      }).catchError((error) {
        emit(SendEmailVerifyerrorState(error.toString().split(']').last));
      });
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString().split(']').last));
    });
  }
}
