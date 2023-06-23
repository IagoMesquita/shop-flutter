import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';

import '../models/product_list.dart';
import '../components/app_drawer.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Gerenciar Produtos'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder( 
          itemCount: products.itemCout,
          itemBuilder: (ctx, index) => Column(
            children: [
              ProductItem(productItem: products.items[index]),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
