import 'package:flutter/material.dart';

import '../database/product_api.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = <Product>[];

  init() async {
    if (_products.isNotEmpty) return;
    await _load();
  }

  Future<void> refesh() async {
    await _load();
  }

  List<Product> get products => <Product>[..._products];

  Product product(String pid) {
    final int index = _products.indexWhere((element) => element.pid == pid);
    return index < 0 ? _null : _products[index];
  }

  Future<void> _load() async {
    _products = await ProductAPI().getProducts();
    print('Print: product_provider length -> ${_products.length}');
    notifyListeners();
  }

  Product get _null => Product(
        pid: '0',
        name: '-null-',
        phoneNumber: '-null-',
        address: '-null-',
        urls: <String>[],
      );
}
