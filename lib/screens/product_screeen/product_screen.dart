import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../../widgets/custom_widgets/responsive_layout.dart';
import '../../widgets/product/product_gridview.dart';
import 'product_screen_desktop_screen.dart';
import 'product_screen_mobile_view.dart';
import 'product_screen_table_view.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);
  static const String routeName = '/ProductScreen';

  @override
  Widget build(BuildContext context) {
    final ProductProvider prodPro = Provider.of<ProductProvider>(context);
    prodPro.init();
    return const Scaffold(
      body: ResponsiveLayout(
        mobile: ProductScreenMobileView(),
        tablet: ProductScreenTableView(),
        desktop: ProductScreenDesktopView(),
      ),
    );
  }
}
