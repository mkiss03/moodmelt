import 'package:dio/dio.dart';

class MicrotherapyApi {
  final Dio _dio;

  // TODO: Update this with your actual backend URL
  static const String baseUrl = 'http://localhost:4000/api/microtherapy';

  MicrotherapyApi({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
                headers: {
                  'Content-Type': 'application/json',
                },
              ),
            );

  Future<String> reframeThought(String thought, {String locale = 'hu'}) async {
    try {
      final response = await _dio.post(
        '/reframe',
        data: {
          'thought': thought,
          'locale': locale,
        },
      );

      if (response.statusCode == 200) {
        return response.data['reframed'] as String;
      } else {
        throw Exception('Failed to reframe thought: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('A kapcsolat időtúllépés miatt megszakadt. Próbáld újra.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Nem sikerült kapcsolódni a szerverhez. Ellenőrizd az internetkapcsolatodat.');
      } else {
        throw Exception('Hiba történt: ${e.message}');
      }
    } catch (e) {
      throw Exception('Váratlan hiba: $e');
    }
  }

  Future<Map<String, dynamic>> getTornadoThoughts(
    double moodLevel, {
    String locale = 'hu',
  }) async {
    try {
      final response = await _dio.post(
        '/tornado',
        data: {
          'moodLevel': moodLevel,
          'locale': locale,
        },
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to get tornado thoughts');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> getMindDeclutterSuggestions({
    String locale = 'hu',
  }) async {
    try {
      final response = await _dio.post(
        '/declutter',
        data: {
          'locale': locale,
        },
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to get declutter suggestions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
