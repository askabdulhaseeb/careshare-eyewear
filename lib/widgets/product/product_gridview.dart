import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../screens/product_screeen/add_product_screen.dart';
import '../custom_widgets/custom_slideable_urls_tile.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({required this.posts, Key? key}) : super(key: key);
  final List<Product> posts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
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
              Navigator.of(context).push(
                MaterialPageRoute<AddProductScreen>(
                  builder: (_) => AddProductScreen(product: posts[index]),
                ),
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
