import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:possch/src/features/registration/domain/entities/registration.dart';
import 'package:possch/src/features/registration/domain/usecase/create_account_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._createAccount) : super(RegisterInitial());

  // setValue({String? name, ProductType? type, String? email, String? password}) {
  //   if (state is RegisterInitial) {
  //     emit(RegisterSaveTemporary(Registration(
  //       storeName: name,
  //       productType: type,
  //     )));
  //   } else {
  //     emit(RegisterSaveTemporary(
  //         (state as RegisterSaveTemporary).registration.copyWith(
  //               email: email,
  //               password: password,
  //             )));
  //   }
  // }

  final CreateAccountUseCase _createAccount;

  register(Registration data) async {
    final registration = data;
    final result = await _createAccount.call(CreateAccountParam(
        registration.email!,
        registration.password!,
        registration.storeName!,
        registration.productType!));
    result.fold((l) => emit(RegisterCreatedFailed(l.message)),
        (r) => emit(RegisterCreatedSuccess(registration)));

    // emit(RegisterCreated((state as RegisterSaveTemporary)
    //     .registration
    //     .copyWith(email: email, password: password)));
  }
}
