import 'package:hive/hive.dart';

part 'address_model.g.dart';

@HiveType(typeId: 0)
class AddressModel {
  @HiveField(0)
  final String cep;

  @HiveField(1)
  final String logradouro;

  @HiveField(2)
  final String complemento;

  @HiveField(3)
  final String bairro;

  @HiveField(4)
  final String localidade;

  @HiveField(5)
  final String uf;

  @HiveField(6)
  final String ddd;

  @HiveField(7)
  final DateTime? consultedAt;

  AddressModel({
    required this.cep,
    required this.logradouro,
    this.complemento = '',
    required this.bairro,
    required this.localidade,
    required this.uf,
    this.ddd = '',
    this.consultedAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      cep: (json['cep'] ?? '').toString(),
      logradouro: (json['logradouro'] ?? '').toString(),
      complemento: (json['complemento'] ?? '').toString(),
      bairro: (json['bairro'] ?? '').toString(),
      localidade: (json['localidade'] ?? '').toString(),
      uf: (json['uf'] ?? '').toString(),
      ddd: (json['ddd'] ?? '').toString(),
      consultedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
      'ddd': ddd,
    };
  }

  AddressModel copyWith({DateTime? consultedAt}) {
    return AddressModel(
      cep: cep,
      logradouro: logradouro,
      complemento: complemento,
      bairro: bairro,
      localidade: localidade,
      uf: uf,
      ddd: ddd,
      consultedAt: consultedAt ?? this.consultedAt,
    );
  }

  String get cleanCep => cep.replaceAll(RegExp(r'[^0-9]'), '');

  String get fullAddress {
    final parts = <String>[
      if (logradouro.isNotEmpty) logradouro,
      if (bairro.isNotEmpty) bairro,
      if (localidade.isNotEmpty && uf.isNotEmpty) '$localidade - $uf',
      if (cep.isNotEmpty) cep,
      'Brasil',
    ];
    return parts.join(', ');
  }

  String get displayStreet =>
      logradouro.isNotEmpty ? logradouro : 'Logradouro não informado';

  String get displayNeighborhood =>
      bairro.isNotEmpty ? bairro : 'Bairro não informado';

  String get cityState => '$localidade / $uf';
}
