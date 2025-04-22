import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/feature/cart/model/single_cart_model.dart';
import 'package:products_store_bloc/feature/cart/ui/cart_product_item.dart';
import 'package:products_store_bloc/feature/home/bloc/product_bloc.dart';
import 'package:products_store_bloc/feature/home/bloc/product_event.dart';
import 'package:products_store_bloc/feature/home/bloc/product_state.dart';
import 'package:products_store_bloc/feature/home/model/product.dart';

class CartProductsPage extends StatefulWidget {
  final List<CartProduct> cartProducts;

  const CartProductsPage({
    super.key,
    required this.cartProducts,
  });

  @override
  State<CartProductsPage> createState() => _CartProductsPageState();
}

class _CartProductsPageState extends State<CartProductsPage> {

  List<Product> products = [];

  @override
  void initState() {
    super.initState();

    _getCartProducts();
  }

  _getCartProducts() {
    for(int i=0; i<widget.cartProducts.length; i++) {
      context.read<ProductBloc>().add(GetSingleProduct(widget.cartProducts[i].productId ?? 0));
    }
  }

  @override
  void didUpdateWidget(covariant CartProductsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _getCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if(state is SingleProductLoadedState) {
            products.add(state.product);
          }
          else if(state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return CartProductItem(product: product, quantity: widget.cartProducts[index].quantity ?? 0,);
            },
          );
        },
    );
  }
}
