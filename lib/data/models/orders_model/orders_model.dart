class OrdersModel {
  final bool status;
  final Data data;

  OrdersModel({
    required this.status,
    required this.data,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      status: json['status'] as bool,
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class Data {
  final List<OrderData> listDoneOrders;
  final int total;
  Data({required this.listDoneOrders, required this.total});
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      total: json['total'] as int,
      listDoneOrders: (json['data'] as List<dynamic>)
          .map((element) => OrderData.fromJson(element as Map<String, dynamic>))
          .toList(),
    );
  }
}

class OrderData {
  final int id;
  final int total;
  final String date;
  final String orderStatus;
  OrderData({
    required this.id,
    required this.total,
    required this.date,
    required this.orderStatus,
  });
  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'] as int,
      total: (json['total'] as num).toInt(),
      date: json['date'] as String,
      orderStatus: json['status'] as String,
    );
  }
}
