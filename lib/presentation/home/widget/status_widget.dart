import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta_ews_application/presentation/bloc/sungai_bloc.dart';

class StatusNodeWidget extends StatelessWidget {
  const StatusNodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white.withOpacity(0.3),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.all(10),
        child: SizedBox(
            width: double.infinity,
            height: 75,
            child: Column(
              children: [
                const FittedBox(
                  child: Text('Status Sungai'),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: BlocBuilder<SungaiBloc, SungaiState>(
                    buildWhen: (previous, current) {
                      if (current is LoadedDataRealtimeSensor) return true;
                      return false;
                    },
                    builder: (context, state) {
                      if (state is LoadedDataRealtimeSensor) {
                        var node1 =
                            state.dataSensor.node1['levelDanger'] as String;
                        var node2 =
                            state.dataSensor.node2['levelDanger'] as String;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: node1 == 'sangat bahaya'
                                          ? Colors.red
                                          : node1 == 'bahaya'
                                              ? Colors.amber
                                              : node1 == 'aman'
                                                  ? Colors.green
                                                  : Colors.grey,
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Node 1 :'),
                                    Text(node1.toUpperCase())
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: node2 == 'sangat bahaya'
                                          ? Colors.red
                                          : node2 == 'bahaya'
                                              ? Colors.amber
                                              : node2 == 'aman'
                                                  ? Colors.green
                                                  : Colors.grey,
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Node 2 :'),
                                    Text(node2.toUpperCase())
                                  ],
                                )
                              ],
                            ),
                          ],
                        );
                      }
                      return const Text('No Data');
                    },
                  ),
                )
              ],
            )));
  }
}
