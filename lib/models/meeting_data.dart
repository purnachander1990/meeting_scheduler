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
    TimeSlot(time: '8:30 PM'),
    TimeSlot(time: '8:45 PM'),
    TimeSlot(time: '9:00 PM'),
    TimeSlot(time: '9:15 PM'),
    TimeSlot(time: '9:30 PM'),
    TimeSlot(time: '9:45 PM'),
    TimeSlot(time: '10:00 PM'),
    TimeSlot(time: '10:15 PM'),
    TimeSlot(time: '10:30 PM'),
    TimeSlot(time: '10:45 PM'),
    TimeSlot(time: '11:00 PM'),
    TimeSlot(time: '11:15 PM'),
    TimeSlot(time: '11:30 PM'),
    TimeSlot(time: '11:45 PM'),


  ];

  // Selected states
  int selectedDurationIndex = 0;
  TimeSlot? selectedTimeSlot;
  String currentTimezone = '(-05:00) EST - NEW YORK TIME';

  /// Returns a list of 35–42 days to populate the calendar grid for the current month.
  List<DateTime> getCalendarDays() {
    List<DateTime> days = [];

    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);

    int startWeekday = firstDayOfMonth.weekday % 7;

    DateTime prevMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1);
    int daysInPrevMonth = DateTime(prevMonth.year, prevMonth.month + 1, 0).day;

    for (int i = 0; i < startWeekday; i++) {
      days.add(DateTime(prevMonth.year, prevMonth.month, daysInPrevMonth - startWeekday + i + 1));
    }

    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      days.add(DateTime(currentMonth.year, currentMonth.month, i));
    }

    int remainingSlots = 35 - days.length;
    DateTime nextMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);

    for (int i = 0; i < remainingSlots; i++) {
      days.add(DateTime(nextMonth.year, nextMonth.month, i + 1));
    }

    return days;
  }

  /// Returns the number of days in the given month and year.
  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  /// Returns the current month name in uppercase format.
  String getCurrentMonthName() {
    return DateFormat('MMMM').format(currentMonth).toUpperCase();
  }

  /// Moves the calendar to the next month (max 3 months ahead of current date).
  void nextMonth() {
    final now = DateTime.now();
    final maxDate = DateTime(now.year, now.month + 3, 1);

    final next = DateTime(currentMonth.year, currentMonth.month + 1, 1);
    if (next.isAfter(maxDate)) {
      return;
    }

    currentMonth = next;
    notifyListeners();
  }

  /// Moves the calendar to the previous month (not before current date).
  void previousMonth() {
    final now = DateTime.now();
    final previousMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1);

    if (previousMonth.year < now.year ||
        (previousMonth.year == now.year && previousMonth.month < now.month)) {
      return;
    }

    currentMonth = previousMonth;
    notifyListeners();
  }

  /// Selects a specific date from the calendar.
  void selectDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  /// Selects a duration option for the meeting.
  void selectDuration(int index) {
    selectedDurationIndex = index;
    notifyListeners();
  }

  /// Selects a time slot for the meeting.
  void selectTimeSlot(TimeSlot timeSlot) {
    selectedTimeSlot = timeSlot;
    notifyListeners();
  }

  /// Clears the selected time slot (e.g., when canceled).
  void clearSelection() {
    selectedTimeSlot = null;
    notifyListeners();
  }

  /// Confirms the booking and prints it to console.
  void confirmBooking() {
    print('Booking confirmed for ${durationOptions[selectedDurationIndex].minutes} minutes on ${DateFormat('MMMM d').format(selectedDate)} at ${selectedTimeSlot?.time}');
    clearSelection();
  }

  /// Updates the currently selected timezone.
  void setTimezone(String timezone) {
    currentTimezone = timezone;
    notifyListeners();
  }

  /// Returns whether a time slot is selected and ready for confirmation.
  bool isConfirmationVisible() {
    return selectedTimeSlot != null;
  }

  /// Returns the selected date in a formatted string (e.g., "MONDAY, APRIL 21").
  String getFormattedDate() {
    return DateFormat('EEEE, MMMM d').format(selectedDate).toUpperCase();
  }
}
