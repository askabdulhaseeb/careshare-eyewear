import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/order.dart';
import '../../models/product.dart';
import '../../providers/order_provider.dart';
import '../../providers/product_provider.dart';
import '../custom_widgets/custom_network_image.dart';

class CartDIaloag extends StatelessWidget {
  const CartDIaloag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Consumer2<OrderProvider, ProductProvider>(
        builder: (BuildContext context, OrderProvider orderPro,
            ProductProvider prodPro, _) {
          final List<Cart> carts = orderPro.order.cartItem;
          return SizedBox(
            width: 300,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_ios_new_outlined),
                      ),
                      const Text(
                        'Cart',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: carts.isEmpty
                      ? const Center(
                          child: Text('No Product in cart yet!!'),
                        )
                      : ListView.builder(
                          itemCount: carts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Cart cart = carts[index];
                            final Product proudct = prodPro.product(cart.pid);
                            return ListTile(
                              leading:
                                  CustomNetworkImage(imageURL: proudct.urls[0]),
                              title: Text(proudct.name),
                              subtitle: Text('Quantity: ${cart.quantity}'),
                              trailing: Column(
                                children: <Widget>[
                                  Text('${cart.quantity} x ${cart.price}'),
                                  Text('= ${cart.quantity * cart.price}'),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
