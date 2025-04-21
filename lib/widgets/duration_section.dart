import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meeting_scheduler/models/meeting_data.dart';

/// Displays the section for selecting the meeting duration.
/// Offers three predefined duration options: 15, 30, and 60 minutes.
class DurationSection extends StatelessWidget {
  const DurationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final meetingData = Provider.of<MeetingData>(context);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Section title
          Center(
            child: const Text(
              '1. DURATION',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333),
              ),
            ),
          ),
          const SizedBox(height: 16),

          /// Option: 15 Minutes
          DurationOption(
            isSelected: meetingData.selectedDurationIndex == 0,
            durationText: '15 MIN',
            descriptionText: meetingData.durationOptions[0].description,
            onTap: () => meetingData.selectDuration(0),
          ),
          const SizedBox(height: 16),

          /// Option: 30 Minutes
          DurationOption(
            isSelected: meetingData.selectedDurationIndex == 1,
            durationText: '30 MIN',
            descriptionText: meetingData.durationOptions[1].description,
            onTap: () => meetingData.selectDuration(1),
          ),
          const SizedBox(height: 16),

          /// Option: 60 Minutes
          DurationOption(
            isSelected: meetingData.selectedDurationIndex == 2,
            durationText: '60 MIN',
            descriptionText: meetingData.durationOptions[2].description,
            onTap: () => meetingData.selectDuration(2),
          ),
        ],
      ),
    );
  }
}

/// A selectable UI component that represents a single duration option.
/// Displays the duration label, a selection icon, and an optional description.
class DurationOption extends StatelessWidget {
  final bool isSelected;
  final String durationText;
  final String descriptionText;
  final VoidCallback onTap;

  const DurationOption({
    super.key,
    required this.isSelected,
    required this.durationText,
    required this.descriptionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: isSelected
            ? const EdgeInsets.all(16)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: isSelected
              ? BorderRadius.circular(20)
              : BorderRadius.circular(50),
          border: isSelected ? null : Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Top row with duration text and selection icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  durationText,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                    color: isSelected ? Colors.grey.shade300 : Colors.black,
                  ),
                ),
                Icon(
                  isSelected
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_off,
                  color: isSelected ? const Color(0xFF4CD964) : Colors.grey,
                  size: 18,
                ),
              ],
            ),

            /// Description (only visible if selected)
            if (isSelected) ...[
              const SizedBox(height: 8),
              Text(
                descriptionText,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade300,
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
