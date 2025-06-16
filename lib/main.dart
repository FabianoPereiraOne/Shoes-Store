import 'package:flutter/material.dart';
import 'package:my_store/models/cart.dart';
import 'package:my_store/models/order_list.dart';
import 'package:my_store/models/product_list.dart';
import 'package:my_store/screens/all_products.dart';
import 'package:my_store/screens/cart.dart';
import 'package:my_store/screens/orders.dart';
import 'package:my_store/screens/product_detail.dart';
import 'package:my_store/utils/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyStore());
}

class MyStore extends StatelessWidget {
  const MyStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductList()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => OrderList()),
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: const Color.fromARGB(255, 4, 108, 200),
            onPrimary: const Color.fromARGB(255, 4, 108, 200),
            secondary: const Color(0xFFF2B33D),
            onSecondary: const Color(0xFFF2B33D),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromARGB(255, 4, 108, 200),
            foregroundColor: Colors.white,
          ),
          useMaterial3: true,
          fontFamily: "Lato",
        ),
        home: AllProducts(),
        routes: {
          AppRoutes.productDetail: (ctx) => ProductDetail(),
          AppRoutes.cart: (ctx) => CartScreen(),
          AppRoutes.orders: (ctx) => Orders(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
