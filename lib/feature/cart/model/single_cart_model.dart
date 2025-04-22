class SingleCartResponse {
  int? id;
  int? userId;
  String? date;
  List<CartProduct>? cartProducts;
  int? iV;

  SingleCartResponse({this.id, this.userId, this.date, this.cartProducts, this.iV});

  SingleCartResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    if (json['products'] != null) {
      cartProducts = <CartProduct>[];
      json['products'].forEach((v) {
        cartProducts!.add(CartProduct.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['date'] = date;
    if (cartProducts != null) {
      data['products'] = cartProducts!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    return data;
  }
}

class CartProduct {
  int? productId;
  int? quantity;

  CartProduct({this.productId, this.quantity});

  CartProduct.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}