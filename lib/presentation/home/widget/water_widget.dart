import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta_ews_application/presentation/bloc/sungai_bloc.dart';

class WaterCardWidget extends StatelessWidget {
  const WaterCardWidget({
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
      color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600);

  final String title = "Ketinggian Air";

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
                    child: BlocBuilder<SungaiBloc, SungaiState>(
                      buildWhen: (previous, current) {
                        if (current is SungaiInitial) return true;
                        if (current is LoadedDataRealtimeSensor) return true;
                        return false;
                      },
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                                child: Image.asset('assets/images/water.png')),
                            Expanded(
                                child: dispalyData(
                                    title: 'Node 1',
                                    data: state is LoadedDataRealtimeSensor
                                        ? state.dataSensor.node1['waterLevel']
                                        : 0,
                                    satuan: 'CM',
                                    status: state is LoadedDataRealtimeSensor
                                        ? state.dataSensor
                                            .node1['waterLevelStatus']
                                        : 'null')),
                            Expanded(
                                child: dispalyData(
                                    title: 'Node 2',
                                    data: state is LoadedDataRealtimeSensor
                                        ? state.dataSensor.node2['waterLevel']
                                        : 0,
                                    satuan: 'CM',
                                    status: state is LoadedDataRealtimeSensor
                                        ? state.dataSensor
                                            .node2['waterLevelStatus']
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

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Card(
//   //     color: Colors.amber,
//   //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//   //     child: Padding(
//   //       padding: const EdgeInsets.all(8.0),
//   //       child: Column(children: [
//   //         Text('Ketinggian Air', style: titleStyle),
//   //         Row(
//   //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //           crossAxisAlignment: CrossAxisAlignment.center,
//   //           children: [
//   //             Expanded(
//   //               flex: 1,
//   //               child: Container(
//   //                 decoration: setColor(Colors.red),
//   //                 child: Image.asset('assets/images/water.png'),
//   //               ),
//   //             ),
//   //             Expanded(
//   //               flex: 1,
//   //               child: Container(
//   //                 decoration: setColor(Colors.blue),
//   //                 child: Column(
//   //                   crossAxisAlignment: CrossAxisAlignment.start,
//   //                   children: [
//   //                     Text(
//   //                       'Node 1',
//   //                       textAlign: TextAlign.center,
//   //                       style: subTitleStyle,
//   //                     ),
//   //                     RichText(
//   //                         text: TextSpan(
//   //                             text: '10',
//   //                             style: dataStyle,
//   //                             children: <TextSpan>[
//   //                           TextSpan(text: 'CM', style: dataUnitStyle)
//   //                         ])),
//   //                     Container(
//   //                       decoration: BoxDecoration(color: Colors.red),
//   //                       child: Text(
//   //                         'status',
//   //                         style: TextStyle(
//   //                             color: Colors.black.withOpacity(0.6),
//   //                             fontFamily: 'Nunito',
//   //                             fontSize: 10,
//   //                             fontWeight: FontWeight.w600),
//   //                       ),
//   //                     ),
//   //                     Text(
//   //                       'Tinggi',
//   //                       style: TextStyle(
//   //                           fontFamily: 'Nunito',
//   //                           fontSize: 16,
//   //                           fontWeight: FontWeight.w600),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ),
//   //             ),
//   //             Expanded(
//   //               flex: 1,
//   //               child: Container(
//   //                 decoration: BoxDecoration(color: Colors.green),
//   //                 child: Column(
//   //                   children: [
//   //                     Text(
//   //                       'Node 2',
//   //                       style: subTitleStyle,
//   //                     ),
//   //                     RichText(
//   //                         text: TextSpan(
//   //                             text: '6',
//   //                             style: dataStyle,
//   //                             children: <TextSpan>[
//   //                           TextSpan(text: 'CM', style: dataUnitStyle)
//   //                         ])),
//   //                     Text('status'),
//   //                     Text('Sedang')
//   //                   ],
//   //                 ),
//   //               ),
//   //             )
//   //           ],
//   //         )
//   //       ]),
//   //     ),
//   //   );
//   // }
// }
