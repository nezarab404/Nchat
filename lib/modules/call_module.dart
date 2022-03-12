import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/call_model.dart';

class CallModule {
  static CallModule? _callModule;

  static CallModule get instance {
    if (_callModule != null) {
      return _callModule!;
    }
    return CallModule();
  }



  Future<bool> makeCall({required CallModel call}) async {
    try {
      call.hasDialled = true;
      Map<String, dynamic> hasDialledMap = call.toMap();
      call.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = call.toMap();

      await FirebaseFirestore.instance
          .collection('calls')
          .doc(call.callerId)
          .set(hasDialledMap);
      await FirebaseFirestore.instance
          .collection('calls')
          .doc(call.receiverId)
          .set(hasNotDialledMap);
      return true;
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> endCall({required CallModel call}) async {
    try {
      await FirebaseFirestore.instance
          .collection('calls')
          .doc(call.callerId)
          .delete();
      await FirebaseFirestore.instance
          .collection('calls')
          .doc(call.receiverId)
          .delete();

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
