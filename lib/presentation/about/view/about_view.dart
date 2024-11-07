// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Aplikasi Peringatan Dini Banjir Bandang",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Aplikasi ini merupakan aplikasi peringatan dini banjir bandang. aplikasi ini menampilkan informasi tentang kondisi sungai seperti ketinggian air, kekeurhan air dan intensitas hujan di sekitar sungai. selain itu aplikasi dapat memberikan notifikasi jika keadaan sungai dalam status siaga dan waspada",
              style: TextStyle(),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "CREDIT",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Table(
              defaultColumnWidth: IntrinsicColumnWidth(),
              columnWidths: {1: FixedColumnWidth(20)},
              children: [
                TableRow(children: [
                  Text("Design UI/UX"),
                  Center(child: Text(":")),
                  Text("Rizem Mahendra")
                ]),
                TableRow(children: [
                  Text("Android Developer"),
                  Center(child: Text(":")),
                  Text("Rizem Mahendra")
                ]),
                TableRow(children: [
                  Text("Logo Designer"),
                  Center(child: Text(":")),
                  Text("M. Jihad Yuyan")
                ]),
              ],
            )
          ],
        ));
  }
}
