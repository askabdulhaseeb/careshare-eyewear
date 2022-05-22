import '../enums/delivery_status.dart';

class Order {
  Order({
    required this.uid,
    required this.name,
    required this.status,
    required this.cartItem,
    required this.rating,
    required this.timestamp,
  });

  final String uid;
  final String name;
  final DeliveryStatusEnum status;
  final List<Cart> cartItem;
  final String rating;
  final int timestamp;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'status': DeliveryStatusConvertor.getJson(status),
      'cartItem': cartItem.map((Cart x) => x.toMap()).toList(),
      'rating': rating,
      'timestamp': timestamp,
    };
  }

  // ignore: sort_constructors_first
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      status: DeliveryStatusConvertor.getEnum(map['status']),
      cartItem: List<Cart>.from(map['cartItem']?.map((dynamic x) => Cart.fromMap(x))),
      rating: map['rating'] ?? '',
      timestamp: int.parse(map['timestamp']?.toString() ?? '0'),
    );
  }
}

class Cart {
  Cart({
    required this.pid,
    required this.quantity,
    required this.price,
  });

  final String pid;
  final int quantity;
  final double price;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'quantity': quantity,
      'price': price,
    };
  }

  // ignore: sort_constructors_first
  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      pid: map['pid'] ?? '',
      quantity: int.parse(map['quantity']?.toString() ?? '0'),
      price: double.parse(map['price']?.toString() ?? '0.0'),
    );
  }
}
