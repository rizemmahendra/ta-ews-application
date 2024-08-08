import "package:equatable/equatable.dart";

class DataHistory extends Equatable {
  const DataHistory(
      {required this.node,
      required this.datetime,
      required this.levelDanger,
      required this.valueWaterLevel,
      required this.statusWaterLevel,
      required this.valueWaterTurbidity,
      required this.statusWaterTurbidity,
      required this.valueRainIntensity,
      required this.statusRainIntensity});

  final String node;
  final String datetime;
  final String levelDanger;
  final double valueWaterLevel;
  final String statusWaterLevel;
  final double valueWaterTurbidity;
  final String statusWaterTurbidity;
  final double valueRainIntensity;
  final String statusRainIntensity;

  @override
  List<Object?> get props => [
        node,
        datetime,
        levelDanger,
        valueWaterLevel,
        statusWaterLevel,
        valueWaterTurbidity,
        statusWaterTurbidity,
        valueRainIntensity,
        statusRainIntensity,
      ];
}
