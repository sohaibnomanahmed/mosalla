import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:mosalla/model/prayer_data.dart';
import 'package:mosalla/providers/prayer_time_provider.dart';
import 'package:provider/provider.dart';

class PrayerTime extends StatelessWidget {
  final PrayerData prayerData;
  final int? activePrayer;
  final activeColor = Colors.red[300];

  PrayerTime({
    Key? key,
    required this.prayerData,
    required this.activePrayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ListTile(
          //   leading: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       const Icon(Icons.calendar_month_rounded),
          //       const SizedBox(width: 10),
          //       Text(DateFormat('dd-MM-yyyy').format(date)),
          //     ],
          //   ),
          // ),
          ListTile(
            //dense: true,
            //onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Time left'))),
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.mosque_rounded),
                SizedBox(width: 10),
                Text('Prayers'),
              ],
            ) ,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Jamaat'),
                SizedBox(width: 10),
                Icon(Icons.access_time_outlined),
              ],
            ) 
          ),
          ListTile(
              //dense: true,
              textColor: activePrayer != null && activePrayer == 0 ?Colors.white: null,
              tileColor: activePrayer != null && activePrayer == 0
                  ? activeColor
                  : Colors.teal[50],
              leading: const Text('الفجر'),
              title: const Text('Fajr'),
              trailing: Text(prayerData.fajr == null
                  ? '- -'
                  : DateFormat.Hm().format(prayerData.fajr!))),
          ListTile(
              //dense: true,
              textColor: activePrayer != null && activePrayer == 1 ?Colors.white: null,
              tileColor: activePrayer != null && activePrayer == 1
                  ? activeColor
                  : Colors.teal[100],
              leading: const Text('الشروق'),
              title: const Text('Sunrise'),
              trailing: Text(prayerData.sunrise == null
                  ? '- -'
                  : DateFormat.Hm().format(prayerData.sunrise!))),
          ListTile(
              //dense: true,
              textColor: activePrayer != null && activePrayer == 2 ?Colors.white: null,
              tileColor: activePrayer != null && activePrayer == 2
                  ? activeColor
                  : Colors.teal[50],
              leading: const Text('لظهر'),
              title: const Text('Duhr'),
              trailing: Text(prayerData.duhr == null
                  ? '- -'
                  : DateFormat.Hm().format(prayerData.duhr!))),
          ListTile(
              //dense: true,
              textColor: activePrayer != null && activePrayer == 3 ?Colors.white: null,
              tileColor: activePrayer != null && activePrayer == 3
                  ? activeColor
                  : Colors.teal[100],
              leading: const Text('لعصر'),
              title: const Text('Asr'),
              trailing: Text(prayerData.asr == null
                  ? '- -'
                  : DateFormat.Hm().format(prayerData.asr!))),
          ListTile(
              //dense: true,
              textColor: activePrayer != null && activePrayer == 4 ?Colors.white: null,
              tileColor: activePrayer != null && activePrayer == 4
                  ? activeColor
                  : Colors.teal[50],
              leading: const Text('المغرب'),
              title: const Text('Maghrib'),
              trailing: Text(prayerData.maghrib == null
                  ? '- -'
                  : DateFormat.Hm().format(prayerData.maghrib!))),
          ListTile(
              //dense: true,
              textColor: activePrayer != null && activePrayer == 5 ?Colors.white: null,
              tileColor: activePrayer != null && activePrayer == 5
                  ? activeColor
                  : Colors.teal[100],
              leading: const Text('العشاء'),
              title: const Text('Isha'),
              trailing: Text(prayerData.isha == null
                  ? '- -'
                  : DateFormat.Hm().format(prayerData.isha!))),
          ListTile(
              //dense: true,
              tileColor: Colors.teal[50],
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
