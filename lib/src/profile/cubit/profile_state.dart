part of 'profile_cubit.dart';

@immutable
abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class ProfileGetUserLoadingState extends ProfileStates {}

class ProfileGetUserSuccessState extends ProfileStates {}

class ProfileGetUserErrorState extends ProfileStates {
  final String error;

  ProfileGetUserErrorState(this.error);
}

class ProfileChangeBottomNavState extends ProfileStates {}

class ProfileImagePickedSuccessState extends ProfileStates {}

class ProfileImagePickedErrorState extends ProfileStates {}

class ProfileImageUploadedSccessState extends ProfileStates {}

class ProfileImageUploadedErrorState extends ProfileStates {}