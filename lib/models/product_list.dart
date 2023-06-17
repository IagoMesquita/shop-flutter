import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import './product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  // [..._items] é um clone de _items. Se passasse _items no get, seria uma referencia, que poderia ser alterada por qlq um
  // List<Product> get items => [..._items];
  List<Product> get items {
    if (_showFavorityOnly) {
      return _items.where((item) => item.isFarovite).toList();
    }

    return [..._items];
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  bool _showFavorityOnly = false;

  void showFavorityOnly() {
    _showFavorityOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavorityOnly = false;
    notifyListeners();
  }
}
