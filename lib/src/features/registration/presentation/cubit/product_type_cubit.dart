import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possch/src/features/product_type/domain/entities/product_type.dart';

class ProductTypeCubit extends Cubit<ProductType?> {
  ProductTypeCubit() : super(null);

  init(ProductType type) {
    emit(type);
  }

  update(ProductType body) {
    emit(body);
  }
}
