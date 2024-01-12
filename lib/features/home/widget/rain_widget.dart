import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta_ews_application/features/home/bloc/data_sungai_bloc.dart';

class RainCardWidget extends StatelessWidget {
  const RainCardWidget({
    super.key,
  });

  final TextStyle titleStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w800);

  final TextStyle subTitleStyle = const TextStyle(
      color: Colors.white,
      fontFamily: 'Nunito',
      fontSize: 12,
      fontWeight: FontWeight.w600);

  final TextStyle dataStyle = const TextStyle(
      color: Colors.white, fontSize: 48, fontFamily: 'Berlin Sans FB');

  final TextStyle dataUnitStyle = const TextStyle(
      color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600);

  final String title = "Intensitas Hujan";

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.3),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        height: 160,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg1.png'),
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomRight)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      title,
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<DataSungaiBloc, DataSungaiState>(
                      buildWhen: (previous, current) {
                        if (current is DataSungaiInitial) return true;
                        if (current is LoadedDataSensor) return true;
                        return false;
                      },
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                                child: SizedBox(
                              height: 100,
                              child:
                                  Image.asset('assets/images/Rain cloud.png'),
                            )),
                            Expanded(
                                child: dispalyData(
                                    title: 'Node 1',
                                    data: state is LoadedDataSensor
                                        ? state.dataSensor.valueHujanNode1
                                        : 0,
                                    satuan: 'mm/hour',
                                    status: state is LoadedDataSensor
                                        ? state.dataSensor.statusHujanNode1
                                        : 'null')),
                            Expanded(
                                child: dispalyData(
                                    title: 'Node 2',
                                    data: state is LoadedDataSensor
                                        ? state.dataSensor.valueHujanNode2
                                        : 0,
                                    satuan: 'mm/hour',
                                    status: state is LoadedDataSensor
                                        ? state.dataSensor.statusHujanNode2
                                        : 'null')),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column dispalyData(
      {required String title,
      required int data,
      required String satuan,
      required String status}) {
    return Column(children: [
      SizedBox(
        width: double.infinity,
        child: Text(
          title,
          style: subTitleStyle,
          textAlign: TextAlign.center,
        ),
      ),
      RichText(
          text: TextSpan(
              text: data.toString(),
              style: dataStyle,
              children: <TextSpan>[
            TextSpan(text: satuan, style: dataUnitStyle)
          ])),
      Text(
        'status',
        style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontFamily: 'Nunito',
            fontSize: 10,
            fontWeight: FontWeight.w600),
      ),
      Text(
        status,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
    ]);
  }
}
