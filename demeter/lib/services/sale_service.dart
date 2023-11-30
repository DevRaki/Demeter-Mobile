import 'package:demeter/api/api_client.dart';
import 'package:demeter/models/sale_model.dart';

class SaleService {
  final ApiClient _apiClient = ApiClient();

  Future<List<SaleModel>> getSales() async {
    final List<Map<String, dynamic>> salesData = await _apiClient.getSales();

    return salesData.map((saleData) => SaleModel.fromJson(saleData)).toList();
  }
}
