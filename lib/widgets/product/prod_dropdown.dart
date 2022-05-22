import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/prod_category.dart';
import '../../providers/category_provider.dart';

class ProdDropDown extends StatelessWidget {
  const ProdDropDown({this.cid, this.onChanged, Key? key}) : super(key: key);
  final String? cid;
  final void Function(ProdCategory?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final CategoryProvider catPro = Provider.of<CategoryProvider>(context);
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButton<ProdCategory>(
        isExpanded: true,
        underline: const SizedBox(),
        value: catPro.category(cid),
        hint: const Text('Category'),
        items: catPro.categories
            .map((ProdCategory eCat) => DropdownMenuItem<ProdCategory>(
                  value: eCat,
                  child: Text(eCat.title),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
