import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> getSales() async {
    try {
      final response = await _dio.get('http://localhost:4080/sale');
      return List<Map<String, dynamic>>.from(response.data);
    } catch (error) {
      throw Exception('Error fetching sales: $error');
    }
  }
}
