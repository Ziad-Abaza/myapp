import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, 
      itemBuilder: (context, index) {
        return Slidable(
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  print("Edit Scheduled Task ${index + 1}");
                },
                backgroundColor: const Color(0xFFbfdee9),
                icon: Icons.edit,
                borderRadius: BorderRadius.circular(8),
              ),
              SlidableAction(
                onPressed: (context) {
                  print("Delete Scheduled Task ${index + 1}");
                },
                backgroundColor: const Color(0xFFbfdee9),
                icon: Icons.delete,
                borderRadius: BorderRadius.circular(8),
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              "Scheduled Task ${index + 1}",
              style: TextStyle(
                color: const Color(0xFF063454),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              "Due on: ${DateTime.now().add(Duration(days: index)).toString().split(' ')[0]}",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            trailing: Checkbox(
              value: index % 2 == 0,
              onChanged: (value) {},
              activeColor: const Color(0xFF063454),
            ),
          ),
        );
      },
    );
  }
}