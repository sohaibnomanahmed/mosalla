import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunrise_sunset_calc/sunrise_sunset_calc.dart';

import '../model/prayer_data.dart';
import '../extensions/date_extensions.dart';

class PrayerTimeProvider with ChangeNotifier{
  
  bool _isLoading = true;
  bool _isError = false;
  int? _activePrayer;
  PrayerData? _prayerData;
  DateTime? _endTime;
  late final StreamSubscription _subscription;
  bool _correction = false;

  // getters
  bool get isLoading => _isLoading;
  bool get isError => _isError;
  int? get activePrayer => _activePrayer;
  PrayerData? get prayerData => _prayerData;
  DateTime? get endTime => _endTime;

  // methods
  void setActivePrayer(DateTime time) {
    if (_prayerData!.fajr != null && time.isAfterTime(_prayerData!.fajr!)){
      _activePrayer = 0;
    }
    if (_prayerData!.sunrise != null && time.isAfterTime(_prayerData!.sunrise!)){
      _activePrayer = 1;
    }
    if (_prayerData!.duhr != null && time.isAfterTime(_prayerData!.duhr!)){
      _activePrayer = 2;
    }
    if (_prayerData!.asr != null && time.isAfterTime(_prayerData!.asr!)){
      _activePrayer = 3;
    }
    if (_prayerData!.maghrib != null && time.isAfterTime(_prayerData!.maghrib!)){
      _activePrayer = 4;
    }
    if (_prayerData!.isha != null && time.isAfterTime(_prayerData!.isha!)){
      _activePrayer = 5;
    }
    print(_activePrayer);
  }

  void setEndTime(DateTime time) {
    if (_prayerData!.isha != null && time.isBeforeTime(_prayerData!.isha!)){
      _endTime = _prayerData!.isha!;
    }
    if (_prayerData!.maghrib != null && time.isBeforeTime(_prayerData!.maghrib!)){
      _endTime = _prayerData!.maghrib!;
    }
    if (_prayerData!.asr != null && time.isBeforeTime(_prayerData!.asr!)){
      _endTime = _prayerData!.asr!;
    }
    if (_prayerData!.duhr != null && time.isBeforeTime(_prayerData!.duhr!)){
      _endTime = _prayerData!.duhr!;
    }
    if (_prayerData!.fajr != null && time.isBeforeTime(_prayerData!.fajr!)){
      _endTime = _prayerData!.fajr!;
    } 
    print(_endTime);
  }

  void updateDisplay(DateTime time){
    print('updating');
    print(time);
    setActivePrayer(time);
    setEndTime(time);
    print(_activePrayer);
    print(_endTime);
    notifyListeners();
  }

  void fetchPrayerTimes(){
    DateTime date = DateTime.now();
    final stream = FirebaseFirestore.instance
            .collection('mosalla/MSS/prayer_times')
            .doc(DateFormat('dd-MM-yyyy').format(date))
            .snapshots()
            .map((doc) => PrayerData.fromFirestore(doc));
    //TODO need to call this method every day, when new day starts shows old data
    _subscription = stream.listen(
      (prayerData) async {
        // when data is changed needs to update the time
        DateTime time = DateTime.now();
        _prayerData = prayerData;
        //final response = await SunriseSunset.getResults(date: DateTime.now(), latitude: 59.9139, longitude: 10.7522);
        var sunriseSunset = getSunriseSunset(59.9139, 10.7522, 1, time);
        _prayerData!.sunrise = sunriseSunset.sunrise;
        setActivePrayer(time);
        setEndTime(time);

        _isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        print('Error: $error');
        _isError = true;
        _isLoading = false;
        notifyListeners();
      },
      cancelOnError: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}