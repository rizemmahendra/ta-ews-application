import "package:flutter/material.dart";
import "package:ta_ews_application/domain/entity/data_history.dart";

class HistoryContainer extends StatelessWidget {
  const HistoryContainer({super.key, required this.data});
  final DataHistory data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(10),
      child: Row(children: [
        Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  color:
                      data.levelDanger == "Danger" ? Colors.red : Colors.amber,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: Center(
                  child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(data.levelDanger,
                    style: const TextStyle(fontSize: 20)),
              )),
            )),
        Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Column(children: [
                Text(
                    "Node ${data.node != "Null" ? data.node.substring(data.node.length - 1) : "Null"}"),
                Text(data.datetime),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/water.png',
                                width: 16,
                              ),
                              Text(
                                "${data.valueWaterLevel.toStringAsFixed(2)} CM",
                                style: const TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/Vector.png',
                                width: 15,
                                fit: BoxFit.contain,
                              ),
                              Text(
                                "${data.valueWaterTurbidity.toStringAsFixed(2)} ADC",
                                style: const TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/Rain cloud.png',
                                width: 16,
                              ),
                              Text(
                                "${data.valueRainIntensity.toStringAsFixed(2)} mm",
                                style: const TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        )),
                  ],
                )
              ]),
            ))
      ]),
    );
  }
}
