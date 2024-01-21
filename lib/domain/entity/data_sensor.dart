import 'package:equatable/equatable.dart';

class DataSensor extends Equatable {
  final Map<String, dynamic> node1;
  final Map<String, dynamic> node2;
  final String? date;
  const DataSensor({
    required this.node1,
    required this.node2,
    this.date,
  });

  @override
  List<Object?> get props => [node1, node2, date];
}
