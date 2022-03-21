import 'package:cloud_firestore/cloud_firestore.dart';

class PrayerData {
  final String id;
  final DateTime? fajr;
  final DateTime? duhr;
  final DateTime? asr;
  final DateTime? maghrib;
  final DateTime? isha;
  final DateTime? jumma;
  final String? date;
  DateTime? sunrise;

  PrayerData({
    required this.id,
    this.fajr,
    this.duhr,
    this.asr,
    this.maghrib,
    this.isha,
    this.jumma,
    this.date,
    this.sunrise,
  });

  factory PrayerData.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      return PrayerData(id: '');
    }
    final Timestamp? fajr = data['Fajr'];
    final Timestamp? duhr = data['Duhr'];
    final Timestamp? asr = data['Asr'];
    final Timestamp? maghrib = data['Maghrib'];
    final Timestamp? isha = data['Isha'];
    final Timestamp? jumma = data['Jumma'];
    final String? date = data['Date'];

    return PrayerData(
      id: doc.id,
      fajr: fajr?.toDate(),
      duhr: duhr?.toDate(),
      asr: asr?.toDate(),
      maghrib: maghrib?.toDate(),
      isha: isha?.toDate(),
      jumma: jumma?.toDate(),
      date: date,
    );
  }
}
