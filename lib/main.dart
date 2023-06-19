import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/products_overview_pages.dart';
import 'package:shop/utils/app_routes.dart';

import 'models/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App de compras',
        theme: ThemeData(
            // primarySwatch: Colors.purple,
            // accentColor: Colors.deepOrange,
            colorScheme:
                ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(
              secondary: Colors.deepOrange,
            ),
            fontFamily: 'Lato'),
        home: const ProductsOverviewPage(),
        routes: {
          AppRoutes.PRODUCT_DETAIL:(context) => const ProductDetailPage(),
        },
      ),
    );
  }
}
