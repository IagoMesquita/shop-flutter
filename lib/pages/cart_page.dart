import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 10,),
                  Chip(
                    label: Text('R\$${cart.totalAmount}'),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    labelStyle: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.titleLarge?.color),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text('COMPRAR'),
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20)
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
