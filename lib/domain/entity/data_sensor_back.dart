// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class DataSensor extends Equatable {
  final Map<String, dynamic> node1;
  final Map<String, dynamic> node2;
  final Map<String, String> statusBahaya;

  const DataSensor({
    required this.node1,
    required this.node2,
    required this.statusBahaya,
  });

  @override
  List<Object?> get props => [];
}
