class BasketGetOrdersModel {
  final bool status;
  final Data data;

  BasketGetOrdersModel({
    required this.status,
    required this.data,
  });

  factory BasketGetOrdersModel.fromJson(Map<String, dynamic> json) {
    return BasketGetOrdersModel(
      status: json['status'] as bool,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class BasketModel {
  final bool status;
  final String message;
  final Cart data;

  BasketModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BasketModel.fromJson(Map<String, dynamic> json) {
    return BasketModel(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: Cart.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class Data {
  final List<Cart> cartItems;
  dynamic subTotal;
  final int total;
  Data({
    required this.cartItems,
    this.subTotal,
    required this.total,
  });
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      cartItems: (json['cart_items'] as List<dynamic>)
          .map((e) => Cart.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      subTotal: json['subTotal'],
    );
  }
}

class Cart {
  final int id;
  dynamic quantity;
  final Product product;

  Cart({
    required this.quantity,
    required this.product,
    required this.id,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
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
