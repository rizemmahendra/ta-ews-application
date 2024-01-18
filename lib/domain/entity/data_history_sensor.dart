// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class DataHistorySensor extends Equatable {
  const DataHistorySensor({
    required this.key,
    required this.valueWaterLevelNode1,
    required this.valueWaterLevelNode2,
    required this.maxValueWaterLevel,
    required this.valueTurbidityNode1,
    required this.valueTurbidityNode2,
    required this.maxValueTurbidity,
    required this.valueRainNode1,
    required this.valueRainNode2,
    required this.maxValueRain,
  });

  final List<String> key;
  final List<double> valueWaterLevelNode1;
  final List<double> valueWaterLevelNode2;
  final int maxValueWaterLevel;
  final List<double> valueTurbidityNode1;
  final List<double> valueTurbidityNode2;
  final int maxValueTurbidity;
  final List<double> valueRainNode1;
  final List<double> valueRainNode2;
  final int maxValueRain;

  @override
  List<Object> get props {
    return [
      key,
      valueWaterLevelNode1,
      valueWaterLevelNode2,
      maxValueWaterLevel,
      valueTurbidityNode1,
      valueTurbidityNode2,
      maxValueTurbidity,
      valueRainNode1,
      valueRainNode2,
      maxValueRain,
    ];
  }
}
