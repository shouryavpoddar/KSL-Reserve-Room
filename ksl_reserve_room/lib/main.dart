
import 'package:flutter/material.dart';
import 'package:ksl_reserve_room/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Habit Gym",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


