import 'package:flutter/material.dart';
import 'package:my_store/models/cart.dart';
import 'package:my_store/models/cart_item.dart';
import 'package:provider/provider.dart';

class CartLine extends StatelessWidget {
  final CartItem cartItem;
  const CartLine(this.cartItem, {super.key});

  @override
  Widget build(BuildContext context) {
    final String total = (cartItem.price * cartItem.quantity).toStringAsFixed(
      2,
    );
    final String price = cartItem.price.toStringAsFixed(2);
    final Cart cart = Provider.of(context);

    return Dismissible(
      key: ValueKey(cartItem.productId),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        color: Theme.of(context).colorScheme.error,
        child: Icon(Icons.delete, color: Colors.white, size: 40),
      ),
      onDismissed: (_) {
        cart.removeItem(cartItem.productId);
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              child: Text(
                price,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        title: Text(cartItem.title),
        subtitle: Text("Total: R\$ $total"),
        trailing: Text("${cartItem.quantity}x"),
      ),
    );
  }
}
