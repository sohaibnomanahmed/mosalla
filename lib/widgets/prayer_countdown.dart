import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class PrayerCountDown extends StatelessWidget {
  final DateTime endTime;
  const PrayerCountDown({ Key? key, required this.endTime }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CountdownTimer(
              onEnd: () => print('End'),
              endTime: endTime.millisecondsSinceEpoch,
          ),
      ]
    );
  }
}