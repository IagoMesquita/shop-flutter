import 'package:flutter/material.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/products_overview_pages.dart';
import 'package:shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          // primarySwatch: Colors.purple,
          // accentColor: Colors.deepOrange,
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(
            secondary: Colors.deepOrange,
          ),
          fontFamily: 'Lato'),
      home: ProductsOverviewPage(),
      routes: {
        AppRoutes.PRODUCT_DETAIL:(context) => const ProductDetailPage(),
      },
    );
  }
}
