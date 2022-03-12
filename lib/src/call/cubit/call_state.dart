part of 'call_cubit.dart';

@immutable
abstract class CallStates {}

class CallInitial extends CallStates {}

class CallEndCallLoadingState extends CallStates {}

class CallEndCallSuccessState extends CallStates {}

class CallEndCallErrorState extends CallStates {
  final String error;

  CallEndCallErrorState(this.error);
}
