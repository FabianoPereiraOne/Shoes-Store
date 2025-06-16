import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_store/models/cart_item.dart';
import 'package:my_store/models/databaseHelper.dart';
import 'package:my_store/models/product.dart';
import 'package:sqflite/sqflite.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  void removeItem(String productId) async {
    final db = await DatabaseHelper().database;

    _items.remove(productId);

    await db.delete(
      'cart_items',
      where: 'productId = ?',
      whereArgs: [productId],
    );

    notifyListeners();
  }

  void removeSingleItem(String productId) async {
    final db = await DatabaseHelper().database;

    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity == 1) {
      _items.remove(productId);

      await db.delete(
        'cart_items',
        where: 'productId = ?',
        whereArgs: [productId],
      );
    } else {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: productId,
          title: existingItem.title,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        ),
      );

      final updatedItem = _items[productId]!;

      await db.update(
        'cart_items',
        {
          'id': updatedItem.id,
          'productId': updatedItem.productId,
          'title': updatedItem.title,
          'quantity': updatedItem.quantity,
          'price': updatedItem.price,
        },
        where: 'productId = ?',
        whereArgs: [productId],
      );
    }

    notifyListeners();
  }

  void clear() async {
    final db = await DatabaseHelper().database;
    _items = {};
    await db.delete('cart_items');
    notifyListeners();
  }

  Future<void> loadCartItems() async {
    final db = await DatabaseHelper().database;

    final List<Map<String, dynamic>> maps = await db.query('cart_items');

    final Map<String, CartItem> loadedItems = {};

    for (var itemMap in maps) {
      final cartItem = CartItem(
        id: itemMap['id'],
        productId: itemMap['productId'],
        title: itemMap['title'],
        quantity: itemMap['quantity'],
        price: itemMap['price'],
      );

      loadedItems[cartItem.productId] = cartItem;
    }

    _items = loadedItems;
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) async {
    final db = await DatabaseHelper().database;

    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: product.id,
          title: existingItem.title,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        ),
      );

      final productSelected = _items[product.id];

      await db.update(
        "cart_items",
        {
          "id": productSelected!.id,
          "productId": product.id,
          "title": productSelected.title,
          "quantity": productSelected.quantity + 1,
          "price": productSelected.price,
        },
        where: "productId = ?",
        whereArgs: [product.id],
      );
    } else {
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: id,
          productId: product.id,
          title: product.title,
          quantity: 1,
          price: product.price,
        ),
      );

      await db.insert('cart_items', {
        'id': id,
        'title': product.title,
        'quantity': 1,
        'price': product.price,
        'productId': product.id,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }

    notifyListeners();
  }
}
