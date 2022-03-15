import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:mosalla/providers/prayer_time_provider.dart';
import 'package:provider/provider.dart';
import 'dart:math';

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
    context.read<PrayerTimeProvider>().fetchPrayerTimes(DateTime.now());
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
      final date = DateTime.now().add(const Duration(seconds: 10));
      context.read<PrayerTimeProvider>().updateDisplay(date);
    }
    print(state);
  }

  @override
  Widget build(BuildContext context) {
    final prayerData = context.watch<PrayerTimeProvider>().prayerData;
    final activePrayer = context.watch<PrayerTimeProvider>().activePrayer;
    final endTime = context.watch<PrayerTimeProvider>().endTime;
    final isLoading = context.watch<PrayerTimeProvider>().isLoading;
    final isError = context.watch<PrayerTimeProvider>().isError;
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("assets/images/bg.jpg"),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo.png',
                      height: 200,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                          activePrayer == 0
                              ? 'Duhr in: '
                              : activePrayer == 1
                                  ? 'Asr in: '
                                  : activePrayer == 2
                                      ? 'Maghrib in: '
                                      : activePrayer == 3
                                          ? 'Isha in:'
                                          : 'Mosalla',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: Theme.of(context).primaryColor)),
                    ),
                    PrayerCountDown(
                        endTime: endTime,
                        onEnd: () {
                          // I think the date is one second before end time, for safety we add 10 second even thogh 2 should be enough
                          final date =
                              DateTime.now().add(const Duration(seconds: 10));
                          context
                              .read<PrayerTimeProvider>()
                              .updateDisplay(date);
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: isError
                          ? const Center(
                              child: Text('No prayer data added for today'))
                          : PrayerTime(
                              prayerData: prayerData!,
                              activePrayer: activePrayer,
                            ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
