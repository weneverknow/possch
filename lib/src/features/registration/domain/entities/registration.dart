import 'package:equatable/equatable.dart';
import 'package:possch/src/features/product_type/domain/entities/product_type.dart';

class Registration extends Equatable {
  final String? storeName;
  final ProductType? productType;
  final String? email;
  final String? password;
  const Registration({
    this.storeName,
    this.productType,
    this.email,
    this.password,
  });

  Registration copyWith({String? email, String? password}) => Registration(
        storeName: storeName,
        productType: productType,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<Object?> get props => [
        storeName,
        productType,
        email,
        password,
      ];
}
