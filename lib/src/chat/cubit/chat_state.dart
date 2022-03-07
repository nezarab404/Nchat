part of 'chat_cubit.dart';

@immutable
abstract class ChatStates {}

class ChatInitial extends ChatStates {}

class SendMessageSuccessState extends ChatStates {}

class SendMessageErrorState extends ChatStates {}

class GetMessagesSuccessState extends ChatStates {}
