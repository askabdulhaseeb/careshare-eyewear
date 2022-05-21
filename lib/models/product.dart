import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product({
    required this.pid,
    required this.name,
    this.description = '',
    this.quantity = 0,
    this.price = 0,
    this.addedBy = '',
    this.timestamp = 0,
  });

  final String pid;
  String name;
  String description;
  int quantity;
  double price;
  String addedBy;
  int timestamp;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'name': name,
      'description': description,
      'quantity': quantity,
      'price': price,
      'addedBy': addedBy,
      'timestamp': timestamp,
    };
  }

  // ignore: sort_constructors_first
  factory Product.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Product(
      pid: doc.data()?['pid'] ?? '',
      name: doc.data()?['name'] ?? '',
      description: doc.data()?['description'] ?? '',
      quantity: int.parse(doc.data()?['quantity']?.toString() ?? '0'),
      price: double.parse(doc.data()?['price']?.toString() ?? '0.0'),
      addedBy: doc.data()?['addedBy'] ?? '',
      timestamp: int.parse(doc.data()?['timestamp']?.toString() ?? '0'),
    );
  }
}
