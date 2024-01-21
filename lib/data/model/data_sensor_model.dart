import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ta_ews_application/domain/entity/data_sensor.dart';

class DataSensorModel extends DataSensor {
  const DataSensorModel(
      {required super.node1, required super.node2, required super.date});

  DataSensorModel copyWith({
    Map<String, dynamic>? node1,
    Map<String, dynamic>? node2,
    String? date,
  }) {
    return DataSensorModel(
      node1: node1 ?? this.node1,
      node2: node2 ?? this.node2,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'node1': node1,
      'node2': node2,
      'date': date,
    };
  }

  factory DataSensorModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    String? date = (snapshot.id != 'history' && snapshot.id != 'realtime')
        ? snapshot.id
        : null;
    return DataSensorModel(
        node1: data?['node1'], node2: data?['node2'], date: date);
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'node1': node1,
      'node2': node2,
      if (date != null) 'date': date
    };
  }

  factory DataSensorModel.fromMap(Map<String, dynamic> map) {
    return DataSensorModel(
      node1: Map<String, dynamic>.from((map['node1'] as Map<String, dynamic>)),
      node2: Map<String, dynamic>.from((map['node2'] as Map<String, dynamic>)),
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory DataSensorModel.fromJson(String source) =>
      DataSensorModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
