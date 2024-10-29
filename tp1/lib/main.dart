import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:tp1/accueil.dart';
import 'connexion.dart';
import 'inscription.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Connection(),
      /*initialRoute: '/',
      routes: {
        '/': (context) => const Accueil(),
        '/creation': (context) => Creation(onTaskCreated: (task) {}),
        '/main': (context) => const MyApp(),
      },*/
    );
  }
}

