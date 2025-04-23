import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/home/bloc/product_bloc.dart';
import 'package:products_store_bloc/feature/home/bloc/product_event.dart';
import 'package:products_store_bloc/feature/home/ui/widgets/category_item.dart';

class CategoriesList extends StatelessWidget {
  final List<dynamic> categories;

  const CategoriesList(
    this.categories, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 136,
      child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            String category = categories[index];

            return CategoryItem(
              category: category,
              onTap: () {
                if (category == 'All') {
                  context.read<ProductBloc>().add(LoadProducts());
                } else {
                  context
                      .read<ProductBloc>()
                      .add(GetCategoryProducts(category));
                }
              },
            );
          }),
    );
  }
}
