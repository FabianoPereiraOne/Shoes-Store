import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_store/models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  const OrderWidget(this.order, {super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "R\$ ${widget.order.total.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              DateFormat("dd/MM/yyyy hh:mm").format(widget.order.date),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ),
          ),

          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: (widget.order.products.length * 24) + 36,
              child: ListView(
                children: widget.order.products.map((product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${product.quantity}x R\$ ${product.price}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
