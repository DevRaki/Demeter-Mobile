import 'package:dio/dio.dart';

class SaleDetailsService {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> getSaleDetails(int saleId) async {
    try {
      final response =
          await _dio.get('http://localhost:4080/detailsWproduct/$saleId');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Failed to load sale details');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<void> updateSalePayment(int saleId, String payment) async {
    try {
      final response = await _dio.put(
        'http://localhost:4080/paySale',
        data: {'ID_Sale': saleId, 'Payment': payment},
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to update sale payment');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
