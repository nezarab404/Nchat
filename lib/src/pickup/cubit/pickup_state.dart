part of 'pickup_cubit.dart';

@immutable
abstract class PickupStates {}

class PickupInitial extends PickupStates {}

class PickupEndCallLoadingState extends PickupStates {}

class PickupEndCallSuccessState extends PickupStates {}

class PickupEndCallErrorState extends PickupStates {
  final String error;

  PickupEndCallErrorState(this.error);
}
