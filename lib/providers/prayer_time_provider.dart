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
  bool _countDownTomorrow = false;
  int? _activePrayer;
  int? _countDownPrayer;
  PrayerData? _prayerData;
  DateTime? _endTime;
  late DateTime _date;
  StreamSubscription? _subscription;

  // getters
  bool get isLoading => _isLoading;
  bool get isError => _isError;
  bool get countDownTomorrow => _countDownTomorrow;
  int? get activePrayer => _activePrayer;
  int? get countDownPrayer => _countDownPrayer;
  PrayerData? get prayerData => _prayerData;
  DateTime? get endTime => _endTime;
  DateTime get date => _date;

  // methods
  void setActivePrayer(DateTime time) {
    _activePrayer = null;
    if (_prayerData!.fajr != null && time.isAfterTime(_prayerData!.fajr!)){
      _activePrayer = 0;
    }
    if (_prayerData!.sunrise != null && time.isAfterTime(_prayerData!.sunrise!)){
      _activePrayer = 1;
    }
    if (_prayerData!.duhr != null && time.isAfterTime(_prayerData!.duhr!)){
      _activePrayer = 2;
    }
    if (_prayerData!.jumma != null && time.weekday == DateTime.friday && time.isAfterTime(_prayerData!.jumma!)){
      _activePrayer = 6;
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
    debugPrint(_activePrayer.toString());
  }

  void setEndTime(DateTime time) {
    _countDownTomorrow = false;
    _countDownPrayer = null;
    _endTime = null;
    if (_prayerData!.isha != null && time.isBeforeTime(_prayerData!.isha!)){
      _endTime = _prayerData!.isha!;
      _countDownPrayer = 5;
    }
    if (_prayerData!.maghrib != null && time.isBeforeTime(_prayerData!.maghrib!)){
      _endTime = _prayerData!.maghrib!;
      _countDownPrayer = 4;
    }
    if (_prayerData!.asr != null && time.isBeforeTime(_prayerData!.asr!)){
      _endTime = _prayerData!.asr!;
      _countDownPrayer = 3;
    }
    if (_prayerData!.duhr != null && time.isBeforeTime(_prayerData!.duhr!)){
      _endTime = _prayerData!.duhr!;
      _countDownPrayer = 2;
    }
    if (_prayerData!.jumma != null && time.weekday == DateTime.friday && time.isBeforeTime(_prayerData!.jumma!)){
      _endTime = _prayerData!.jumma!;
      _countDownPrayer = 6;
    }
    if (_prayerData!.sunrise != null && time.isBeforeTime(_prayerData!.sunrise!)){
      _endTime = _prayerData!.sunrise!;
      _countDownPrayer = 1;
    }
    if (_prayerData!.fajr != null && time.isBeforeTime(_prayerData!.fajr!)){
      _endTime = _prayerData!.fajr!;
      _countDownPrayer = 0;
    }
    DateTime? lastPrayerTime = lastPrayer();
    if (lastPrayerTime != null && time.isAfterTime(lastPrayerTime)
    ){
      DateTime time = DateTime.now();
      _endTime = DateTime(time.year, time.month, time.day, 23, 59, 59);
      _countDownTomorrow = true;
    }
    debugPrint(_endTime.toString());
  }

  DateTime? lastPrayer(){
    if (_prayerData!.isha != null){
      return _prayerData!.isha!;
    }
    if (_prayerData!.maghrib != null){
      return _prayerData!.maghrib!;
    }
    if (_prayerData!.asr != null){
      return _prayerData!.asr!;
    }
    if (_prayerData!.duhr != null){
      return _prayerData!.duhr!;
    }
    if (_prayerData!.fajr != null){
      return _prayerData!.fajr!;
    }
    return null;
  }

  void updateDisplay(){
    // triggered when countdown finishes, need extra seconds to surpass countdown time
    final time = DateTime.now().add(const Duration(seconds: 10));
    debugPrint('updating');
    setActivePrayer(time);
    setEndTime(time);
    notifyListeners();
  }

  void fetchPrayerTimes() async {
    // when new date is fetched 
    _date = DateTime.now().add(const Duration(seconds: 10));
    final stream = FirebaseFirestore.instance
            .collection('mosalla/MSS/prayer_times')
            .doc(DateFormat('dd-MM-yyyy').format(_date))
            .snapshots()
            .map((doc) => PrayerData.fromFirestore(doc));

    await _subscription?.cancel();
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
        debugPrint('Error: $error');
        _isError = true;
        _isLoading = false;
        notifyListeners();
      },
      cancelOnError: true,
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _subscription?.cancel();
  }
}