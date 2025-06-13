import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_store/data/database.dart';
import 'package:my_store/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final newProduct = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      updateProduct(newProduct);
    } else {
      addProduct(newProduct);
    }
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  int get itemsCount {
    return items.length;
  }

  void removeProduct(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
