import 'package:geocoding/geocoding.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:fast_location/src/modules/home/repositories/address_local_repository.dart';
import 'package:fast_location/src/modules/home/repositories/via_cep_repository.dart';

class HomeService {
  final ViaCepRepository _remoteRepository;
  final AddressLocalRepository _localRepository;

  HomeService({
    ViaCepRepository? remoteRepository,
    AddressLocalRepository? localRepository,
  })  : _remoteRepository = remoteRepository ?? ViaCepRepository(),
        _localRepository = localRepository ?? AddressLocalRepository();

  Future<AddressModel?> consultByCep(String rawCep) async {
    final cleanCep = rawCep.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanCep.length != 8) {
      throw Exception('Informe um CEP válido com 8 dígitos.');
    }

    // Reaproveita o armazenamento local em consultas recorrentes do mesmo CEP
    final cached = _localRepository.findByCep(cleanCep);
    if (cached != null) {
      await _localRepository.saveAddress(cached);
      return _localRepository.getLastAddress();
    }

    final remoteAddress = await _remoteRepository.fetchByCep(cleanCep);
    if (remoteAddress == null) {
      return null;
    }

    await _localRepository.saveAddress(remoteAddress);
    return _localRepository.getLastAddress();
  }

  Future<List<AddressModel>> consultByAddress({
    required String uf,
    required String city,
    required String street,
  }) async {
    final cleanUf = uf.trim().toUpperCase();
    final cleanCity = city.trim();
    final cleanStreet = street.trim();

    if (cleanUf.length != 2) {
      throw Exception('Informe a sigla do estado (UF) com 2 letras.');
    }
    if (cleanCity.length < 3) {
      throw Exception('Informe ao menos 3 caracteres para a cidade.');
    }
    if (cleanStreet.length < 3) {
      throw Exception('Informe ao menos 3 caracteres para o logradouro.');
    }

    return _remoteRepository.fetchByAddress(
      uf: cleanUf,
      city: cleanCity,
      street: cleanStreet,
    );
  }

  Future<void> saveSelectedAddress(AddressModel address) async {
    await _localRepository.saveAddress(address);
  }

  List<AddressModel> getHistory() {
    return _localRepository.getAllAddresses();
  }

  AddressModel? getLastAddress() {
    return _localRepository.getLastAddress();
  }

  Future<void> clearHistory() async {
    await _localRepository.clearAll();
  }

  Future<void> openRouteToAddress(AddressModel address) async {
    final installedMaps = await MapLauncher.installedMaps;
    if (installedMaps.isEmpty) {
      throw Exception('Nenhum aplicativo de mapas encontrado no dispositivo.');
    }

    List<Location> locations;
    try {
      locations = await locationFromAddress(address.fullAddress);
    } catch (_) {
      locations = [];
    }

    if (locations.isEmpty) {
      throw Exception(
        'Não foi possível localizar as coordenadas para este endereço.',
      );
    }

    final target = locations.first;
    await installedMaps.first.showDirections(
      destination: Coords(target.latitude, target.longitude),
      destinationTitle: '${address.displayStreet} - ${address.cep}',
    );
  }
}
