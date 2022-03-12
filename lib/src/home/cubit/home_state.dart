abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeGetUserLoadingState extends HomeStates {}

class HomeGetUserSuccessState extends HomeStates {}

class HomeGetUserErrorState extends HomeStates {
  final String error;

  HomeGetUserErrorState(this.error);
}

class HomeChangeBottomNavState extends HomeStates {}

class HomeGetAllUsersLoadingState extends HomeStates {}

class HomeGetAllUsersSuccessState extends HomeStates {}

class HomeGetAllUsersErrorState extends HomeStates {
  final String error;

  HomeGetAllUsersErrorState(this.error);
}

class HomeGetMyChatsLoadingState extends HomeStates {}

class HomeGetMyChatsSuccessState extends HomeStates {}

class HomeGetMyChatsErrorState extends HomeStates {
  final String error;

  HomeGetMyChatsErrorState(this.error);
}
