import 'package:flutter/material.dart';

import '../components/badge_widget.dart';
import '../components/product_grid.dart';

enum FilterOptions { Favorite, All }

bool _showFavorityOnly = false;

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
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
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  _showFavorityOnly = true;
                } else {
                  _showFavorityOnly = false;
                }
              });
            },
          ),
          BadgeWidget(
            value: '2',
            child: IconButton(
              onPressed: () {},
              icon:const Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: ProductGrid(
        isShowOnlyFavorite: _showFavorityOnly,
      ),
    );
  }
}
