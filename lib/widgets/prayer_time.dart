import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:mosalla/model/prayer_data.dart';

class PrayerTime extends StatelessWidget {
  final PrayerData prayerData;
  final int? activePrayer;

  const PrayerTime({
    Key? key,
    required this.prayerData,
    required this.activePrayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
              tileColor: activePrayer != null && activePrayer == 0
                  ? Colors.teal[100]
                  : null,
              leading: const Text('الفجر '),
              title: const Text('Fajr'),
              trailing: Text(prayerData.fajr == null
                  ? '- -'
                  : DateFormat.Hm().format(prayerData.fajr!))),
          ListTile(
              tileColor: activePrayer != null && activePrayer == 1
                  ? Colors.teal[100]
                  : null,
              leading: const Text('الشروق'),
              title: const Text('Sunrise'),
              trailing: Text(prayerData.sunrise == null
                  ? '- -'
                  : DateFormat.Hm().format(prayerData.sunrise!))),
          ListTile(
              tileColor: activePrayer != null && activePrayer == 1
                  ? Colors.teal[100]
                  : null,
              leading: const Text('لظهر'),
              title: const Text('Duhr'),
              trailing: Text(prayerData.duhr == null
                  ? '- -'
                  : DateFormat.Hm().format(prayerData.duhr!))),
          ListTile(
              tileColor: activePrayer != null && activePrayer == 2
                  ? Colors.teal[100]
                  : null,
              leading: const Text('لعصر'),
              title: const Text('Asr'),
              trailing: Text(prayerData.asr == null
                  ? '- -'
                  : DateFormat.Hm().format(prayerData.asr!))),
          ListTile(
              tileColor: activePrayer != null && activePrayer == 3
                  ? Colors.teal[100]
                  : null,
              leading: const Text('المغرب'),
              title: const Text('Maghrib'),
              trailing: Text(prayerData.maghrib == null
                  ? '- -'
                  : DateFormat.Hm().format(prayerData.maghrib!))),
          ListTile(
              tileColor: activePrayer != null && activePrayer == 4
                  ? Colors.teal[100]
                  : null,
              leading: const Text('العشاء'),
              title: const Text('Isha'),
              trailing: Text(prayerData.isha == null
                  ? '- -'
                  : DateFormat.Hm().format(prayerData.isha!))),
          ListTile(
              leading: const Text('الجمعة'),
              title: const Text('Jumu‘ah'),
              trailing: Text(prayerData.jumma == null
                  ? '- -'
                  : DateFormat.Hm().format(prayerData.jumma!))),        
        ],
      ),
    );
  }
}
