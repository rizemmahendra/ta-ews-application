// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ta_ews_application/constant.dart';

class LineChartWidget extends StatelessWidget {
  LineChartWidget({super.key});

  final List<int> data = [1, 14, 3, 4, 5, 12, 7, 2, 5];
  final Map<String, double> dataSensor = {
    "00:00": 2,
    "01:00": 2,
    "02:00": 5,
    "03:00": 1,
    "04:00": 10,
    "05:00": 4,
    "06:00": 5,
    "07:00": 2,
    "08:00": 9,
    "09:00": 9,
    "10:00": 12,
  };

  late final List<String> dataSensorKey =
      dataSensor.entries.map((e) => e.key).toList();
  late final List<double> dataSensorValue =
      dataSensor.entries.map((e) => e.value).toList();
  int interval() {
    if (dataSensorValue.reduce(max).toInt() < 10) return 1;
    if (dataSensorValue.reduce(max).toInt() < 20) return 2;
    if (dataSensorValue.reduce(max).toInt() < 30) return 5;
    if (dataSensorValue.reduce(max).toInt() < 40) return 10;
    return 15;
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    late String text;
    TextStyle style = TextStyle(color: Colors.white);
    if (value % interval() == 0 && value.toInt() != 0) {
      text = value.toInt().toString();
    } else {
      text = '';
    }

    return Text(
      text,
      style: style,
      textScaler: const TextScaler.linear(.65),
      textAlign: TextAlign.center,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    late String text;
    TextStyle style = TextStyle(color: Colors.white);
    try {
      text = dataSensorKey[value.toInt() - 1];
    } catch (e) {
      text = '';
    }

    return Text(
      text,
      style: style,
      textScaler: const TextScaler.linear(.65),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        minX: 0,
        maxX: dataSensor.length.toDouble() + 1,
        minY: 0,
        maxY: dataSensorValue.reduce(max) + interval(),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          horizontalInterval: interval().toDouble(),
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: Colors.white.withOpacity(0.5), strokeWidth: 1),
          getDrawingVerticalLine: (value) =>
              FlLine(color: Colors.white.withOpacity(0.5), strokeWidth: 1),
        ),
        backgroundColor: Colors.transparent,
        titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                axisNameWidget: Text(
                  'Jam',
                  style: TextStyle(color: Colors.white),
                ),
                sideTitles: SideTitles(
                    getTitlesWidget: bottomTitleWidgets,
                    showTitles: true,
                    reservedSize: 10,
                    interval: 1)),
            leftTitles: AxisTitles(
                axisNameWidget: Text(
                  'Ketinggian Air(cm)',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
                axisNameSize: 20,
                sideTitles: SideTitles(
                    getTitlesWidget: leftTitleWidgets,
                    showTitles: true,
                    reservedSize: 15,
                    interval: 1))),
        borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.white.withOpacity(0.5))),
        // maxY: 10 + 1,
        lineBarsData: [
          LineChartBarData(
              spots: dataSensorValue
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble() + 1, e.value))
                  .toList(),
              isCurved: true,
              barWidth: 2,
              color: Constant.orange),
        ]));
  }
}
