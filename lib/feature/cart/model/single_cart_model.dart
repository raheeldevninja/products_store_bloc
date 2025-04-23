class SingleCartResponse {
  int? id;
  int? userId;
  String? date;
  List<CartProductModel>? cartProducts;
  int? iV;

  SingleCartResponse({this.id, this.userId, this.date, this.cartProducts, this.iV});

  SingleCartResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    if (json['products'] != null) {
      cartProducts = <CartProductModel>[];
      json['products'].forEach((v) {
        cartProducts!.add(CartProductModel.fromJson(v));
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

class CartProductModel {
  int? productId;
  int? quantity;

  CartProductModel({this.productId, this.quantity});

  CartProductModel.fromJson(Map<String, dynamic> json) {
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