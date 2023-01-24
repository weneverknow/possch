import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPageCubit extends Cubit<int> {
  RegistrationPageCubit() : super(0);

  move(int page) {
    emit(page);
  }
}
