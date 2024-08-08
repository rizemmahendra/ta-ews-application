import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:ta_ews_application/data/model/data_history_model.dart';
import 'package:ta_ews_application/data/model/data_sensor_model.dart';
import 'package:ta_ews_application/data/model/sungai_model.dart';
import 'package:ta_ews_application/domain/entity/data_history.dart';

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
  Stream<DocumentSnapshot<DataSensorModel>> getDataRealtimeSensor(
      {required String idSungai}) {
    return ref
        .doc(idSungai)
        .collection('data_sensor')
        .doc('realtime')
        .withConverter(
          fromFirestore: DataSensorModel.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .snapshots();
  }

  @override
  Future<List<DataHistory>> getHistory(
      {required String idSungai, required String tanggal}) async {
    final docSnap = await ref
        .doc(idSungai)
        .collection('data_sensor')
        .doc('history')
        .collection("list")
        .withConverter<DataHistoryModel>(
          fromFirestore: DataHistoryModel.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .orderBy("datetime", descending: true)
        .get();

    List<DataHistory> history = [];
    if (docSnap.docs.isEmpty) return history;
    for (var doc in docSnap.docs) {
      history.add(doc.data());
    }

    return history;
  }

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

abstract class RemoteDataSource extends Equatable {
  const RemoteDataSource();

  Future<List<SungaiModel>> getListSungai();
  Future<SungaiModel> getDataSungai({required String idSungai});
  Stream<DocumentSnapshot<DataSensorModel>> getDataRealtimeSensor(
      {required String idSungai});
  Future<List<DataHistory>> getHistory(
      {required String idSungai, required String tanggal});
}
