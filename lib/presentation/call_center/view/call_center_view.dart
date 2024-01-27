import 'package:flutter/material.dart';
import 'package:ta_ews_application/presentation/call_center/widget/call_card_widget.dart';

class CallCenterPage extends StatelessWidget {
  CallCenterPage({super.key});

  final List<Widget> listWidget = [
    const CallCardWidget(
      name: 'Badan Nasional Penanggulangan Bencana',
      number: '123',
      imageName: 'bnpb.png',
    ),
    const CallCardWidget(
      name: 'Kepolisian Republik Indonesia',
      number: '911',
      imageName: 'polri.png',
    ),
    const CallCardWidget(
      name: 'Ambulance',
      number: '111',
      imageName: 'ambulance.png',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: listWidget.length,
          itemBuilder: ((context, index) {
            return listWidget[index];
          })),
    );
  }
}
