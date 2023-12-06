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
  final DateTime createdAt;
  final DateTime
      updatedAt; // Nueva propiedad para almacenar la fecha de actualización

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
    required this.createdAt,
    required this.updatedAt,
  });

  // Método para convertir un mapa (JSON) en una instancia de SaleModel
  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['ID_Sale'],
      statePay: json['StatePay'] ?? false,
      quickSale: json['QuickSale'],
      discount: double.parse(json['Discount']),
      subTotal: double.parse(json['SubTotal']),
      total: double.parse(json['Total']),
      payment: json['Payment'],
      state: json['State'],
      userId: json['User_ID'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(
          json['updatedAt']), // Parsea la cadena de fecha a DateTime
    );
  }
}
