import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ta_ews_application/domain/entity/sungai.dart';

class SungaiModel extends Sungai {
  const SungaiModel({
    required super.idSungai,
    required super.namaSungai,
    required super.lokasiSungai,
    super.koordinatSungai,
  });

  SungaiModel copyWith({
    String? idSungai,
    String? namaSungai,
    String? lokasiSungai,
    GeoPoint? koordinatSungai,
  }) {
    return SungaiModel(
      idSungai: idSungai ?? this.idSungai,
      namaSungai: namaSungai ?? this.namaSungai,
      lokasiSungai: lokasiSungai ?? this.lokasiSungai,
      koordinatSungai: koordinatSungai ?? this.koordinatSungai,
    );
  }

  factory SungaiModel.empty() => const SungaiModel(
      idSungai: 'Id Sungai',
      namaSungai: 'Nama Sungai',
      lokasiSungai: 'Lokasi Sungai',
      koordinatSungai: GeoPoint(0, 0));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'namaSungai': namaSungai,
      'lokasiSungai': lokasiSungai,
      'koordinatSungai': koordinatSungai,
    };
  }

  factory SungaiModel.fromMap(Map<String, dynamic> map) {
    return SungaiModel(
      idSungai: map['id_sungai'] as String,
      namaSungai: map['nama_sungai'] as String,
      lokasiSungai: map['lokasi_sungai'] as String,
      koordinatSungai: map['koordinat_sungai'] as GeoPoint,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory SungaiModel.fromJson(String source) =>
      SungaiModel.fromMap(jsonDecode(source) as Map<String, dynamic>);

  factory SungaiModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return SungaiModel(
        idSungai: snapshot.id,
        namaSungai: data?['nama_sungai'],
        lokasiSungai: data?['lokasi_sungai'],
        koordinatSungai: data?['koordinat_sungai']);
  }
  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'nama_sungai': namaSungai,
      'lokasi_sungai': lokasiSungai,
      if (koordinatSungai != null) 'koordinat_sungai': koordinatSungai,
    };
  }
}
