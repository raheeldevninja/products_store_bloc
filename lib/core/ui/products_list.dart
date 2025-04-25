import 'package:flutter/material.dart';
import 'package:products_store_bloc/core/product/model/product.dart';
import 'package:products_store_bloc/feature/home/ui/widgets/product_item.dart';

class ProductsList extends StatelessWidget {
  final List<dynamic> products;

  const ProductsList(
    this.products, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = Product.fromJson(products[index]);
          return ProductItem(product);
        },
      ),
    );
  }
}
