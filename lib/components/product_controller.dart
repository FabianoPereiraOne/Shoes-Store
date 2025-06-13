import 'package:flutter/material.dart';
import 'package:my_store/models/product.dart';
import 'package:my_store/models/product_list.dart';
import 'package:my_store/utils/routes.dart';
import 'package:provider/provider.dart';

class ProductController extends StatelessWidget {
  final Product product;
  const ProductController(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed(AppRoutes.productsForm, arguments: product);
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                Provider.of<ProductList>(
                  context,
                  listen: false,
                ).removeProduct(product);
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
