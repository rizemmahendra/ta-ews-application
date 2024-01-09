import 'package:equatable/equatable.dart';

class DataSungai extends Equatable {
  final String namaSungai;
  final String lokasiSungai;
  final String koordinatSungai;

  const DataSungai(
      {required this.namaSungai,
      required this.lokasiSungai,
      required this.koordinatSungai});

  @override
  List<Object?> get props => [namaSungai];
}
