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

class _PrayerTimePageState extends State<PrayerTimePage> {
  @override
  void initState() {
    super.initState();
    context.read<PrayerTimeProvider>().fetchPrayerTimes(DateTime.now());
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
          : isError
              ? const Center(child: Text('No prayer data added for today'))
              : SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      PrayerCountDown(endTime: endTime!),
                      PrayerTime(
                        prayerData: prayerData!,
                        activePrayer: activePrayer!,
                      )
                    ],
                  ),
                ),
    );
  }
}
