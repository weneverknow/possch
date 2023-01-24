import 'package:possch/src/features/product_type/domain/entities/product_type.dart';
import 'package:possch/src/features/product_type/domain/repository/product_type_repository.dart';

class FetchProductTypeUseCase {
  final ProductTypeRepository repository;
  FetchProductTypeUseCase(this.repository);

  Stream<List<ProductType>> fetch() {
    return repository.fetchProductType();
  }
}
