import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'providers/competition_provider.dart';
import 'screens/competition_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => CompetitionProvider(),
      child: const OrukamApp(),
    ),
  );
}

class OrukamApp extends StatelessWidget {
  const OrukamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orukam',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const CompetitionScreen(),
    );
  }
}
