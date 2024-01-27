import 'package:flutter/material.dart';
import 'package:ta_ews_application/presentation/home/widget/home_widget.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final List<Widget> listData = [
    const StatusNodeWidget(),
    const WaterCardWidget(),
    const TurbidityCardWidget(),
    const RainCardWidget()
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
