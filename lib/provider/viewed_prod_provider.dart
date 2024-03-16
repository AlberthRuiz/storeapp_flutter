import 'package:flutter/cupertino.dart';
import 'package:storeapp_flutter/models/viewed_model.dart';

class ViewedProdProvider extends ChangeNotifier {
  final Map<String, ViewedProdModel> _viewedProdlistItems = {};

  Map<String, ViewedProdModel> get getViewedProdlistItems {
    return _viewedProdlistItems;
  }

  void addProductToHistory({required String idproducto}) {
    _viewedProdlistItems.putIfAbsent(
        idproducto,
        () => ViewedProdModel(
            id: DateTime.now().toString(), idproducto: idproducto));

    notifyListeners();
  }

  void clearHistory() {
    _viewedProdlistItems.clear();
    notifyListeners();
  }
}
