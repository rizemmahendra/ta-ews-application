// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  CardWidget({
    super.key,
  });

  final TextStyle titleStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w800);

  final TextStyle subTitleStyle = TextStyle(
      color: Colors.white,
      fontFamily: 'Nunito',
      fontSize: 12,
      fontWeight: FontWeight.w600);

  final TextStyle dataStyle = TextStyle(
      color: Colors.white, fontSize: 48, fontFamily: 'Berlin Sans FB');

  final TextStyle dataUnitStyle =
      TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600);

  final String title = "Ketinggian Air";

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.3),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
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
                    child: Row(
                      children: [
                        Expanded(child: Image.asset('assets/images/water.png')),
                        Expanded(
                            child: dispalyData(
                                title: 'Node 1',
                                data: 10,
                                satuan: 'CM',
                                status: 'Tinggi')),
                        Expanded(
                            child: dispalyData(
                                title: 'Node 2',
                                data: 6,
                                satuan: 'CM',
                                status: 'Sedang')),
                      ],
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
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
    ]);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     color: Colors.amber,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(children: [
  //         Text('Ketinggian Air', style: titleStyle),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Expanded(
  //               flex: 1,
  //               child: Container(
  //                 decoration: setColor(Colors.red),
  //                 child: Image.asset('assets/images/water.png'),
  //               ),
  //             ),
  //             Expanded(
  //               flex: 1,
  //               child: Container(
  //                 decoration: setColor(Colors.blue),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Node 1',
  //                       textAlign: TextAlign.center,
  //                       style: subTitleStyle,
  //                     ),
  //                     RichText(
  //                         text: TextSpan(
  //                             text: '10',
  //                             style: dataStyle,
  //                             children: <TextSpan>[
  //                           TextSpan(text: 'CM', style: dataUnitStyle)
  //                         ])),
  //                     Container(
  //                       decoration: BoxDecoration(color: Colors.red),
  //                       child: Text(
  //                         'status',
  //                         style: TextStyle(
  //                             color: Colors.black.withOpacity(0.6),
  //                             fontFamily: 'Nunito',
  //                             fontSize: 10,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                     ),
  //                     Text(
  //                       'Tinggi',
  //                       style: TextStyle(
  //                           fontFamily: 'Nunito',
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.w600),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               flex: 1,
  //               child: Container(
  //                 decoration: BoxDecoration(color: Colors.green),
  //                 child: Column(
  //                   children: [
  //                     Text(
  //                       'Node 2',
  //                       style: subTitleStyle,
  //                     ),
  //                     RichText(
  //                         text: TextSpan(
  //                             text: '6',
  //                             style: dataStyle,
  //                             children: <TextSpan>[
  //                           TextSpan(text: 'CM', style: dataUnitStyle)
  //                         ])),
  //                     Text('status'),
  //                     Text('Sedang')
  //                   ],
  //                 ),
  //               ),
  //             )
  //           ],
  //         )
  //       ]),
  //     ),
  //   );
  // }
}
