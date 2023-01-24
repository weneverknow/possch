part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {}

class AuthenticationLoginWithEmail extends AuthenticationEvent {
  final String email;
  final String password;
  AuthenticationLoginWithEmail(this.email, this.password);
  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class AuthenticationLoginFromStorage extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthenticationLogout extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
