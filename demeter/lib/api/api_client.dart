import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> getSales() async {
    try {
      final response = await _dio.get('http://26.3.226.167:4080/saleUP');
      return List<Map<String, dynamic>>.from(response.data);
    } catch (error) {
      throw Exception('xdError fetching sales: $error');
    }
  }

  Future<List<Map<String, dynamic>>> getPaidSales() async {
    try {
      final response = await _dio.get('http://26.3.226.167:4080/saleDOWN');
      return List<Map<String, dynamic>>.from(response.data);
    } catch (error) {
      throw Exception('Error fetching paid sales: $error');
    }
  }

  Future<Response> getSalesByTimeRange({
    required String startTime,
    required String endTime,
  }) async {
    try {
      final response = await _dio.get(
        'http://26.3.226.167:4080/getSaleByTime',
        queryParameters: {
          'startTime': startTime,
          'endTime': endTime,
        },
      );
      return response;
    } catch (error) {
      throw Exception('Error fetching sales by time range: $error');
    }
  }
}
