import 'package:buy_it_app/model/product/product.dart';
import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final Product product;
  const SingleProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    print('Rendering SingleProduct: $product'); // Debug print
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        shape: BeveledRectangleBorder(
            side: const BorderSide(color: Colors.blue, width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        title: Text(
          product.productTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.productDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Price : "),
                const SizedBox(width: 10),
                Text(product.productPrice.toString()),
                const SizedBox(width: 10),
                const Text("Rating : "),
                const SizedBox(width: 10),
                Text(product.productRating.productRating.toString()),
              ],
            )
          ],
        ),
        leading: SizedBox(
            height: 70,
            width: 70,
            child: Image.network(product.productImage)),
      ),
    );
  }
}
