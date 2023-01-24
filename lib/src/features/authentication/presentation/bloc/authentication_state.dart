part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationInitial extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  final Authentication authentication;
  AuthenticationSuccess(this.authentication);
  @override
  // TODO: implement props
  List<Object?> get props => [authentication];
}

class AuthenticationFailed extends AuthenticationState {
  final String message;
  AuthenticationFailed(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
