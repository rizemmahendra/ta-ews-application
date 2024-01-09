// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class DataSensor extends Equatable {
  final int valueTinggiNode1;
  final String statusTinggiNode1;
  final int valueTinggiNode2;
  final String statusTinggiNode2;

  final int valueKekeruhanNode1;
  final String statusKekeruhanNode1;
  final int valueKekeruhanNode2;
  final String statusKekeruhanNode2;

  final int valueHujanNode1;
  final String statusHujanNode1;
  final int valueHujanNode2;
  final String statusHujanNode2;

  final String levelBahayaNode1;
  final String levelBahayaNode2;

  const DataSensor({
    required this.valueTinggiNode1,
    required this.statusTinggiNode1,
    required this.valueTinggiNode2,
    required this.statusTinggiNode2,
    required this.valueKekeruhanNode1,
    required this.statusKekeruhanNode1,
    required this.valueKekeruhanNode2,
    required this.statusKekeruhanNode2,
    required this.valueHujanNode1,
    required this.statusHujanNode1,
    required this.valueHujanNode2,
    required this.statusHujanNode2,
    required this.levelBahayaNode1,
    required this.levelBahayaNode2,
  });

  @override
  List<Object?> get props => [];
}
