class UpdateBasketModel {
  final bool status;
  final String message;
  final UpdateBasketData data;

  UpdateBasketModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateBasketModel.fromJson(Map<String, dynamic> json) {
    return UpdateBasketModel(
      status: json['status'] as bool,
      message: json['message'] as String? ?? '',
      data: UpdateBasketData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class UpdateBasketData {
  final List<CartItems> cartItems;
  final dynamic subTotal;
  final dynamic total;

  UpdateBasketData({
    required this.cartItems,
    required this.subTotal,
    required this.total,
  });
  factory UpdateBasketData.fromJson(Map<String, dynamic> json) {
    return UpdateBasketData(
      cartItems: List.from(json['cart_items'] as List<CartItems>? ?? [])
          .map((e) => CartItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      subTotal: json['subTotal'],
      total: json['total'],
    );
  }
}

class CartItems {
  final int id;
  dynamic quantity;
  final Product product;

  CartItems({
    required this.quantity,
    required this.product,
    required this.id,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) {
    return CartItems(
      id: json['id'] as int,
      quantity: json['quantity'],
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );
  }
}

class Product {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final String image;
  final String name;
  final String description;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}
