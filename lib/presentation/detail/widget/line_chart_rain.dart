import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta_ews_application/constant.dart';
import 'package:ta_ews_application/presentation/bloc/sungai_bloc.dart';

class LineChartRainWidget extends StatelessWidget {
  const LineChartRainWidget({super.key});

  int interval(int max) {
    if (max < 10) return 1;
    if (max < 20) return 2;
    if (max < 30) return 5;
    if (max < 40) return 10;
    return 10;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SungaiBloc, SungaiState>(
      buildWhen: (previous, current) {
        if (current is LoadedDataHistorySensor) return true;
        return false;
      },
      builder: (context, state) {
        if (state is LoadedDataHistorySensor) {
          return LineChart(LineChartData(
              minX: 0,
              maxX: state.dataHistory.key.length.toDouble() + 1,
              minY: 0,
              maxY: state.dataHistory.maxValueRain.toDouble() +
                  interval(state.dataHistory.maxValueRain),
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                drawVerticalLine: true,
                horizontalInterval:
                    interval(state.dataHistory.maxValueRain).toDouble(),
                verticalInterval: 1,
                getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.5), strokeWidth: 1),
                getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.5), strokeWidth: 1),
              ),
              backgroundColor: Colors.transparent,
              titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                      axisNameWidget: const Text(
                        'Jam',
                        style: TextStyle(color: Colors.white),
                      ),
                      sideTitles: SideTitles(
                          getTitlesWidget: (value, meta) {
                            late String text;
                            TextStyle style =
                                const TextStyle(color: Colors.white);
                            try {
                              text = state.dataHistory.key[value.toInt() - 1];
                            } catch (e) {
                              text = '';
                            }

                            return Text(
                              text,
                              style: style,
                              textScaler: const TextScaler.linear(.60),
                              textAlign: TextAlign.center,
                            );
                          },
                          showTitles: true,
                          reservedSize: 10,
                          interval: 1)),
                  leftTitles: AxisTitles(
                      axisNameWidget: const Text(
                        'Intensitas Hujan(mm/hour)',
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                      axisNameSize: 20,
                      sideTitles: SideTitles(
                          getTitlesWidget: (value, meta) {
                            late String text;
                            TextStyle style =
                                const TextStyle(color: Colors.white);
                            if (value %
                                        interval(
                                            state.dataHistory.maxValueRain) ==
                                    0 &&
                                value.toInt() != 0) {
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
                          },
                          showTitles: true,
                          reservedSize: 15,
                          interval: 1))),
              borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.white.withOpacity(0.5))),
              // maxY: 10 + 1,
              lineBarsData: [
                LineChartBarData(
                    spots: state.dataHistory.valueRainNode1
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble() + 1, e.value))
                        .toList(),
                    isCurved: true,
                    barWidth: 2,
                    color: Constant.orange),
                LineChartBarData(
                    spots: state.dataHistory.valueRainNode2
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble() + 1, e.value))
                        .toList(),
                    isCurved: true,
                    barWidth: 2,
                    color: Colors.red),
              ]));
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
