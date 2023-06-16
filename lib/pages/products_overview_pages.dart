import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';
// import 'package:shop/data/dummy_data.dart';
// import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductsOverviewPage extends StatelessWidget {
  // final List<Product> loadedProducts = dummyProducts;

  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final loadedProducts = provider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Minha Loja')),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
        ),
        itemBuilder: (ctx, index) => ProductItem(product: loadedProducts[index]),
        itemCount: loadedProducts.length,
      ),
    );
  }
}
