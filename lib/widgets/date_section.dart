import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meeting_scheduler/models/meeting_data.dart';

/// A widget that displays the date selection section.
/// Includes month navigation, weekday headers, and a calendar grid.
class DateSection extends StatelessWidget {
  const DateSection({super.key});

  @override
  Widget build(BuildContext context) {
    final meetingData = Provider.of<MeetingData>(context);
    final calendarDays = meetingData.getCalendarDays();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Section title
          const Text(
            '2. DATE',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),

          /// Month navigation (previous, current, next)
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Previous month button
                  GestureDetector(
                    onTap: meetingData.previousMonth,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F6F8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.chevron_left, color: Colors.grey, size: 20),
                    ),
                  ),

                  /// Current month name
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      meetingData.getCurrentMonthName(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  /// Next month button
                  GestureDetector(
                    onTap: meetingData.nextMonth,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F6F8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// Weekday headers (SUN - SAT)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              WeekdayHeader(day: 'SUN'),
              WeekdayHeader(day: 'MON'),
              WeekdayHeader(day: 'TUE'),
              WeekdayHeader(day: 'WED'),
              WeekdayHeader(day: 'THU'),
              WeekdayHeader(day: 'FRI'),
              WeekdayHeader(day: 'SAT'),
            ],
          ),

          const SizedBox(height: 8),

          /// Calendar grid with selectable days
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: calendarDays.length,
            itemBuilder: (context, index) {
              final day = calendarDays[index];
              if (day == null) {
                return const SizedBox();
              }

              final now = DateTime.now();
              final threeMonthsLater = DateTime(now.year, now.month + 3, now.day);

              final isToday = day.year == now.year &&
                  day.month == now.month &&
                  day.day == now.day;

              final isSelected = day.year == meetingData.selectedDate.year &&
                  day.month == meetingData.selectedDate.month &&
                  day.day == meetingData.selectedDate.day;

              final isPast = day.isBefore(DateTime(now.year, now.month, now.day));
              final isInCurrentMonth = day.month == meetingData.currentMonth.month;
              final isBeyondThreeMonths = day.isAfter(threeMonthsLater);
              final isDisabled = isPast || isBeyondThreeMonths;

              return GestureDetector(
                onTap: isDisabled ? null : () => meetingData.selectDate(day),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      day.day.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isToday ? FontWeight.w600 : FontWeight.w500,
                        color: isDisabled
                            ? Colors.grey.shade400
                            : (isSelected
                            ? Colors.white
                            : (isInCurrentMonth
                            ? Colors.black
                            : Colors.grey.shade400)),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// A reusable widget to display a weekday label (e.g., MON, TUE).
class WeekdayHeader extends StatelessWidget {
  final String day;

  const WeekdayHeader({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: Text(
        day,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
          color: Colors.grey.shade600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
