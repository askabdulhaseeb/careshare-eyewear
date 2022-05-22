import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../functions/time_date_functions.dart';
import '../models/product.dart';
import '../widgets/custom_widgets/custom_toast.dart';
import 'auth_methods.dart';

class ProductAPI {
  static const String _collection = 'products';
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<void> addProduct(Product product) async {
    try {
      await _instance
          .collection(_collection)
          .doc(product.pid)
          .set(product.toMap());
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
  }

  Future<String?> uploadImage({required String pid, required File file}) async {
    try {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref(
              'products/${AuthMethods.uid}/$pid/${TimeDateFunctions.timestamp}')
          .putFile(file);
      String url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }
}
