import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sungai extends Equatable {
  final String idSungai;
  final String namaSungai;
  final String lokasiSungai;
  final GeoPoint? koordinatSungai;

  const Sungai({
    required this.idSungai,
    required this.namaSungai,
    required this.lokasiSungai,
    this.koordinatSungai,
  });

  @override
  List<Object?> get props => [idSungai, namaSungai, koordinatSungai];
}
