// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ta_ews_application/features/home/view/card_widget.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final List<CardWidget> listData = [CardWidget(), CardWidget(), CardWidget()];

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: ListView(children: [CardWidget(), CardWidget(), CardWidget()]),
      child: ListView.builder(
          itemCount: listData.length,
          itemBuilder: ((context, index) {
            return listData[index];
          })),
    );
  }
}
