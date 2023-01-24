import '/src/features/product_type/domain/entities/product_type.dart';

class ProductTypeModel extends ProductType {
  const ProductTypeModel({
    String? code,
    String? name,
  }) : super(
          code: code,
          name: name,
        );

  factory ProductTypeModel.fromJson(Map<String, dynamic> json) =>
      ProductTypeModel(code: json['code'], name: json['value']);

  ProductType toEntities() => ProductType(
        code: code,
        name: name,
      );
}
