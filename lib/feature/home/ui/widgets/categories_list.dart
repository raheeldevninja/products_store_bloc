import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  final List<dynamic> categories;

  const CategoriesList(
    this.categories, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                onTap: () {},
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                          child: Text(
                        categories[index],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
