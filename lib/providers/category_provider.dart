import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = <Category>[];

  init() {
    if (_categories.isNotEmpty) return;
    _load();
  }

  _load() {
    _categories = <Category>[
      Category(cid: 'glasses', title: 'Glasses'),
      Category(cid: 'lens', title: 'Lens'),
      Category(cid: 'watches', title: 'Watches'),
    ];
  }
}
