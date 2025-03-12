import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myapp/database/task_model.dart';
import 'package:myapp/database/task_database.dart';
import 'package:myapp/widget/task_item.dart';
import 'package:myapp/screens/task_details_screen.dart';

class TasksList extends StatefulWidget {
  final VoidCallback onUpdateTaskCount;

  const TasksList({super.key, required this.onUpdateTaskCount});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    List<Task> tasks = await TaskDatabase().getAllTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  void _deleteTask(int id) async {
    await TaskDatabase().deleteTask(id);
    widget.onUpdateTaskCount();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return _tasks.isEmpty
        ? const Center(
          child: Text(
            "No Tasks Avilable",
            style: TextStyle(
              color: Color(0xFF063454),
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
        : ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            final task = _tasks[index];

            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      print("Edit Task: ${task.title}");
                    },
                    backgroundColor: const Color(0xFFbfdee9),
                    icon: Icons.edit,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      if (task.id != null) {
                        _deleteTask(task.id!);
                      } else {
                        print("Error: Task ID is null");
                      }
                    },
                    backgroundColor: const Color(0xFFbfdee9),
                    icon: Icons.delete,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetailsScreen(task: task),
                    ),
                  ).then(
                    (_) => _loadTasks(),
                  ); 
                },
                child: TaskItem(
                  taskTitle: task.title,
                  isChecked: task.isCompleted,
                ),
              ),
            );
          },
        );
  }
}
