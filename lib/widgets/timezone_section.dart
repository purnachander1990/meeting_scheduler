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

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Dropdown for timezone selection
            PopupMenuButton<String>(
              onSelected: meetingData.setTimezone,
              tooltip: '',
              child: Row(
                children: [
                  Text(
                    meetingData.currentTimezone,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF666666),
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down, size: 16),
                ],
              ),
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: '(-05:00) EST - NEW YORK TIME',
                  child: Text('(-05:00) EST - NEW YORK TIME'),
                ),
                PopupMenuItem(
                  value: '(-08:00) PST - LOS ANGELES TIME',
                  child: Text('(-08:00) PST - LOS ANGELES TIME'),
                ),
                PopupMenuItem(
                  value: '(+00:00) GMT - LONDON TIME',
                  child: Text('(+00:00) GMT - LONDON TIME'),
                ),
                PopupMenuItem(
                  value: '(+01:00) CET - PARIS TIME',
                  child: Text('(+01:00) CET - PARIS TIME'),
                ),
                PopupMenuItem(
                  value: '(+05:30) IST - INDIA TIME',
                  child: Text('(+05:30) IST - INDIA TIME'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
