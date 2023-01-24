import 'package:possch/src/core/firestore/firestore_service.dart';
import 'package:possch/src/features/product_type/data/model/product_type_model.dart';

abstract class ProductTypeDatasource {
  Stream<List<ProductTypeModel>> fetch();
}

class ProductTypeDatasourceImpl implements ProductTypeDatasource {
  final FirestoreService firestoreService;
  ProductTypeDatasourceImpl(this.firestoreService);

  @override
  Stream<List<ProductTypeModel>> fetch() {
    return firestoreService.collectionStream(
        path: "type",
        builder: (data, docId) {
          print("[ProductTypeDatasource] fetch product type $data");
          return ProductTypeModel.fromJson(data);
        });
  }
}
