import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possch/src/features/product_type/domain/entities/product_type.dart';
import 'package:possch/src/features/registration/domain/entities/registration.dart';

class RegistrationDataCubit extends Cubit<Registration?> {
  RegistrationDataCubit() : super(null);

  initStore({String? name, ProductType? type}) => emit(Registration(
        storeName: name,
        productType: type,
      ));

  initAccount({String? email, String? password}) => emit(state?.copyWith(
        email: email,
        password: password,
      ));
}
