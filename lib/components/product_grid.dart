import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/product_item.dart';
import '../models/product_list.dart';

class ProductGrid extends StatelessWidget {
  final bool isShowOnlyFavorite;

  const ProductGrid({super.key, required this.isShowOnlyFavorite});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final loadedProducts =
        isShowOnlyFavorite ? provider.favoriteItems : provider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        key: ValueKey(loadedProducts[index].id),
        value: loadedProducts[index],
        child: const ProductItem(),
      ),
      itemCount: loadedProducts.length,
    );
  }
}
