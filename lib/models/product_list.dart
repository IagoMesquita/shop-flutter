import 'dart:math';

import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import './product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  // [..._items] é um clone de _items. Se passasse _items no get, seria uma referencia, que poderia ser alterada por qlq um
  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((item) => item.isFarovite).toList();

  int get itemCout {
    return _items.length;
  }

   void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null; 

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      price: data['price'] as double,
      description: data['description'] as String,
      imageUrl: data['urlImage'] as String,
    );

    if(hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }

  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
   int index = _items.indexWhere((p) => p.id == product.id);
      print('Index: $index');
    if(index >= 0) {
      _items[index] = product;
    }

    notifyListeners();

  }

  void removeProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }
}
