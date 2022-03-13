import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:mosalla/model/prayer_data.dart';

class PrayerTime extends StatelessWidget {
  final PrayerData prayerData;
  final int activePrayer;

  const PrayerTime({
    Key? key,
    required this.prayerData,
    required this.activePrayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                  tileColor: activePrayer == 0 ? Colors.teal[100] : null,
                  title: const Text('الفجر Fajr'),
                  trailing: Text(prayerData.fajr is String
                      ? '- -'
                      : DateFormat.Hm().format(prayerData.fajr.toDate()))),
              ListTile(
                  tileColor: activePrayer == 1 ? Colors.teal[100] : null,
                  title: const Text('لظهر Duhr'),
                  trailing: Text(prayerData.duhr is String
                      ? '- -'
                      : DateFormat.Hm().format(prayerData.duhr.toDate()))),
              ListTile(
                  tileColor: activePrayer == 2 ? Colors.teal[100] : null,
                  title: const Text('لعصر Asr'),
                  trailing: Text(prayerData.asr is String
                      ? '- -'
                      : DateFormat.Hm().format(prayerData.asr.toDate()))),
              ListTile(
                  tileColor: activePrayer == 3 ? Colors.teal[100] : null,
                  title: const Text('المغرب Maghrib'),
                  trailing: Text(prayerData.maghrib is String
                      ? '- -'
                      : DateFormat.Hm().format(prayerData.maghrib.toDate()))),
              ListTile(
                  tileColor: activePrayer == 4 ? Colors.teal[100] : null,
                  title: const Text('العشاء Isha'),
                  trailing: Text(prayerData.isha is String
                      ? '- -'
                      : DateFormat.Hm().format(prayerData.isha.toDate()))),
            ],
          ),
        ));
  }
}
