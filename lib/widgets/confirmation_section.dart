import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meeting_scheduler/models/meeting_data.dart';

/// A widget that displays the final confirmation section of the meeting scheduler.
/// Shows selected duration, participant, date, and time along with Confirm and Cancel actions.
class ConfirmationSection extends StatelessWidget {
  const ConfirmationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final meetingData = Provider.of<MeetingData>(context);
    final selectedDuration = meetingData.durationOptions[meetingData.selectedDurationIndex];

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Section title
          const Text(
            '4. CONFIRM BOOKING',
            style: TextStyle(
              fontSize: 15,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),

          /// Meeting details (duration and participant)
          Container(
            padding: EdgeInsets.only(right: 50),
            child: Wrap(
              children: [
                Text(
                  '${selectedDuration.minutes} MINUTE MEETING',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'WITH',
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'ANGELO BEGETTI',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          /// Selected date and time
          Text(
            '${meetingData.getFormattedDate()}, AT ${meetingData.selectedTimeSlot?.time}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 24),

          /// Action buttons: Confirm and Cancel
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Confirm button
              TextButton(
                onPressed: meetingData.confirmBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF33CD7B),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'CONFIRM',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// Cancel button
              TextButton(
                onPressed: meetingData.clearSelection,
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFF3F8FB),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'CANCEL',
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
