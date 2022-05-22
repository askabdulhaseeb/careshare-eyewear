import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../database/auth_methods.dart';
import '../../database/product_api.dart';
import '../../functions/image_functions.dart';
import '../../functions/time_date_functions.dart';
import '../../models/prod_category.dart';
import '../../models/product.dart';
import '../../providers/product_provider.dart';
import '../../services/custom_services.dart';
import '../../utilities/custom_validators.dart';
import '../../widgets/custom_widgets/custom_elevated_button.dart';
import '../../widgets/custom_widgets/custom_slideable_urls_tile.dart';
import '../../widgets/custom_widgets/custom_textformfield.dart';
import '../../widgets/custom_widgets/custom_toast.dart';
import '../../widgets/custom_widgets/show_loading.dart';
import '../../widgets/product/get_product_images.dart';
import '../../widgets/product/prod_dropdown.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({required this.product, Key? key}) : super(key: key);
  final Product product;
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late TextEditingController _name;
  late TextEditingController _description;
  late TextEditingController _qty;
  late TextEditingController _price;

  bool _isLoading = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final List<XFile?> _files = <XFile?>[
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
  ];

  @override
  void initState() {
    _name = TextEditingController(text: widget.product.name);
    _description = TextEditingController(text: widget.product.description);
    _qty = TextEditingController(text: widget.product.quantity.toString());
    _price = TextEditingController(text: widget.product.price.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                widget.product.urls.isNotEmpty
                    ? CustomSlidableURLsTile(urls: widget.product.urls)
                    : GetProductImages(
                        file: _files,
                        onTap: () => _fetchMedia(),
                      ),
                _title('Product Name'),
                CustomTextFormField(
                  controller: _name,
                  hint: 'Product Name',
                  validator: (String? value) =>
                      CustomValidator.lessThen2(value),
                  readOnly: _isLoading,
                ),
                _title('Product Description'),
                CustomTextFormField(
                  controller: _description,
                  hint: 'Product Description',
                  validator: (String? value) => CustomValidator.isEmpty(value),
                  readOnly: _isLoading,
                ),
                _title('Product Quantity'),
                CustomTextFormField(
                  controller: _qty,
                  hint: 'Product Quantity',
                  validator: (String? value) => CustomValidator.isEmpty(value),
                  keyboardType: TextInputType.number,
                  readOnly: _isLoading,
                ),
                _title('Product Price'),
                CustomTextFormField(
                  controller: _price,
                  hint: 'Product Price',
                  validator: (String? value) => CustomValidator.isEmpty(value),
                  keyboardType: TextInputType.number,
                  readOnly: _isLoading,
                ),
                _title('Product Category'),
                ProdDropDown(
                    cid: widget.product.category,
                    onChanged: (ProdCategory? value) {
                      setState(() {
                        widget.product.category = value!.cid;
                      });
                    }),
                const SizedBox(height: 10),
                _isLoading
                    ? const ShowLoading()
                    : CustomElevatedButton(
                        title: 'Save',
                        onTap: () async {
                          CustomService.dismissKeyboard();
                          if (_key.currentState!.validate()) {
                            if (widget.product.category == null) {
                              CustomToast.errorToast(
                                  message: 'Select Category');
                              return;
                            }
                            setState(() {
                              _isLoading = true;
                            });
                            if (widget.product.urls.isEmpty) {
                              List<String> urls = <String>[];
                              for (int i = 0; i < 10; i++) {
                                if (_files[i] != null) {
                                  final String? tempURL =
                                      await ProductAPI().uploadImage(
                                    pid: widget.product.pid,
                                    file: File(_files[i]!.path),
                                  );
                                  urls.add(tempURL ?? '');
                                }
                              }
                              widget.product.urls = urls;
                            }
                            widget.product.name = _name.text;
                            widget.product.description = _description.text;
                            widget.product.quantity = int.parse(_qty.text);
                            widget.product.price = double.parse(_price.text);
                            widget.product.timestamp =
                                TimeDateFunctions.timestamp;
                            widget.product.addedBy = AuthMethods.uid;

                            await ProductAPI().addProduct(widget.product);
                            if (!mounted) return;
                            Provider.of<ProductProvider>(context, listen: false)
                                .refesh();
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  _fetchMedia() async {
    final List<XFile>? result = await ImageFunctions().selectMultiImages();
    if (result == null) return;
    _files.clear();
    for (XFile element in result) {
      _files.add(element);
    }
    for (int i = result.length; i < 10; i++) {
      _files.add(null);
    }

    setState(() {});
  }
}
