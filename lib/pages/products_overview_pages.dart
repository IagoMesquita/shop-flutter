import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/app_drawer.dart';
import '../components/badge_widget.dart';
import '../components/product_grid.dart';

import '../models/cart.dart';
import '../utils/app_routes.dart';

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
          Consumer<Cart>(
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.CART);
                },
                icon:const Icon(Icons.shopping_cart),
              ),
            builder: (ctx, cart, child ) => BadgeWidget(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          )
        ],
       
      ),
      body: ProductGrid(
        isShowOnlyFavorite: _showFavorityOnly,
      ),
      drawer: const AppDrawer(),
    );
  }
}
