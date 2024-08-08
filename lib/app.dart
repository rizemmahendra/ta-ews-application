import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta_ews_application/core.dart';
import 'package:ta_ews_application/presentation/bloc/sungai_bloc.dart';
import 'package:ta_ews_application/presentation/about/view/about_view.dart';
import 'package:ta_ews_application/presentation/call_center/view/call_center_view.dart';
import 'package:ta_ews_application/presentation/detail/view/detail_view.dart';
import 'package:ta_ews_application/presentation/home/view/home_view.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Widget> pages = [
    Homepage(),
    const DetailPage(),
    CallCenterPage(),
    const AboutPage()
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    String statusNode1 = '';
    String statusNode2 = '';
    String prevStatusNode1 = '';
    String prevStatusNode2 = '';

    return Scaffold(
      backgroundColor: Constant.grey,
      appBar: AppBar(
        elevation: 0,
        title: const FittedBox(fit: BoxFit.fitWidth, child: Constant.appTitle),
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.menu),
        //   onPressed: () {
        //     context.read<SungaiBloc>().add(const GetDataHistorySensor(
        //         'axBPVZsdXUAjFyWOlXnt', '2024-01-17'));
        //   },
        // ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: <Color>[
                    Constant.orange,
                    Constant.grey,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: BlocConsumer<SungaiBloc, SungaiState>(
                  listenWhen: (previous, current) {
                    if (current is LoadedDataRealtimeSensor) return true;
                    return false;
                  },
                  listener: (context, state) {
                    state as LoadedDataRealtimeSensor;
                    statusNode1 = state.dataSensor.node1['levelDanger'];
                    statusNode2 = state.dataSensor.node2['levelDanger'];
                    if (prevStatusNode1 != statusNode1 &&
                            statusNode1 == "bahaya" ||
                        statusNode1 == "sangat bahaya") {
                      // NotificationService.showNotification(
                      //     title: 'Kondisi Node 1 : $statusNode1',
                      //     body: DateTime.now().toString());
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //     content:
                      //         Text('Kondisi Sungai : $statusNode1 di Node 1'),
                      //     backgroundColor: Constant.orange));
                    }
                    if (prevStatusNode2 != statusNode2 &&
                            statusNode2 == "bahaya" ||
                        statusNode2 == "sangat bahaya") {
                      // NotificationService.showNotification(
                      //     title: 'Kondisi Node 2 : $statusNode2',
                      //     body: DateTime.now().toString());
                      // // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //     content:
                      //         Text('Kondisi Sungai : $statusNode2 di Node 2'),
                      //     backgroundColor: Constant.orange));
                    }
                    prevStatusNode1 = statusNode1;
                    prevStatusNode2 = statusNode2;
                  },
                  buildWhen: (previous, current) {
                    if (current is SungaiInitial) return true;
                    if (current is LoadedDataSungai) return true;
                    return false;
                  },
                  builder: (context, state) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 0,
                          child: Text(
                            state is LoadedDataSungai
                                ? state.dataSungai.namaSungai
                                : 'Nama Sungai',
                            style: const TextStyle(
                                fontFamily: 'Nunito',
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Positioned(
                            left: 30,
                            child: Row(
                              children: [
                                const Image(
                                    image: AssetImage(
                                        'assets/images/trail-map.png')),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                    state is LoadedDataSungai
                                        ? state.dataSungai.lokasiSungai
                                        : 'Lokasi Sungai',
                                    style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: 14,
                                    ))
                              ],
                            )),
                        Positioned(
                            right: 30,
                            child: Row(
                              children: [
                                const Image(
                                    image: AssetImage(
                                        'assets/images/location-icon.png')),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                    state is LoadedDataSungai
                                        ? '${state.dataSungai.koordinatSungai?.latitude} S, ${state.dataSungai.koordinatSungai?.longitude} U'
                                        : 'Koordinat Sungai',
                                    style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.white,
                                      fontSize: 14,
                                    ))
                              ],
                            ))
                      ],
                    );
                  },
                ))),
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.list),
                selectedIcon: Icon(Icons.list_alt_outlined),
                label: 'History'),
            NavigationDestination(
                icon: Icon(Icons.call_outlined),
                selectedIcon: Icon(Icons.call),
                label: 'Call Center'),
            NavigationDestination(
                icon: Icon(Icons.info_outline),
                selectedIcon: Icon(Icons.info),
                label: 'About'),
          ]),
      body: IndexedStack(index: _currentIndex, children: pages),
    );
  }
}
