import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mosalla/providers/prayer_time_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'pages/prayer_time_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context)
                  .textTheme // If this is not set, then ThemeData.light().textTheme is used.
              )),
      home: ChangeNotifierProvider(
          create: (_) => PrayerTimeProvider(), child: const PrayerTimePage()),
    );
  }
}
