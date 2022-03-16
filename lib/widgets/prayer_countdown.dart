import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class PrayerCountDown extends StatelessWidget {
  final DateTime? endTime;
  final Function onEnd;
  const PrayerCountDown({Key? key, required this.endTime, required this.onEnd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    DateTime? time;
    if (endTime != null) {
      time = DateTime(
          now.year, now.month, now.day, endTime!.hour, endTime!.minute);
    }
    return endTime == null
        ? const Text('No more prayers today')
        : CountdownTimer(
            onEnd: () => onEnd(),
            widgetBuilder: (_, time) => FittedBox(
                child: Text(
                    '${time!.hours}h ${time.min}m ${time.sec}s',
                    style: Theme.of(context).textTheme.headline5)),
            endWidget: const Text('No more prayers today'),
            endTime: time!.millisecondsSinceEpoch,
          );
  }
}
