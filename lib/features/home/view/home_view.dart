// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ta_ews_application/features/home/widget/rain_widget.dart';
import 'package:ta_ews_application/features/home/widget/turbidity_widget.dart';
import 'package:ta_ews_application/features/home/widget/water_widget.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final List<Widget> listData = [
    WaterCardWidget(),
    TurbidityCardWidget(),
    RainCardWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: listData.length,
          itemBuilder: ((context, index) {
            return listData[index];
          })),
    );
  }
}
