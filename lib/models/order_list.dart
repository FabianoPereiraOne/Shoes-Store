import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_store/models/cart.dart';
import 'package:my_store/models/cart_item.dart';
import 'package:my_store/models/databaseHelper.dart';
import 'package:my_store/models/order.dart';
import 'package:sqflite/sqflite.dart';

class OrderList with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  int get totalOrders {
    return _orders.length;
  }

  Future<void> loadOrders() async {
    final db = await DatabaseHelper().database;

    final orderMaps = await db.query('orders', orderBy: 'date DESC');

    List<Order> loadedOrders = [];

    for (var orderMap in orderMaps) {
      final orderId = orderMap['id'] as String;

      final orderItemsMaps = await db.query(
        'order_items',
        where: 'orderId = ?',
        whereArgs: [orderId],
      );

      List<CartItem> orderItems = orderItemsMaps.map((itemMap) {
        return CartItem(
          id: itemMap['id'] as String,
          productId: itemMap['productId'] as String,
          title: itemMap['title'] as String,
          quantity: itemMap['quantity'] as int,
          price: (itemMap['price'] as num).toDouble(),
        );
      }).toList();

      loadedOrders.add(
        Order(
          id: orderId,
          total: (orderMap['total'] as num).toDouble(),
          date: DateTime.parse(orderMap['date'] as String),
          products: orderItems,
        ),
      );
    }

    _orders = loadedOrders;
    notifyListeners();
  }

  void addOrder(Cart cart) async {
    final db = await DatabaseHelper().database;
    final orderId = Random().nextDouble().toString();
    final productSelected = cart.items.values.toList();

    _orders.insert(
      0,
      Order(
        id: orderId,
        total: cart.totalAmount,
        date: DateTime.now(),
        products: productSelected,
      ),
    );

    await db.insert('orders', {
      "id": orderId,
      "total": cart.totalAmount,
      "date": DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    for (var product in productSelected) {
      await db.insert('order_items', {
        "id": Random().nextDouble().toString(),
        "orderId": orderId,
        "title": product.title,
        "quantity": product.quantity,
        "price": product.price,
        "productId": product.productId,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }

    notifyListeners();
  }
}
