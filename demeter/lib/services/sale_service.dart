import 'package:demeter/api/api_client.dart';
import 'package:demeter/models/sale_model.dart';
import 'package:intl/intl.dart';

class SaleService {
  final ApiClient _apiClient = ApiClient();

  Future<List<SaleModel>> getSales() async {
    final List<Map<String, dynamic>> salesData = await _apiClient.getSales();
    return salesData.map((saleData) => SaleModel.fromJson(saleData)).toList();
  }

  Future<List<SaleModel>> getPaidSales() async {
    final List<Map<String, dynamic>> salesData =
        await _apiClient.getPaidSales();
    return salesData.map((saleData) => SaleModel.fromJson(saleData)).toList();
  }

  Future<List<Map<String, dynamic>>> getSalesByTimeRange({
    required String startTime,
    required String endTime,
  }) async {
    try {
      final response = await _apiClient.getSalesByTimeRange(
        startTime: startTime,
        endTime: endTime,
      );
      return List<Map<String, dynamic>>.from(response.data);
    } catch (error) {
      throw Exception('Error fetching sales by time range: $error');
    }
  }
}
