part of 'navigation_bloc.dart';


// Events
abstract class NavigationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TabChanged extends NavigationEvent {
  final int index;
  TabChanged(this.index);

  @override
  List<Object?> get props => [index];
}

class AuthenticationStatusChanged extends NavigationEvent {
  final bool isAuthenticated;
  AuthenticationStatusChanged(this.isAuthenticated);

  @override
  List<Object?> get props => [isAuthenticated];
}

class LocationChanged extends NavigationEvent {
  final String location;
  LocationChanged(this.location);

  @override
  List<Object?> get props => [location];
}

class ProfileSetupCompleted extends NavigationEvent {
  @override
  List<Object?> get props => [];
}


class ProfileSetupSkipped extends NavigationEvent {}