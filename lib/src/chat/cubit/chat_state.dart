part of 'chat_cubit.dart';

@immutable
abstract class ChatStates {}

class ChatInitial extends ChatStates {}

class SendMessageSuccessState extends ChatStates {}

class SendMessageErrorState extends ChatStates {}

class SendImageMessageSuccessState extends ChatStates {}

class SendImageMessageErrorState extends ChatStates {}

class GetMessagesSuccessState extends ChatStates {}

class ImagePickedSuccessState extends ChatStates {}

class ImagePickedErrorState extends ChatStates {}
