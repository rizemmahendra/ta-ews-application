import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:ta_ews_application/data/model/data_sensor_model_new.dart';
import 'package:ta_ews_application/data/model/sungai_model.dart';

class FirestoreDataSource implements RemoteDataSource {
  FirestoreDataSource({required FirebaseFirestore instance})
      : _instance = instance;

  final FirebaseFirestore _instance;
  late final ref = _instance.collection("TA EWS RIZEM MAHENDRA");

  @override
  Future<List<SungaiModel>> getListSungai() async {
    final docSnap = await ref
        .withConverter(
          fromFirestore: SungaiModel.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .get();

    List<SungaiModel> listSungai = [];
    for (var doc in docSnap.docs) {
      var data = doc.data();
      listSungai.add(data);
    }

    return listSungai;
  }

  @override
  Future<SungaiModel> getDataSungai({required String idSungai}) async {
    final docSnap = await ref
        .doc(idSungai)
        .withConverter(
          fromFirestore: SungaiModel.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .get();
    final data = docSnap.data();
    return data ?? SungaiModel.empty();
  }

  @override
  Stream<DocumentSnapshot<DataSensorNewModel>> getDataRealtimeSensor(
      {required String idSungai}) {
    return ref
        .doc(idSungai)
        .collection('data_sensor')
        .doc('realtime')
        .withConverter(
          fromFirestore: DataSensorNewModel.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .snapshots();
  }

  @override
  Future<List<DataSensorNewModel>> getHistory(
      {required String idSungai, required String tanggal}) async {
    final docSnap = await ref
        .doc(idSungai)
        .collection('data_sensor')
        .doc('history')
        .collection(tanggal)
        .withConverter(
          fromFirestore: DataSensorNewModel.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .get();
    List<DataSensorNewModel> history = [];
    if (docSnap.docs.isEmpty) return history;
    for (var doc in docSnap.docs) {
      history.add(doc.data());
    }
    return history;
  }

  // Future<void> addHistory() async {
  //   Map<String, dynamic> data = {
  //     'node1': {
  //       'levelDanger': 'aman',
  //       'rainIntensity': 10,
  //       'rainIntensityStatus': 'tidak hujan',
  //       'waterLevel': 0,
  //       'waterLevelStatus': 'rendah',
  //       'waterTurbidity': 0,
  //       'waterTurbidityStatus': 'tidak keruh',
  //     },
  //     'node2': {
  //       'levelDanger': 'aman',
  //       'rainIntensity': 10,
  //       'rainIntensityStatus': 'tidak hujan',
  //       'waterLevel': 0,
  //       'waterLevelStatus': 'rendah',
  //       'waterTurbidity': 0,
  //       'waterTurbidityStatus': 'tidak keruh',
  //     },
  //   };
  //   final docRef = ref
  //       .doc('axBPVZsdXUAjFyWOlXnt')
  //       .collection('data_sensor')
  //       .doc('history')
  //       .collection('2024-01-17')
  //       .doc('04:00');
  //   // ignore: avoid_print
  //   await docRef
  //       .set(data)
  //       .onError((error, stackTrace) => print(error))
  //       .whenComplete(() => print("selesai"));
  // }

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

abstract class RemoteDataSource extends Equatable {
  const RemoteDataSource();

  Future<List<SungaiModel>> getListSungai();
  Future<SungaiModel> getDataSungai({required String idSungai});
  Stream<DocumentSnapshot<DataSensorNewModel>> getDataRealtimeSensor(
      {required String idSungai});
  Future<List<DataSensorNewModel>> getHistory(
      {required String idSungai, required String tanggal});
}
