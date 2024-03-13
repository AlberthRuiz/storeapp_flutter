import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:storeapp_flutter/models/products_model.dart';

class ProductsProvider extends ChangeNotifier {
  static List<ProductModel> _productsList = [];
  ProductModel? _product;
  List<ProductModel> get getProducts {
    return _productsList;
  }

  ProductModel? get getProduct {
    return _product;
  }

  List<ProductModel> get getOnSaleProducts {
    return _productsList.where((element) => element.isOnSale).toList();
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('productos')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _productsList = [];
      // _productsList.clear();
      for (var element in productSnapshot.docs) {
        _productsList.insert(
            0,
            ProductModel(
              id: element.get('id'),
              title: element.get('nombre'),
              imageUrl: element.get('imageUrl'),
              productCategoryName: element.get('categoria'),
              price: double.parse(
                element.get('precio'),
              ),
              salePrice: element.get('precioVenta'),
              isOnSale: element.get('esOferta'),
              isUnd: element.get('isUnidad'),
            ));
      }
    });
    notifyListeners();
  }

  ProductModel findProdById(String productId) {
    return _productsList.firstWhere((element) => element.id == productId);
  }

  List<ProductModel> findByCategory(String categoryName) {
    List<ProductModel> categoryList = _productsList
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return categoryList;
  }

  List<ProductModel> searchQuery(String searchText) {
    List<ProductModel> searchList = _productsList
        .where(
          (element) => element.title.toLowerCase().contains(
                searchText.toLowerCase(),
              ),
        )
        .toList();
    return searchList;
  }
}
