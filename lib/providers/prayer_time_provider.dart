import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    if (_prayerData!.fajr is! String && time.isAfterTime(_prayerData!.fajr.toDate())){
      _activePrayer = 0;
      _endTime = _prayerData!.duhr.toDate();
    }
    if (_prayerData!.duhr is! String && time.isAfterTime(_prayerData!.duhr.toDate())){
      _activePrayer = 1;
      _endTime = _prayerData!.asr.toDate();
    }
    if (_prayerData!.asr is! String && time.isAfterTime(_prayerData!.asr.toDate())){
      _activePrayer = 2;
      _endTime = _prayerData!.maghrib.toDate();
    }
    if (_prayerData!.maghrib is! String && time.isAfterTime(_prayerData!.maghrib.toDate())){
      _activePrayer = 3;
      _endTime = _prayerData!.isha.toDate();
    }
    if (_prayerData!.isha is! String && time.isAfter(_prayerData!.isha.toDate())){
      _activePrayer = 4;
      _endTime = _prayerData!.duhr.toDate().add(const Duration(days: 1));
    }
    print(_activePrayer);
  }

  void fetchPrayerTimes(DateTime date){
    final stream = FirebaseFirestore.instance
            .collection('mosalla/MSS/prayer_times')
            .doc(DateFormat('dd-MM-yyyy').format(date))
            .snapshots()
            .map((doc) => PrayerData.fromFirestore(doc));
    
    _subscription = stream.listen(
      (prayerData) async {
        _prayerData = prayerData;
        setActivePrayer(date);
        // TODO if after isha get data from tomorrow
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