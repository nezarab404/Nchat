import 'dart:math';

import 'package:flutter_application_1/models/call_model.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/modules/call_module.dart';

class CallUtilities {
  static dial({required UserModel caller, required UserModel receiver}) async {
    CallModel call = CallModel(
        callerId: caller.uId,
        callerName: caller.name,
        callerImg: caller.profileImage,
        receiverId: receiver.uId,
        receiverName: receiver.name,
        receiverImg: receiver.profileImage,
        channelId: Random().nextInt(1000).toString());

    CallModule.instance.makeCall(call: call).then((value) {
      call.hasDialled = true;
      return value;
    }).catchError((error) {
      return false;
    });
  }
}
