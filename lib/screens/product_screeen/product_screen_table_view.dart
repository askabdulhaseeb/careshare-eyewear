import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../../widgets/app_name.dart';
import '../../widgets/product/product_gridview.dart';

class ProductScreenTableView extends StatelessWidget {
  const ProductScreenTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<ProductProvider>(
            builder: (BuildContext context, ProductProvider prodPro, _) {
              return Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const AppName(fontSize: 20),
                      const Spacer(),
                      SizedBox(
                        width: 320,
                        child: CupertinoSearchTextField(
                          itemSize: 44,
                          prefixIcon:
                              const Icon(CupertinoIcons.search, size: 24),
                          suffixIcon: const Icon(Icons.cancel, size: 24),
                          onChanged: (String? value) => print(value),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        splashRadius: 16,
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ProductGridView(
                      posts: prodPro.products,
                      crossAxisCount: 3,
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
