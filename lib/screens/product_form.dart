import 'package:flutter/material.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Produto'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
              ),
              TextFormField(
                focusNode: _priceFocus,
                decoration: InputDecoration(labelText: "Preço"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                focusNode: _descriptionFocus,
                decoration: InputDecoration(labelText: "Descrição"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
