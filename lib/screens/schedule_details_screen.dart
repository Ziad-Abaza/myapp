import 'package:flutter/material.dart';
import 'package:myapp/database/schedule_model.dart';
import 'package:myapp/providers/schedule_provider.dart';
import 'package:provider/provider.dart';

class ScheduleDetailsScreen extends StatelessWidget {
  final int scheduleId;

  const ScheduleDetailsScreen({super.key, required this.scheduleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule Details"),
        backgroundColor: const Color(0xFF063454),
      ),
      body: FutureBuilder<Schedule?>(
        future: Provider.of<ScheduleProvider>(context, listen: false).getSchedule(scheduleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Schedule not found"));
          }

          final schedule = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(schedule.title, style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Text("Date:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(schedule.date, style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Text("Time:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(schedule.time, style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
                Text("Status:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(schedule.isEnabled ? "Enabled" : "Disabled", style: TextStyle(fontSize: 16, color: schedule.isEnabled ? Colors.green : Colors.red)),
              ],
            ),
          );
        },
      ),
    );
  }
}
