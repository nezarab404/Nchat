import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginLoadingState());
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print("${value.user!.email}");
        print("kkkkkkkkkk" + value.user!.emailVerified.toString());
        isEmailVerified = value.user!.emailVerified;
        emit(LoginSuccessState(value.user!.uid));
      }).catchError((error) {
        emit(LoginErrorState(error.toString().split(']').last));
      });
    } catch (error) {
      emit(LoginErrorState(error.toString().split(']').last));
    }
  }
}
