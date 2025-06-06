import 'package:flutter/material.dart';
import 'package:my_store/components/product_item.dart';
import 'package:my_store/models/product.dart';
import 'package:my_store/models/product_list.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  const ProductGrid(this.showFavoriteOnly, {super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> listProducts = showFavoriteOnly
        ? provider.favoriteItems
        : provider.items;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: listProducts.length,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: listProducts[index],
          child: ProductItem(),
        );
      },
    );
  }
}
