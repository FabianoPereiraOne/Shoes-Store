import 'package:flutter/material.dart';
import 'package:my_store/components/appDrawer.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meus pedidos"), centerTitle: true),
      drawer: AppDrawer(),
    );
  }
}
