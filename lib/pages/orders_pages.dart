import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order_widget.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});
  Future<void> _refreshOrder(BuildContext context) {
    return Provider.of<OrderList>(context, listen: false).loadingOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Meus Pedidos'),
        ),
        drawer: const AppDrawer(),
        body: RefreshIndicator(
          onRefresh: () => _refreshOrder(context),
          child: FutureBuilder(
              future: Provider.of<OrderList>(context, listen: false).loadingOrders(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.error != null) {
                  return const Center(
                    child: Text('Ocorreu um erro!'),
                  );
                } else {
                  return Consumer<OrderList>(
                      builder: (ctx, orders, snapshot) => ListView.builder(
                            itemCount: orders.itemsCount,
                            itemBuilder: (ctx, index) =>
                                OrderWidget(order: orders.items[index]),
                          ));
                }
              }),
        ));
  }
}
