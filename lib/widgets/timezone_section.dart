import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meeting_scheduler/models/meeting_data.dart';

/// A widget that allows users to view and change their timezone.
/// Displays a dropdown menu with a list of predefined timezones.
class TimezoneSection extends StatelessWidget {
  const TimezoneSection({super.key});

  @override
  Widget build(BuildContext context) {
    final meetingData = Provider.of<MeetingData>(context);

    // List of predefined timezones (must match with model logic)
    const timezones = [
      '(-05:00) EST - NEW YORK TIME',
      '(-08:00) PST - LOS ANGELES TIME',
      '(+00:00) GMT - LONDON TIME',
      '(+01:00) CET - PARIS TIME',
      '(+05:30) IST - INDIA TIME',
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton<String>(
              onSelected: meetingData.setTimezone,
              tooltip: 'Select Timezone',
              child: Row(
                children: [
                  Text(
                    meetingData.currentTimezone,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down, size: 16),
                ],
              ),
              itemBuilder: (context) {
                return timezones.map((tz) {
                  return PopupMenuItem<String>(
                    value: tz,
                    child: Text(tz),
                  );
                }).toList();
              },
            ),
          ],
        ),
      ),
    );
  }
}
