part of 'sungai_bloc.dart';

sealed class SungaiState extends Equatable {
  const SungaiState();

  @override
  List<Object> get props => [];
}

class SungaiInitial extends SungaiState {
  const SungaiInitial();
}

class GettingListSungai extends SungaiState {
  const GettingListSungai();
}

class LoadedListSungai extends SungaiState {
  const LoadedListSungai({required this.listSungai});

  final List<Sungai> listSungai;

  @override
  List<Object> get props => [listSungai];
}

class GettingDataSungai extends SungaiState {
  const GettingDataSungai();
}

class LoadedDataSungai extends SungaiState {
  const LoadedDataSungai({required this.dataSungai});

  final Sungai dataSungai;

  @override
  List<Object> get props => [dataSungai];
}

class GettingDataRealtimeSensor extends SungaiState {
  const GettingDataRealtimeSensor();
}

class LoadedDataRealtimeSensor extends SungaiState {
  const LoadedDataRealtimeSensor({required this.dataSensor});

  final DataSensor dataSensor;

  @override
  List<Object> get props => [dataSensor];
}

class GettingDataHistorySensor extends SungaiState {
  const GettingDataHistorySensor();
}

class LoadedDataHistorySensor extends SungaiState {
  const LoadedDataHistorySensor({required this.dataHistory});

  final List<DataHistory> dataHistory;
}
