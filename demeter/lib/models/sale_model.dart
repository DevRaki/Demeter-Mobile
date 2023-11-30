class SaleModel {
  final int id;
  final bool statePay;
  final bool quickSale;
  final double discount;
  final double subTotal;
  final double total;
  final String payment;
  final bool state;
  final int? userId;

  SaleModel({
    required this.id,
    required this.statePay,
    required this.quickSale,
    required this.discount,
    required this.subTotal,
    required this.total,
    required this.payment,
    required this.state,
    required this.userId,
  });

  // Método para convertir un mapa (JSON) en una instancia de SaleModel
  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['ID_Sale'],
      statePay: json['StatePay'],
      quickSale: json['QuickSale'],
      discount: double.parse(json['Discount']),
      subTotal: double.parse(json['SubTotal']),
      total: double.parse(json['Total']),
      payment: json['Payment'],
      state: json['State'],
      userId: json['User_ID'],
    );
  }
}
