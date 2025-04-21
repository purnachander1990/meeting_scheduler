import 'package:flutter/material.dart';
import 'package:meeting_scheduler/widgets/participants_section.dart';
import 'package:meeting_scheduler/widgets/duration_section.dart';
import 'package:meeting_scheduler/widgets/date_section.dart';
import 'package:meeting_scheduler/widgets/time_section.dart';
import 'package:meeting_scheduler/widgets/confirmation_section.dart';
import 'package:meeting_scheduler/widgets/timezone_section.dart';
import 'package:provider/provider.dart';
import 'package:meeting_scheduler/models/meeting_data.dart';

/// SchedulerScreen is the main layout widget for scheduling a meeting.
/// It displays participant selection, date/time pickers, duration,
/// timezone, and a confirmation section based on current application state.
class SchedulerScreen extends StatelessWidget {
  const SchedulerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final meetingData = Provider.of<MeetingData>(context);

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1340),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F8),
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  /// Section for selecting meeting participants
                  const ParticipantsSection(),

                  /// Horizontal divider
                  Container(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),

                  /// Three-column layout: Duration & Timezone | Date | Time & Confirmation
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left column (Duration and Timezone)
                      Expanded(
                        child: Container(
                          height: meetingData.isConfirmationVisible() ? 900 : 800,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const DurationSection(),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: const Center(
                                  child: TimezoneSection(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Vertical divider
                      Container(
                        width: 1,
                        height: meetingData.isConfirmationVisible() ? 900 : 800,
                        color: Colors.grey.shade300,
                      ),

                      // Middle column (Date selection)
                      Expanded(
                        child: Column(
                          children: const [
                            DateSection(),
                          ],
                        ),
                      ),

                      // Vertical divider
                      Container(
                        width: 1,
                        height: meetingData.isConfirmationVisible() ? 900 : 800,
                        color: Colors.grey.shade300,
                      ),

                      // Right column (Time selection and optional confirmation)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TimeSection(),
                            if (meetingData.isConfirmationVisible())
                              const ConfirmationSection(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
