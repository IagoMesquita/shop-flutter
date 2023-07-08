import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order_widget.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrderList>(context, listen: false)
        .loadingOrders()
        .then((value) {
      setState(() => isLoading = false);
    });
  }

    Future<void> _refreshOrder(BuildContext context) {
    return Provider.of<OrderList>(context, listen: false).loadingOrders();
  }


  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderList>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Meus Pedidos'),
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshOrder(context),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (ctx, index) =>
                    OrderWidget(order: orders.items[index])),
      ),
    );
  }
}
