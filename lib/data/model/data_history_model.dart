import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ta_ews_application/domain/entity/data_history.dart';

class DataHistoryModel extends DataHistory {
  const DataHistoryModel(
      {required super.node,
      required super.datetime,
      required super.valueWaterLevel,
      required super.statusWaterLevel,
      required super.valueWaterTurbidity,
      required super.statusWaterTurbidity,
      required super.valueRainIntensity,
      required super.statusRainIntensity,
      required super.levelDanger});

  factory DataHistoryModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return DataHistoryModel(
        node: data?['node'] ?? "Null",
        datetime: data?['datetime'] ?? "1970-01-01 00:00:00",
        levelDanger: data?['levelDanger'] ?? "Null",
        valueWaterLevel: data?['waterLevel'].toDouble() ?? 0.0,
        statusWaterLevel: data?['waterLevelStatus'] ?? "Null",
        valueWaterTurbidity: data?['waterTurbidity'].toDouble() ?? 0.0,
        statusWaterTurbidity: data?['waterTurbidityStatus'] ?? "Null",
        valueRainIntensity: data?['rainIntensity'].toDouble() ?? 0.0,
        statusRainIntensity: data?['rainIntensityStatus'] ?? "Null");
  }

  Map<String, Object?> toFirestore() {
    return {
      "node": node,
      "datetime": datetime,
      "levelDanger": levelDanger,
      "waterLevel": valueWaterLevel,
      "waterLevelStatus": statusWaterLevel,
      "waterTurbidity": valueWaterTurbidity,
      "waterTurbidityStatus": statusWaterTurbidity,
      "rainIntensity": valueRainIntensity,
      "rainIntensityStatus": statusRainIntensity,
    };
  }
}
