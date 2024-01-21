import 'dart:math';

import 'package:ta_ews_application/domain/entity/data_history_sensor.dart';
import 'package:ta_ews_application/domain/entity/data_sensor.dart';

class DataHistorySensorModel extends DataHistorySensor {
  const DataHistorySensorModel(
      {required super.key,
      required super.valueWaterLevelNode1,
      required super.valueWaterLevelNode2,
      required super.maxValueWaterLevel,
      required super.valueTurbidityNode1,
      required super.valueTurbidityNode2,
      required super.maxValueTurbidity,
      required super.valueRainNode1,
      required super.valueRainNode2,
      required super.maxValueRain});

  factory DataHistorySensorModel.fromListDataSensor(List<DataSensor> data) {
    List<String> key = data.map((value) => value.date!).toList();
    List<double> valueWaterLevelNode1 =
        data.map((e) => (e.node1['waterLevel'] as int).toDouble()).toList();
    List<double> valueWaterLevelNode2 =
        data.map((e) => (e.node2['waterLevel'] as int).toDouble()).toList();
    int maxValueWaterLevel =
        valueWaterLevelNode1.reduce(max) > valueWaterLevelNode2.reduce(max)
            ? valueWaterLevelNode1.reduce(max).toInt()
            : valueWaterLevelNode2.reduce(max).toInt();
    List<double> valueTurbidityNode1 =
        data.map((e) => (e.node1['waterTurbidity'] as int).toDouble()).toList();
    List<double> valueTurbidityNode2 =
        data.map((e) => (e.node2['waterTurbidity'] as int).toDouble()).toList();
    int maxValueTurbidity =
        valueTurbidityNode1.reduce(max) > valueTurbidityNode2.reduce(max)
            ? valueWaterLevelNode1.reduce(max).toInt()
            : valueWaterLevelNode2.reduce(max).toInt();
    List<double> valueRainNode1 =
        data.map((e) => (e.node1['rainIntensity'] as int).toDouble()).toList();
    List<double> valueRainNode2 =
        data.map((e) => (e.node2['rainIntensity'] as int).toDouble()).toList();
    int maxValueRain = valueRainNode1.reduce(max) > valueRainNode2.reduce(max)
        ? valueRainNode1.reduce(max).toInt()
        : valueRainNode2.reduce(max).toInt();

    return DataHistorySensorModel(
        key: key,
        valueWaterLevelNode1: valueWaterLevelNode1,
        valueWaterLevelNode2: valueWaterLevelNode2,
        maxValueWaterLevel: maxValueWaterLevel,
        valueTurbidityNode1: valueTurbidityNode1,
        valueTurbidityNode2: valueTurbidityNode2,
        maxValueTurbidity: maxValueTurbidity,
        valueRainNode1: valueRainNode1,
        valueRainNode2: valueRainNode2,
        maxValueRain: maxValueRain);
  }

  factory DataHistorySensorModel.empty() {
    return const DataHistorySensorModel(
        key: [],
        valueWaterLevelNode1: [],
        valueWaterLevelNode2: [],
        maxValueWaterLevel: 0,
        valueTurbidityNode1: [],
        valueTurbidityNode2: [],
        maxValueTurbidity: 0,
        valueRainNode1: [],
        valueRainNode2: [],
        maxValueRain: 0);
  }
}
