import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/order_provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/app_name.dart';
import '../../widgets/product/cart_dialoag.dart';
import '../../widgets/product/product_gridview.dart';

class ProductScreenDesktopView extends StatelessWidget {
  const ProductScreenDesktopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Consumer<ProductProvider>(
            builder: (BuildContext context, ProductProvider prodPro, _) {
              return Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      const AppName(),
                      const Spacer(),
                      SizedBox(
                        width: 400,
                        child: CupertinoSearchTextField(
                          itemSize: 44,
                          prefixIcon:
                              const Icon(CupertinoIcons.search, size: 24),
                          suffixIcon: const Icon(Icons.cancel, size: 24),
                          onChanged: (String? value) => print(value),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const CartDIaloag(),
                          );
                        },
                        splashRadius: 16,
                        icon: Consumer<OrderProvider>(
                          builder: (BuildContext context,
                              OrderProvider orderPro, _) {
                            return CircleAvatar(
                                radius: 20,
                                child: Center(
                                  child: Text(
                                    orderPro.order.cartItem.length.toString(),
                                  ),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ProductGridView(
                      posts: prodPro.products,
                      crossAxisCount: 4,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
