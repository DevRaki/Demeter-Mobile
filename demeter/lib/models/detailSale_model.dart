class SaleDetailModel {
  final int id;
  final int lot;
  final int saleId;
  final int productId;
  final ProductModel product;

  SaleDetailModel({
    required this.id,
    required this.lot,
    required this.saleId,
    required this.productId,
    required this.product,
  });

  factory SaleDetailModel.fromJson(Map<String, dynamic> json) {
    return SaleDetailModel(
      id: json['ID_SaleDetail'],
      lot: json['Lot'],
      saleId: json['Sale_ID'],
      productId: json['Product_ID'],
      product: ProductModel.fromJson(json['Product']),
    );
  }
}

class ProductModel {
  final String name;
  final double price;

  ProductModel({
    required this.name,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['Name_Products'],
      price: double.parse(json['Price_Product']),
    );
  }
}
