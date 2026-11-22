import 'package:dio/dio.dart';
import 'package:fast_location/src/http/dio_config.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';

class ViaCepRepository {
  final Dio _dio;

  ViaCepRepository({Dio? dio}) : _dio = dio ?? DioConfig.createClient();

  Future<AddressModel?> fetchByCep(String cep) async {
    try {
      final response = await _dio.get('/$cep/json/');
      final data = response.data;

      // ViaCEP retorna HTTP 200 com {"erro": true} quando o CEP nao existe
      if (data is Map<String, dynamic>) {
        if (data['erro'] == true || data['erro'] == 'true') {
          return null;
        }
        return AddressModel.fromJson(data);
      }

      return null;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw Exception('Tempo de conexão esgotado. Tente novamente.');
      }
      throw Exception('Não foi possível consultar o CEP. Verifique sua internet.');
    }
  }

  Future<List<AddressModel>> fetchByAddress({
    required String uf,
    required String city,
    required String street,
  }) async {
    try {
      final encodedUf = Uri.encodeComponent(uf.trim().toUpperCase());
      final encodedCity = Uri.encodeComponent(city.trim());
      final encodedStreet = Uri.encodeComponent(street.trim());

      final response =
          await _dio.get('/$encodedUf/$encodedCity/$encodedStreet/json/');
      final data = response.data;

      if (data is List) {
        return data
            .whereType<Map<String, dynamic>>()
            .map(AddressModel.fromJson)
            .toList();
      }

      return [];
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        throw Exception('Tempo de conexão esgotado. Tente novamente.');
      }
      throw Exception('Erro ao buscar CEP por endereço. Verifique sua conexão.');
    }
  }
}
