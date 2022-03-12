import 'package:flutter_application_1/models/call_model.dart';
import 'package:flutter_application_1/modules/call_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'pickup_state.dart';

class PickupCubit extends Cubit<PickupStates> {
  PickupCubit() : super(PickupInitial());

  static PickupCubit get(context) => BlocProvider.of(context);

  void endingCall(CallModel call) {
    emit(PickupEndCallLoadingState());
    CallModule.instance.endCall(call: call).then((value) {
      emit(PickupEndCallSuccessState());
    }).catchError((error) {
      emit(PickupEndCallErrorState(error.toString()));
    });
  }

}
