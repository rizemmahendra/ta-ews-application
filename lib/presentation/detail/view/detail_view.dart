// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta_ews_application/presentation/bloc/sungai_bloc.dart';
import 'package:ta_ews_application/presentation/detail/widget/line_chart.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    // log(context.read<SungaiBloc>().selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: [
        GestureDetector(
          onTap: () {
            showDatePicker(
                    context: context,
                    firstDate: DateTime(2024, 1, 17),
                    currentDate: DateTime.now(),
                    initialDate:
                        DateTime.parse(context.read<SungaiBloc>().selectedDate),
                    lastDate: DateTime.now())
                .then((value) {
              if (value != null) {
                String date = value.toString().substring(0, 10);
                context.read<SungaiBloc>().selectedDate = date;
                context
                    .read<SungaiBloc>()
                    .add(GetDataHistorySensor('axBPVZsdXUAjFyWOlXnt', date));
              }
            });
          },
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.25)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(context.watch<SungaiBloc>().selectedDate),
              const Text(
                'Tap Untuk Menganti Tanggal',
                style: TextStyle(fontSize: 10),
              )
            ]),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.25)),
          child: Column(children: [
            const Text(
              'Grafik Ketinggian Air',
              style: TextStyle(color: Colors.white),
            ),
            Container(
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: const LineChartWaterLevelWidget(),
            )
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.25)),
          child: Column(children: [
            const Text(
              'Grafik Kekeruhan Air',
              style: TextStyle(color: Colors.white),
            ),
            Container(
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: const LineChartTurbidityWidget(),
            )
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.25)),
          child: Column(children: [
            const Text(
              'Grafik Intensitas Hujan',
              style: TextStyle(color: Colors.white),
            ),
            Container(
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: const LineChartRainWidget(),
            )
          ]),
        )
      ]),
    );
  }
}
