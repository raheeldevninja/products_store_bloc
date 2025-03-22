import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/home/bloc/product_bloc.dart';
import 'package:products_store_bloc/feature/home/bloc/product_event.dart';
import 'package:products_store_bloc/feature/home/model/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: product.image,
                placeholder: (context, url) =>
                    const CupertinoActivityIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 80.0,
                width: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
                  // Category
                  Text(
                    product.category,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Price
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16.0),
                      const SizedBox(width: 4.0),
                      Text(
                        product.rating?.rate.toString() ?? '0.0',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        '(${product.rating?.count ?? 0} reviews)',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    iconColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  onPressed: () {

                    final productToUpdate = Product(
                      id: product.id,
                      title: 'Bag',
                      price: 499,
                      description: 'New Bag',
                      image: 'https://i.pravatar.cc',
                      category: 'Bag',
                    );

                    context.read<ProductBloc>().add(UpdateProduct(productToUpdate));
                  },
                  child: const Icon(
                    Icons.edit,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    iconColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    context.read<ProductBloc>().add(DeleteProduct(product.id!));
                  },
                  child: const Icon(
                    Icons.delete,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
