import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:possch/src/core/usecase/usecase.dart';
import 'package:possch/src/features/authentication/domain/entities/authentication.dart';
import 'package:possch/src/features/authentication/domain/usecase/login_from_storage_usecase.dart';
import 'package:possch/src/features/authentication/domain/usecase/login_with_email_usecase.dart';
import 'package:possch/src/features/authentication/domain/usecase/logout_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
    this._loginWithEmailUseCase,
    this._loginFromStorageUseCase,
    this._logoutUseCase,
  ) : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AuthenticationLoginWithEmail>(_login);
    on<AuthenticationLoginFromStorage>(_loginFromStorage);
    on<AuthenticationLogout>(_logout);
  }

  final LoginWithEmailUseCase _loginWithEmailUseCase;
  final LoginFromStorageUseCase _loginFromStorageUseCase;
  final LogoutUseCase _logoutUseCase;

  Future<void> _logout(
      AuthenticationLogout event, Emitter<AuthenticationState> emit) async {
    await _logoutUseCase.logout();
    emit(AuthenticationInitial());
  }

  Future<void> _loginFromStorage(AuthenticationLoginFromStorage event,
      Emitter<AuthenticationState> emit) async {
    final result = await _loginFromStorageUseCase.call(NoParam());
    result.fold((l) => emit(AuthenticationInitial()),
        (r) => emit(AuthenticationSuccess(r!)));
  }

  Future<void> _login(AuthenticationLoginWithEmail event,
      Emitter<AuthenticationState> emit) async {
    final result = await _loginWithEmailUseCase
        .call(LoginParam(event.email, event.password));
    result.fold((l) => emit(AuthenticationFailed(l.message)),
        (r) => emit(AuthenticationSuccess(r!)));
  }
}
