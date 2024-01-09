import 'dart:convert';
import 'package:ta_ews_application/domain/entity/data_sensor.dart';

class DataSensorModel extends DataSensor {
  const DataSensorModel({
    required super.valueTinggiNode1,
    required super.statusTinggiNode1,
    required super.valueTinggiNode2,
    required super.statusTinggiNode2,
    required super.valueKekeruhanNode1,
    required super.statusKekeruhanNode1,
    required super.valueKekeruhanNode2,
    required super.statusKekeruhanNode2,
    required super.valueHujanNode1,
    required super.statusHujanNode1,
    required super.valueHujanNode2,
    required super.statusHujanNode2,
    required super.levelBahayaNode1,
    required super.levelBahayaNode2,
  });

  DataSensorModel copyWith({
    int? valueTinggiNode1,
    String? statusTinggiNode1,
    int? valueTinggiNode2,
    String? statusTinggiNode2,
    int? valueKekeruhanNode1,
    String? statusKekeruhanNode1,
    int? valueKekeruhanNode2,
    String? statusKekeruhanNode2,
    int? valueHujanNode1,
    String? statusHujanNode1,
    int? valueHujanNode2,
    String? statusHujanNode2,
    String? levelBahayaNode1,
    String? levelBahayaNode2,
  }) {
    return DataSensorModel(
      valueTinggiNode1: valueTinggiNode1 ?? this.valueTinggiNode1,
      statusTinggiNode1: statusTinggiNode1 ?? this.statusTinggiNode1,
      valueTinggiNode2: valueTinggiNode2 ?? this.valueTinggiNode2,
      statusTinggiNode2: statusTinggiNode2 ?? this.statusTinggiNode2,
      valueKekeruhanNode1: valueKekeruhanNode1 ?? this.valueKekeruhanNode1,
      statusKekeruhanNode1: statusKekeruhanNode1 ?? this.statusKekeruhanNode1,
      valueKekeruhanNode2: valueKekeruhanNode2 ?? this.valueKekeruhanNode2,
      statusKekeruhanNode2: statusKekeruhanNode2 ?? this.statusKekeruhanNode2,
      valueHujanNode1: valueHujanNode1 ?? this.valueHujanNode1,
      statusHujanNode1: statusHujanNode1 ?? this.statusHujanNode1,
      valueHujanNode2: valueHujanNode2 ?? this.valueHujanNode2,
      statusHujanNode2: statusHujanNode2 ?? this.statusHujanNode2,
      levelBahayaNode1: levelBahayaNode1 ?? this.levelBahayaNode1,
      levelBahayaNode2: levelBahayaNode2 ?? this.levelBahayaNode2,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'valueTinggiNode1': valueTinggiNode1,
      'statusTinggiNode1': statusTinggiNode1,
      'valueTinggiNode2': valueTinggiNode2,
      'statusTinggiNode2': statusTinggiNode2,
      'valueKekeruhanNode1': valueKekeruhanNode1,
      'statusKekeruhanNode1': statusKekeruhanNode1,
      'valueKekeruhanNode2': valueKekeruhanNode2,
      'statusKekeruhanNode2': statusKekeruhanNode2,
      'valueHujanNode1': valueHujanNode1,
      'statusHujanNode1': statusHujanNode1,
      'valueHujanNode2': valueHujanNode2,
      'statusHujanNode2': statusHujanNode2,
      'levelBahayaNode1': levelBahayaNode1,
      'levelBahayaNode2': levelBahayaNode2,
    };
  }

  factory DataSensorModel.fromMap(Map<String, dynamic> map) {
    return DataSensorModel(
      valueTinggiNode1: map['node1']['water_level'] as int,
      statusTinggiNode1: map['node1']['water_level_status'] as String,
      valueKekeruhanNode1: map['node1']['turbidity'] as int,
      statusKekeruhanNode1: map['node1']['turbidity_status'] as String,
      valueHujanNode1: map['node1']['rain_intensity'] as int,
      statusHujanNode1: map['node1']['rain_intensity_status'] as String,
      levelBahayaNode1: map['node1']['level_danger'] as String,
      valueTinggiNode2: map['node2']['water_level'] as int,
      statusTinggiNode2: map['node2']['water_level_status'] as String,
      valueKekeruhanNode2: map['node2']['turbidity'] as int,
      statusKekeruhanNode2: map['node2']['turbidity_status'] as String,
      valueHujanNode2: map['node2']['rain_intensity'] as int,
      statusHujanNode2: map['node2']['rain_intensity_status'] as String,
      levelBahayaNode2: map['node2']['level_danger'] as String,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory DataSensorModel.fromJson(String source) =>
      DataSensorModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
