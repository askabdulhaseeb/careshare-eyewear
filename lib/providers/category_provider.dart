import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/prod_category.dart';

class CategoryProvider extends ChangeNotifier {
  List<ProdCategory> _categories = <ProdCategory>[];

  List<ProdCategory> get categories => <ProdCategory>[..._categories];

  init() {
    if (_categories.isNotEmpty) return;
    _load();
  }

  ProdCategory? category(String? cid) {
    final int index =
        _categories.indexWhere((ProdCategory element) => element.cid == cid);
    return (index < 0) ? null : _categories[index];
  }

  _load() {
    _categories = <ProdCategory>[
      ProdCategory(cid: 'glasses', title: 'Glasses'),
      ProdCategory(cid: 'lens', title: 'Lens'),
      ProdCategory(cid: 'watches', title: 'Watches'),
    ];
  }

  ProdCategory get _null => ProdCategory(cid: 'null', title: 'null');
}
