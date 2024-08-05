import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guru_booking/auth/login.dart';
import 'package:guru_booking/firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.blue, foregroundColor: Colors.white),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.shifting,
            unselectedItemColor: Color.fromARGB(255, 52, 52, 52),
            backgroundColor: Colors.red,
            selectedItemColor: Colors.blue),
        appBarTheme: const AppBarTheme(
            surfaceTintColor: Colors.white,
            shadowColor: Colors.black,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
            backgroundColor: Colors.blue,
            iconTheme: IconThemeData(color: Colors.white)),
        scaffoldBackgroundColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            fillColor: const Color.fromARGB(255, 230, 230, 230),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none))),
    title: 'Guru Booking',
    home: const SafeArea(child: Login()),
  ));
}