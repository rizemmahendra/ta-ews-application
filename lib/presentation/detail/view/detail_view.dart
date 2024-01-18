// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ta_ews_application/presentation/detail/widget/line_chart.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.25)),
          child: Column(children: [
            Text(
              'Grafik Ketinggian Air',
              style: TextStyle(color: Colors.white),
            ),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.transparent),
              child: LineChartWaterLevelWidget(),
            )
          ]),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.25)),
          child: Column(children: [
            Text(
              'Grafik Kekeruhan Air',
              style: TextStyle(color: Colors.white),
            ),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.transparent),
              child: LineChartTurbidityWidget(),
            )
          ]),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.25)),
          child: Column(children: [
            Text(
              'Grafik Intensitas Hujan',
              style: TextStyle(color: Colors.white),
            ),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.transparent),
              child: LineChartRainWidget(),
            )
          ]),
        )
      ]),
    );
  }
}
