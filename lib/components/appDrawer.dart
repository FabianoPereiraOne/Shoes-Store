import 'package:flutter/material.dart';
import 'package:my_store/utils/routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Bem vindo usuário"),
            leading: Icon(Icons.menu),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.store_outlined),
            title: Text("Loja"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment_outlined),
            title: Text("Pedidos"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.orders);
            },
          ),
        ],
      ),
    );
  }
}
