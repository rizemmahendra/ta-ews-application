import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ta_ews_application/domain/entity/data_sensor_new.dart';

class DataSensorNewModel extends DataSensorNew {
  const DataSensorNewModel(
      {required super.node1, required super.node2, required super.date});

  DataSensorNewModel copyWith({
    Map<String, dynamic>? node1,
    Map<String, dynamic>? node2,
    String? date,
  }) {
    return DataSensorNewModel(
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

  factory DataSensorNewModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return DataSensorNewModel(
        node1: data?['node1'], node2: data?['node2'], date: data?['date']);
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'node1': node1,
      'node2': node2,
      if (date != null) 'date': date
    };
  }

  factory DataSensorNewModel.fromMap(Map<String, dynamic> map) {
    return DataSensorNewModel(
      node1: Map<String, dynamic>.from((map['node1'] as Map<String, dynamic>)),
      node2: Map<String, dynamic>.from((map['node2'] as Map<String, dynamic>)),
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory DataSensorNewModel.fromJson(String source) =>
      DataSensorNewModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
