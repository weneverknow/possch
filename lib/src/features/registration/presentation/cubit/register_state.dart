part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  // const RegisterState();

  // @override
  // List<Object> get props => [];
}

class RegisterInitial extends RegisterState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegisterSaveTemporary extends RegisterState {
  final Registration registration;
  RegisterSaveTemporary(this.registration);
  @override
  // TODO: implement props
  List<Object?> get props => [registration];
}

class RegisterCreatedSuccess extends RegisterState {
  final Registration registration;
  RegisterCreatedSuccess(this.registration);
  @override
  // TODO: implement props
  List<Object?> get props => [registration];
}

class RegisterCreatedFailed extends RegisterState {
  final String message;
  RegisterCreatedFailed(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
