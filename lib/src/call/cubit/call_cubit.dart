import 'dart:async';

import 'package:flutter_application_1/models/call_model.dart';
import 'package:flutter_application_1/modules/call_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallStates> {
  CallCubit() : super(CallInitial());
  static CallCubit get(context) => BlocProvider.of(context);

  void endingCall(CallModel call) {
    emit(CallEndCallLoadingState());
    CallModule.instance.endCall(call: call).then((value) {
      emit(CallEndCallSuccessState());
    }).catchError((error) {
      emit(CallEndCallErrorState(error.toString()));
    });
  }

}
