import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta_ews_application/presentation/bloc/sungai_bloc.dart';

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
      color: Colors.white, fontSize: 40, fontFamily: 'Berlin Sans FB');

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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    child: BlocBuilder<SungaiBloc, SungaiState>(
                      buildWhen: (previous, current) {
                        if (current is SungaiInitial ||
                            current is LoadedDataRealtimeSensor) {
                          return true;
                        }
                        return false;
                      },
                      builder: (context, state) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                    data: state is LoadedDataRealtimeSensor
                                        ? double.parse(state
                                            .dataSensor.node1['rainIntensity']
                                            .toString())
                                        : 0,
                                    satuan: 'mm/hour',
                                    status: state is LoadedDataRealtimeSensor
                                        ? state.dataSensor
                                            .node1['rainIntensityStatus']
                                        : 'null')),
                            Expanded(
                                child: dispalyData(
                                    title: 'Node 2',
                                    data: state is LoadedDataRealtimeSensor
                                        ? double.parse(state
                                            .dataSensor.node2['rainIntensity']
                                            .toString())
                                        : 0,
                                    satuan: 'mm/hour',
                                    status: state is LoadedDataRealtimeSensor
                                        ? state.dataSensor
                                            .node2['rainIntensityStatus']
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
      required double data,
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
      FittedBox(
        fit: BoxFit.scaleDown,
        child: RichText(
            text: TextSpan(
                text: data.toStringAsFixed(2),
                style: dataStyle,
                children: <TextSpan>[
              TextSpan(text: satuan, style: dataUnitStyle)
            ])),
      ),
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
