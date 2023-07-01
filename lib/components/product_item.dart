import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product productItem;
  const ProductItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(productItem.imageUrl),
      ),
      title: Text(productItem.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                  arguments: productItem,
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Excluir Produto'),
                    content: const Text('Tem certeza?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Não'),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<ProductList>(context, listen: false)
                              .removeProduct(productItem);
                          Navigator.of(context).pop();
                          // Tbm funciona
                          // Provider.of<ProductList>(context, listen: false).removeProduct(productItem);
                        },
                        child: const Text('Sim'),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}


// OUTRA FORMA DE USAR O SowDialog:

      //  showDialog<bool>(
      //             context: context,
      //             builder: (ctx) => AlertDialog(
      //               title: const Text('Excluir Produto'),
      //               content: const Text('Tem certeza?'),
      //               actions: [
      //                 TextButton(
      //                   onPressed: () => Navigator.of(context).pop(false),
      //                   child: const Text('Não'),
      //                 ),
      //                 TextButton(
      //                   onPressed: () {
                   
      //                     Navigator.of(context).pop(true);
                          
      //                   },
      //                   child: const Text('Sim'),
      //                 )
      //               ],
      //             ),
      //           ).then((value) {
      //             if(value ?? false) {
      //               Provider.of<ProductList>(context, listen: false)
      //                 .removeProduct(productItem);
      //               // Tbm funciona
      //               // Provider.of<ProductList>(context, listen: false).removeProduct(productItem);
      //             }
      //           });