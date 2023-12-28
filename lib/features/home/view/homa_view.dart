import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ta_ews_application/core.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    // DatabaseReference ref = FirebaseDatabase.instance.ref();
    // ref.child('river_location').onValue.listen((event) {
    //   final data = event.snapshot.value;
    //   if (kDebugMode) {
    //     print(data);
    //   }
    // });
  }

  void readData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('jarak').get();
    if (snapshot.exists) {
      if (kDebugMode) {
        print(snapshot.value);
      }
    } else {
      if (kDebugMode) {
        print('No data available.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: readData,
        child: const Text('tekan'),
      ),
    );
  }
}
