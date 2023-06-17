import 'package:flutter/material.dart';

import '../components/product_grid.dart';


enum FilterOptions {
  Favorite,
  All
}

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Minha Loja')),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorite,
                child: Text('Somente Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Todos'),
              )
            ],
            onSelected: (FilterOptions selectedValue) {
              debugPrint(selectedValue.toString());
            },
          ),
        ],
      ),
      body: const ProductGrid(),
    );
  }
}
