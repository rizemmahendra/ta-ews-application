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
                  color: data.levelDanger == "W" ? Colors.red : Colors.amber,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: Center(
                  child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(data.levelDanger == "W" ? "Waspada" : "Siaga",
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
                Text("Node ${data.node}"),
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
                                width: 20,
                              ),
                              Text(
                                "${data.valueWaterLevel} CM",
                                style: const TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/Vector.png',
                                width: 15,
                              ),
                              Text(
                                "${data.valueWaterTurbidity} NTU",
                                style: const TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/Rain cloud.png',
                                width: 20,
                              ),
                              Text(
                                "${data.valueRainIntensity} mm",
                                style: const TextStyle(fontSize: 20),
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
