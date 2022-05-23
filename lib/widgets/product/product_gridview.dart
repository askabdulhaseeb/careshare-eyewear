import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../custom_widgets/custom_slideable_urls_tile.dart';

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

class CustomDialog extends StatelessWidget {
  const CustomDialog({required this.post, Key? key}) : super(key: key);

  final Product post;

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
                      child: CustomSlidableURLsTile(urls: post.urls),
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
                          post.name,
                          maxLines: 2,
                          minLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        SelectableText(
                          'ID: ${post.pid}',
                          maxLines: 2,
                          minLines: 1,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SelectableText(
                          'Price: ${post.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SelectableText(
                          'Avaiable Qty: ${post.quantity}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        const Text(
                          'About this',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SelectableText(post.description),
                        Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: () {},
                              splashRadius: 16,
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              splashRadius: 16,
                              icon: const Icon(
                                Icons.add_circle,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        )
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
