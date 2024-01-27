import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CallCardWidget extends StatelessWidget {
  const CallCardWidget(
      {super.key,
      required this.number,
      required this.name,
      required this.imageName});

  final String name;
  final String number;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FlutterPhoneDirectCaller.callNumber(number),
        child: Card(
            color: Colors.white.withOpacity(0.3),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.all(10),
            child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Stack(children: [
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/bg1.png'),
                            fit: BoxFit.contain,
                            alignment: Alignment.bottomRight)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: 10,
                            top: 27.5,
                            child: Image(
                                width: 60,
                                height: 60,
                                image: AssetImage('assets/images/$imageName')),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                number,
                                style: const TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'Tap for Call',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ]))));
  }
}
