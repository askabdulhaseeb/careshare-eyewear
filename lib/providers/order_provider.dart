import 'package:flutter/material.dart';

import '../enums/delivery_status.dart';
import '../models/order.dart';
import '../models/product.dart';

class OrderProvider extends ChangeNotifier {
  Order _order = Order(
    uid: 'uid',
    name: '',
    status: DeliveryStatusEnum.pending,
    cartItem: [],
    rating: '0',
    timestamp: 0,
  );

  Order get order => _order;

  void addInCart(Product product, int qty) {
    for (Cart element in _order.cartItem) {
      if (element.pid == product.pid) {
        element.quantity += qty;
        return;
      }
    }
    final Cart temp =
        Cart(pid: product.pid, quantity: qty, price: product.price);
    _order.cartItem.add(temp);
    notifyListeners();
  }
}
