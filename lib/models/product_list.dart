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
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      title: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    addProduct(newProduct);
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
