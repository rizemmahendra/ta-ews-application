part of 'data_sungai_bloc.dart';

abstract class DataSungaiEvent extends Equatable {
  const DataSungaiEvent();

  @override
  List<Object> get props => [];
}

class GetDataSungaiEvent extends DataSungaiEvent {
  const GetDataSungaiEvent();

  @override
  List<Object> get props => [];
}

class SubscribeDataSensor extends DataSungaiEvent {
  const SubscribeDataSensor();
}

class UpdateDataSensor extends DataSungaiEvent {
  const UpdateDataSensor(this.dataSensor);

  final DataSensor dataSensor;

  @override
  List<Object> get props => [dataSensor];
}
