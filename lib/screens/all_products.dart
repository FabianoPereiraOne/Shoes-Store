import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/components/appDrawer.dart';
import 'package:my_store/components/badge_Item.dart';
import 'package:my_store/components/product_grid.dart';
import 'package:my_store/models/cart.dart';
import 'package:my_store/models/order_list.dart';
import 'package:my_store/models/product.dart';
import 'package:my_store/models/product_list.dart';
import 'package:my_store/utils/api.dart';
import 'package:my_store/utils/routes.dart';
import 'package:provider/provider.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
    loadProductsCart();
    loadOrders();
  }

  void loadProductsCart() {
    final cart = Provider.of<Cart>(context, listen: false);
    cart.loadCartItems();
  }

  void loadOrders() {
    final order = Provider.of<OrderList>(context, listen: false);
    order.loadOrders();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void loadProducts() async {
    final productList = Provider.of<ProductList>(context, listen: false);

    if (productList.itemsCount > 0) {
      return setState(() {
        _isLoading = false;
      });
    }

    productList.items.clear();

    try {
      final url = Uri.parse(apiUrl.baseUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final products = data ?? [];

        for (final product in products) {
          productList.addProduct(
            Product(
              id: product['product_id'] ?? "",
              title: product['product_title'] ?? "",
              description:
                  product['product_description'] ??
                  product['product_offer_page_url'] ??
                  "",
              price: product['price'].toDouble(),
              imageUrl:
                  product['product_photo'] ??
                  product['product_photos'][0] ??
                  "",
              rating: product['product_rating'].toDouble(),
              store: product['store_name'] ?? "",
              reviews: product['product_num_reviews'],
            ),
          );
        }
      } else {
        debugPrint("Erro: ${response.statusCode}");
        debugPrint(response.body);
      }
    } catch (error) {
      debugPrint("Erro ao carregar produtos: $error");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os Produtos'),
        centerTitle: true,
        actions: [
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.cart);
              },
              icon: Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) => BadgeItem(
              value: cart.itemsCount.toString(),
              color: Theme.of(context).colorScheme.secondary,
              child: child!,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.only(top: 8),
              child: const ProductGrid(),
            ),
      drawer: AppDrawer(),
    );
  }
}
