import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/auth_page.dart';

import '../models/order_list.dart';
import '../models/product_list.dart';

import '../utils/app_routes.dart';

import '../pages/orders_pages.dart';
import '../pages/product_form_page.dart';
import '../pages/products_pages.dart';
import '../pages/products_overview_pages.dart';
import '../pages/product_detail_page.dart';
import '../pages/cart_page.dart';

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
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList()),
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
        routes: {
          AppRoutes.AUTH:(context) => const AuthPage(),
          AppRoutes.HOME:(context) => const ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL:(context) => const ProductDetailPage(),
          AppRoutes.CART:(context) => const CartPage(),
          AppRoutes.ORDERS:(context) => const OrdersPage(),
          AppRoutes.PRODUCTS:(context) => const ProductsPage(),
          AppRoutes.PRODUCT_FORM:(context) => const ProductFormPage(),
        },
      ),
    );
  }
}
