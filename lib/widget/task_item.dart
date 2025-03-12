

// ========================================
// Task Item Widget
// ========================================
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String taskTitle;
  final bool isChecked;

  const TaskItem({
    super.key,
    required this.taskTitle,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isChecked ? const Color(0x8F72C9CE) : const Color(0xFFf8f9fa),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              taskTitle,
              style: TextStyle(
                color: isChecked ? const Color(0xFF155724) : const Color(0xFF063454),
                fontSize: 16,
                fontWeight: isChecked ? FontWeight.w600 : FontWeight.w500,
                decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
          ),
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              // هنا يمكنك إضافة الدالة لتحديث حالة المهمة
            },
            activeColor: const Color(0xFF063454),
          ),
        ],
      ),
    );
  }
}