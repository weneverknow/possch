import 'package:possch/src/features/product_type/domain/entities/product_type.dart';

abstract class ProductTypeRepository {
  Stream<List<ProductType>> fetchProductType();
}
