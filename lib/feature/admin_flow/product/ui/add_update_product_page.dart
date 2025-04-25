import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_store_bloc/core/product/bloc/product_bloc.dart';
import 'package:products_store_bloc/core/product/bloc/product_event.dart';
import 'package:products_store_bloc/core/product/bloc/product_state.dart';
import 'package:products_store_bloc/core/product/model/product.dart';
import 'package:products_store_bloc/core/product/model/rating.dart';
import 'package:products_store_bloc/core/ui/rounded_button.dart';

class AddUpdateProductPage extends StatefulWidget {
  final Product? product;

  const AddUpdateProductPage({super.key, this.product});

  @override
  State<AddUpdateProductPage> createState() => _AddUpdateProductPageState();
}

class _AddUpdateProductPageState extends State<AddUpdateProductPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _descController;
  late TextEditingController _imageController;
  late TextEditingController _quantityController;
  String _selectedCategory = 'electronics';

  final List<String> _categories = [
    'electronics',
    'jewelery',
    "men's clothing",
    "women's clothing"
  ];

  @override
  void initState() {
    super.initState();
    final product = widget.product;

    _titleController = TextEditingController(text: product?.title ?? '');
    _priceController = TextEditingController(
        text: product != null ? product.price.toString() : '');
    _descController = TextEditingController(text: product?.description ?? '');
    _imageController = TextEditingController(text: product?.image ?? '');
    _quantityController = TextEditingController(text: product?.quantity?.toString() ?? '');
    _selectedCategory = product?.category ?? _categories.first;
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;

    final productState = context.read<ProductBloc>().state;

    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if(state is SuccessState) {
          Navigator.pop(context);
        }
        else if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [

            Scaffold(
              appBar: AppBar(
                title: Text(isEdit ? 'Update Product' : 'Add Product'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                        validator: (val) =>
                        val == null || val.isEmpty ? 'Title is required' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _priceController,
                        decoration: const InputDecoration(labelText: 'Price'),
                        keyboardType: TextInputType.number,
                        validator: (val) =>
                        val == null || double.tryParse(val) == null
                            ? 'Enter valid price'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _quantityController,
                        decoration: const InputDecoration(labelText: 'Quantity'),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _descController,
                        decoration: const InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _imageController,
                        decoration: const InputDecoration(labelText: 'Image URL'),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        items: _categories
                            .map((cat) =>
                            DropdownMenuItem(value: cat, child: Text(cat)))
                            .toList(),
                        onChanged: (val) => setState(() {
                          _selectedCategory = val!;
                        }),
                        decoration: const InputDecoration(labelText: 'Category'),
                      ),
                      const SizedBox(height: 24),
                      RoundedButton(
                        isEdit ? 'Update Product' : 'Add Product',
                        isLoading: (productState is LoadingState) ? true : false,
                        onPressed: _handleSubmit,
                      ),

                    ],
                  ),
                ),
              ),
            ),

            if(state is LoadingState) ...[
              const Center(child: CircularProgressIndicator()),
            ],

          ],
        );
      },
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final product = Product(
        id: widget.product?.id ?? 12,
        title: _titleController.text.trim(),
        price: double.tryParse(_priceController.text.trim()) ?? 0,
        description: _descController.text.trim(),
        image: _imageController.text.trim(),
        category: _selectedCategory,
        rating: Rating(rate: 0.0, count: 0),
        quantity: int.tryParse(_quantityController.text.trim()) ?? 0,
      );

      if(widget.product == null) {
        //add new product
        context.read<ProductBloc>().add(CreateProduct(product));
      }
      else {
        //update product
        context.read<ProductBloc>().add(UpdateProduct(product));
      }

    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _quantityController.dispose();
    _imageController.dispose();
    super.dispose();
  }

}
