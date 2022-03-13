import 'package:cloud_firestore/cloud_firestore.dart';

class PrayerData {
  final String id;
  final dynamic fajr;
  final dynamic duhr;
  final dynamic asr;
  final dynamic maghrib;
  final dynamic isha;
  final String? date;

  PrayerData({
    required this.id,
    required this.fajr,
    required this.duhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.date,
  });

  factory PrayerData.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw 'Error creating PrayerData from null';
      return PrayerData(
        id: '',
        fajr: '',
        duhr: '',
        asr: '',
        maghrib: '',
        isha: '',
        date: '',
      );
    }
    final dynamic fajr = data['Fajr'];
    final dynamic duhr = data['Duhr'];
    final dynamic asr = data['Asr'];
    final dynamic maghrib = data['Maghrib'];
    final dynamic isha = data['Isha'];
    final String? date = data['Date'];

    return PrayerData(
      id: doc.id,
      fajr: fajr,
      duhr: duhr,
      asr: asr,
      maghrib: maghrib,
      isha: isha,
      date: date,
    );
  }
}
