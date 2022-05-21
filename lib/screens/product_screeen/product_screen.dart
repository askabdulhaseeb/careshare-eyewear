import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);
  static const String routeName = '/ProductScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              CupertinoSearchTextField(
                itemSize: 44,
                prefixIcon: const Icon(CupertinoIcons.search, size: 24),
                suffixIcon: const Icon(Icons.cancel, size: 24),
                onChanged: (String? value) => print(value),
              ),
              ListTile(
                leading: const Icon(Icons.add),
                minLeadingWidth: 0,
                title: const Text('Add Product'),
                subtitle: const Text('Click here to add new product in stock'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {},
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}