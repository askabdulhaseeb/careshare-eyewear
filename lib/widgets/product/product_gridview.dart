import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/order_provider.dart';
import '../custom_widgets/custom_elevated_button.dart';
import '../custom_widgets/custom_slideable_urls_tile.dart';
import '../custom_widgets/custom_textformfield.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    required this.posts,
    this.crossAxisCount = 2,
    Key? key,
  }) : super(key: key);
  final List<Product> posts;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      primary: false,
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.grey.shade200,
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    CustomDialog(post: posts[index]),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Hero(
                    tag: posts[index].pid,
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomSlidableURLsTile(urls: posts[index].urls),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        posts[index].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Price: ${posts[index].price}'),
                      Text('Qty: ${posts[index].quantity}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {
  const CustomDialog({required this.post, Key? key}) : super(key: key);

  final Product post;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  String _qty = '1';
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height - 100;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Dialog(
        child: SizedBox(
          height: height,
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: height / 2,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    SizedBox(
                      height: height / 2,
                      width: double.infinity,
                      child: CustomSlidableURLsTile(urls: widget.post.urls),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.cancel),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: (height / 2),
                  width: 300 - 40,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SelectableText(
                          widget.post.name,
                          maxLines: 2,
                          minLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        SelectableText(
                          'ID: ${widget.post.pid}',
                          maxLines: 2,
                          minLines: 1,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SelectableText(
                          'Price: ${widget.post.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SelectableText(
                          'Avaiable Qty: ${widget.post.quantity}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        const Text(
                          'About this',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SelectableText(widget.post.description),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                int temp = int.parse(_qty);
                                if (temp == 0) return;
                                temp--;
                                setState(() {
                                  _qty = temp.toString();
                                });
                              },
                              splashRadius: 16,
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: 100,
                                child: Center(child: Text(_qty)),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                int temp = int.parse(_qty);
                                if (temp == widget.post.quantity) return;
                                temp++;
                                setState(() {
                                  _qty = temp.toString();
                                });
                              },
                              splashRadius: 16,
                              icon: const Icon(
                                Icons.add_circle,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        CustomElevatedButton(
                          title: 'Add To Cart',
                          onTap: () {
                            Provider.of<OrderProvider>(context, listen: false)
                                .addInCart(widget.post, int.parse(_qty));
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
