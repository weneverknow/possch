import 'package:possch/src/features/product_type/data/datasource/product_type_datasource.dart';
import 'package:possch/src/features/product_type/domain/entities/product_type.dart';

import '/src/features/product_type/domain/repository/product_type_repository.dart';

class ProductTypeRepositoryImpl implements ProductTypeRepository {
  final ProductTypeDatasource datasource;
  ProductTypeRepositoryImpl(this.datasource);

  @override
  Stream<List<ProductType>> fetchProductType() {
    return datasource
        .fetch()
        .map((event) => event.map((e) => e.toEntities()).toList());
  }
}
