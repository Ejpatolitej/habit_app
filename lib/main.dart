import 'package:flutter/material.dart';
import 'package:Happit/routes/habit_tracker.dart';
import 'package:Happit/routes/todo.dart';
import 'package:Happit/themes/darkPurple.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox('Habit_Database');
  await Hive.openBox('Todo_Database');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.dark_purple(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/habit_tracker',
      routes: {
        '/habit_tracker':(context) => const HabitTracker(),
        '/todo':(context) => const Todo(),
      },
    );
  }
}
