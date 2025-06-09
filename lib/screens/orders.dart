import 'package:flutter/material.dart';
import 'package:my_store/components/appDrawer.dart';
import 'package:my_store/components/order.dart';
import 'package:my_store/models/order_list.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orderList = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("Meus pedidos"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: orderList.totalOrders,
          itemBuilder: (ctx, index) {
            return OrderWidget(orderList.orders[index]);
          },
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
