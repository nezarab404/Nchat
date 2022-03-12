part of 'chat_cubit.dart';

@immutable
abstract class ChatStates {}

class ChatInitial extends ChatStates {}

class SendMessageSuccessState extends ChatStates {}

class SendMessageErrorState extends ChatStates {
  final String error;

  SendMessageErrorState(this.error);
}

class SendImageMessageSuccessState extends ChatStates {}

class SendImageMessageErrorState extends ChatStates {
  final String error;

  SendImageMessageErrorState(this.error);
}

class GetMessagesSuccessState extends ChatStates {}

class ImagePickedSuccessState extends ChatStates {}

class ImagePickedErrorState extends ChatStates {
  final String error;

  ImagePickedErrorState(this.error);
}

class VideoCallLoadingState extends ChatStates {}

class VideoCallSuccessState extends ChatStates {
  final CallModel call;

  VideoCallSuccessState(this.call);
}

class VideoCallerrorState extends ChatStates {
  final String error;

  VideoCallerrorState(this.error);
}
