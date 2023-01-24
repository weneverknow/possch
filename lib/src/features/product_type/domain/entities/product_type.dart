import 'package:equatable/equatable.dart';

class ProductType extends Equatable {
  final String? code;
  final String? name;
  const ProductType({
    this.code,
    this.name,
  });

  Map<String, dynamic> toJson() => {
        "code": code,
        "value": name,
      };

  @override
  List<Object?> get props => [
        code,
        name,
      ];
}
