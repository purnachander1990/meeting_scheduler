import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Participant {
  final String name;
  final String imageUrl;

  Participant({required this.name, required this.imageUrl});
}

class Duration {
  final int minutes;
  final String description;

  Duration({required this.minutes, required this.description});
}

class TimeSlot {
  final String time;
  final bool isAvailable;

  TimeSlot({required this.time, this.isAvailable = true});
}

class MeetingData extends ChangeNotifier {
  // Participants
  List<Participant> participants = [
    Participant(
      name: 'ANGELO',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIV99IJOGUBMQBy9kccOQsAyq36yzt0BRYUw&s',
    ),
    Participant(
      name: 'KATE',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgu8cvJBA4GB-KIsh8vcTrOR4lHX40DX0a9w&s',
    ),
  ];

  // Duration options
  List<Duration> durationOptions = [
    Duration(
      minutes: 15,
      description: "Let's Connect! Schedule a 15-minute slot for a brief discussion on any topic you'd like – whether it's about a project, brainstorming ideas, or just catching up. Looking forward to connecting with you!",
    ),
    Duration(
      minutes: 30,
      description: "Need more time to discuss a topic in detail? Schedule a 30-minute meeting where we can dive deeper into your ideas, projects, or questions.",
    ),
    Duration(
      minutes: 60,
      description: "For comprehensive discussions, detailed planning, or collaborative work sessions, book a full hour to ensure we have ample time to address all your needs.",
    ),
  ];

  // Calendar data
  DateTime currentMonth = DateTime.now();
  DateTime selectedDate = DateTime.now();

  // Time slots
  List<TimeSlot> timeSlots = [
    TimeSlot(time: '9:30 PM'),
    TimeSlot(time: '9:45 PM'),
    TimeSlot(time: '10:00 PM'),
    TimeSlot(time: '10:15 PM'),
    TimeSlot(time: '10:30 PM'),
    TimeSlot(time: '10:45 PM'),
    TimeSlot(time: '11:00 PM'),
    TimeSlot(time: '11:45 PM'),
    TimeSlot(time: '9:30 PM'),
    TimeSlot(time: '9:45 PM'),
    TimeSlot(time: '10:00 PM'),
    TimeSlot(time: '10:15 PM'),
    TimeSlot(time: '10:30 PM'),
    TimeSlot(time: '10:45 PM'),
    TimeSlot(time: '11:00 PM'),
    TimeSlot(time: '11:45 PM'),
    TimeSlot(time: '9:30 PM'),
    TimeSlot(time: '9:45 PM'),
    TimeSlot(time: '10:00 PM'),
    TimeSlot(time: '10:15 PM'),
    TimeSlot(time: '10:30 PM'),
    TimeSlot(time: '10:45 PM'),
    TimeSlot(time: '11:00 PM'),
    TimeSlot(time: '11:45 PM'),
  ];

  // Selected states
  int selectedDurationIndex = 0;
  TimeSlot? selectedTimeSlot;
  String currentTimezone = '(-05:00) EST - NEW YORK TIME';

  // Get calendar days for current month view
  List<DateTime> getCalendarDays() {
    List<DateTime> days = [];

    // Get first and last day of the current month
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);

    // Weekday adjustment (0 = Sunday, 6 = Saturday)
    int startWeekday = firstDayOfMonth.weekday % 7;

    // Fill leading days from previous month
    DateTime prevMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1);
    int daysInPrevMonth = DateTime(prevMonth.year, prevMonth.month + 1, 0).day;

    for (int i = 0; i < startWeekday; i++) {
      days.add(DateTime(prevMonth.year, prevMonth.month, daysInPrevMonth - startWeekday + i + 1));
    }

    // Fill current month days
    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      days.add(DateTime(currentMonth.year, currentMonth.month, i));
    }

    // Fill trailing days from next month to complete 42-day grid
    int remainingSlots = 35 - days.length;
    DateTime nextMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);

    for (int i = 0; i < remainingSlots; i++) {
      days.add(DateTime(nextMonth.year, nextMonth.month, i + 1));
    }

    return days;
  }


  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  String getCurrentMonthName() {
    return DateFormat('MMMM').format(currentMonth).toUpperCase();
  }

  /*void nextMonth() {
    if (currentMonth.month + 3 > DateTime.now().month + 3 && 
        currentMonth.year >= DateTime.now().year) {
      return; // Don't allow more than 3 months in the future
    }
    
    currentMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
    notifyListeners();
  }*/
  void nextMonth() {
    final now = DateTime.now();
    final maxDate = DateTime(now.year, now.month + 3, 1);

    // If the next month would exceed the max allowed date, block it
    final next = DateTime(currentMonth.year, currentMonth.month + 1, 1);
    if (next.isAfter(maxDate)) {
      return;
    }

    currentMonth = next;
    notifyListeners();
  }

  void previousMonth() {
    final now = DateTime.now();
    final previousMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1);
    
    if (previousMonth.year < now.year || 
        (previousMonth.year == now.year && previousMonth.month < now.month)) {
      return; // Don't allow going before the current month
    }
    
    currentMonth = previousMonth;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void selectDuration(int index) {
    selectedDurationIndex = index;
    notifyListeners();
  }

  void selectTimeSlot(TimeSlot timeSlot) {
    selectedTimeSlot = timeSlot;
    notifyListeners();
  }

  void clearSelection() {
    selectedTimeSlot = null;
    notifyListeners();
  }

  void confirmBooking() {
    // In a real app, this would send data to a backend
    print('Booking confirmed for ${durationOptions[selectedDurationIndex].minutes} minutes on ${DateFormat('MMMM d').format(selectedDate)} at ${selectedTimeSlot?.time}');
    clearSelection();
  }

  void setTimezone(String timezone) {
    currentTimezone = timezone;
    notifyListeners();
  }

  bool isConfirmationVisible() {
    return selectedTimeSlot != null;
  }

  String getFormattedDate() {
    return DateFormat('EEEE, MMMM d').format(selectedDate).toUpperCase();
  }
}