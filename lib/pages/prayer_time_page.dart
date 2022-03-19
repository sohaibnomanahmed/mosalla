import 'package:flutter/material.dart';
import 'package:mosalla/providers/prayer_time_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/prayer_countdown.dart';
import '../widgets/prayer_time.dart';

class PrayerTimePage extends StatefulWidget {
  const PrayerTimePage({Key? key}) : super(key: key);

  @override
  State<PrayerTimePage> createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    context.read<PrayerTimeProvider>().fetchPrayerTimes();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (AppLifecycleState.resumed == state) {
      context.read<PrayerTimeProvider>().updateDisplay();
    }
  }

  @override
  Widget build(BuildContext context) {
    final prayerData = context.watch<PrayerTimeProvider>().prayerData;
    final activePrayer = context.watch<PrayerTimeProvider>().activePrayer;
    final countDownPrayer = context.watch<PrayerTimeProvider>().countDownPrayer;
    final endTime = context.watch<PrayerTimeProvider>().endTime;
    final isLoading = context.watch<PrayerTimeProvider>().isLoading;
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("assets/images/bg.jpeg"),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 200,
                        ),
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Text(
                                    countDownPrayer == 0
                                        ? 'Fajr in'
                                        : countDownPrayer == 1
                                            ? 'Sunrise in'
                                            : countDownPrayer == 2
                                                ? 'Duhr in'
                                                : countDownPrayer == 3
                                                    ? 'Asr in'
                                                    : countDownPrayer == 4
                                                        ? 'Maghrib in'
                                                        : countDownPrayer == 5
                                                            ? 'Isha in'
                                                            : 'Mosalla',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor),
                                  ),
                                ),
                                PrayerCountDown(
                                  endTime: endTime,
                                ),
                                // ListTile(
                                //   contentPadding:
                                //       const EdgeInsets.symmetric(horizontal: 0),
                                //   leading: Row(
                                //     mainAxisSize: MainAxisSize.min,
                                //     children: [
                                //       const Icon(Icons.date_range_rounded),
                                //       const SizedBox(width: 10),
                                //       Text(DateFormat.MMMMd().format(date))
                                //     ],
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // StreamBuilder<CompassEvent>(
                    //   stream: FlutterCompass.events,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasError) {
                    //       return Text('Error reading heading: ${snapshot.error}');
                    //     }

                    //     if (snapshot.connectionState == ConnectionState.waiting) {
                    //       return Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     }

                    //     double? direction = snapshot.data!.heading;

                    //     // if direction is null, then device does not support this sensor
                    //     // show error message
                    //     if (direction == null)
                    //       return Center(
                    //         child: Text("Device does not have sensors !"),
                    //       );

                    //     return Material(
                    //       shape: CircleBorder(),
                    //       clipBehavior: Clip.antiAlias,
                    //       elevation: 4.0,
                    //       child: Container(
                    //         padding: EdgeInsets.all(16.0),
                    //         alignment: Alignment.center,
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //         ),
                    //         child: Transform.rotate(
                    //           angle: (direction * (pi / 180) * -1),
                    //           child: Image.asset(
                    //             'assets/images/logo.png',
                    //             height: 150,
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                    // TODO test if no data is added
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: PrayerTime(
                        prayerData: prayerData!,
                        activePrayer: activePrayer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      // bottomNavigationBar: BottomNavigationBar(items: const [
      //   BottomNavigationBarItem(icon: Icon(Icons.label, color: Colors.transparent), label: ''),
      //   BottomNavigationBarItem(icon: Icon(Icons.place_rounded), label: 'UiO Mosalla'),
      //   BottomNavigationBarItem(icon: Icon(Icons.label, color: Colors.transparent), label: '')
      // ]),
    );
  }
}
