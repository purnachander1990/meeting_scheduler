import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meeting_scheduler/models/meeting_data.dart';

/// Displays the time selection section.
/// Renders available time slots in a scrollable grid layout.
class TimeSection extends StatelessWidget {
  const TimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final meetingData = Provider.of<MeetingData>(context);
    // meetingData.getTimeSlot();
    /// Determines the number of columns based on screen width
    int columnCount = MediaQuery.of(context).size.width > 1100 ? 2 : 1;

    /// Adjusts the aspect ratio to maintain consistent item height
    double childAspectRatio = columnCount == 2 ? 4 : 6.0;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Section title
          const Text(
            '3. TIME',
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),

          /// Time slot grid
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            color: Colors.transparent,
            height: 500,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columnCount,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: meetingData.timeSlots.length,
              itemBuilder: (context, index) {
                final timeSlot = meetingData.timeSlots[index];
                final isSelected = meetingData.selectedTimeSlot == timeSlot;

                return TimeSlotItem(
                  time: timeSlot.time,
                  isSelected: isSelected,
                  isAvailable: timeSlot.isAvailable,
                  onTap: () => meetingData.selectTimeSlot(timeSlot),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// A single time slot item used within the time selection grid.
/// Displays time, selection state, and handles user interaction.
class TimeSlotItem extends StatelessWidget {
  final String time;
  final bool isSelected;
  final bool isAvailable;
  final VoidCallback onTap;

  const TimeSlotItem({
    super.key,
    required this.time,
    required this.isSelected,
    required this.isAvailable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAvailable ? onTap : null,
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              child: Icon(
                isSelected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_off,
                color: isSelected ? const Color(0xFF4CD964) : Colors.grey,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
