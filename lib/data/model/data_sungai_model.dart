import 'dart:convert';

import 'package:ta_ews_application/domain/entity/data_sungai.dart';

class DataSungaiModel extends DataSungai {
  const DataSungaiModel(
      {required super.namaSungai,
      required super.lokasiSungai,
      required super.koordinatSungai});

  DataSungaiModel copyWith(
      {String? namaSungai, String? lokasiSungai, String? koordinatSungai}) {
    return DataSungaiModel(
        namaSungai: namaSungai ?? this.namaSungai,
        lokasiSungai: lokasiSungai ?? this.lokasiSungai,
        koordinatSungai: koordinatSungai ?? this.koordinatSungai);
  }

  factory DataSungaiModel.fromJson(String source) =>
      DataSungaiModel.fromMap(jsonDecode(source) as Map<String, dynamic>);

  DataSungaiModel.fromMap(Map<String, dynamic> map)
      : this(
            namaSungai: map["river_name"] as String,
            lokasiSungai: map["river_location"] as String,
            koordinatSungai: map["river_coordinat"] as String);

  Map<String, dynamic> toMap() => {
        'nama_sungai': namaSungai,
        'lokasi_sungai': lokasiSungai,
        'koordinat_sungai': koordinatSungai
      };

  String toJson() => jsonEncode(toMap());
}
