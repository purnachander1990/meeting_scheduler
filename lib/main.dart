import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meeting_scheduler/models/meeting_data.dart';
import 'package:meeting_scheduler/screens/scheduler_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MeetingData(),
      child: MaterialApp(
        title: 'Meeting Scheduler',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Inter',
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Color(0xFF333333)),
            bodyMedium: TextStyle(color: Color(0xFF666666)),
          ),
        ),
        home: const SchedulerScreen(),
      ),
    );
  }
}