import 'package:flutter/material.dart';
import 'package:myapp/screens/task_form_screen.dart';
import 'package:myapp/widget/header_app.dart';
import 'package:myapp/widget/tasks_list.dart';
import 'package:myapp/widget/navigation_bar.dart';
import 'package:myapp/database/task_database.dart';
import 'package:myapp/database/task_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  int _taskCount = 0;

  @override
  void initState() {
    super.initState();
    _loadTaskCount();
  }

  void _loadTaskCount() async {
    List<Task> tasks = await TaskDatabase().getAllTasks();
    setState(() {
      _taskCount = tasks.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF468ca3),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ====================== Section 1 ======================
              HeaderApp(),

              const SizedBox(height: 20),

              // ====================== Section 2 ======================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$_taskCount Tasks",
                    style: TextStyle(
                      color: const Color(0xFFbfdee9),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  FloatingActionButton.small(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TaskFormScreen(),
                        ),
                      ).then((_) => _loadTaskCount());
                    },
                    backgroundColor: const Color(0xFF063454),
                    elevation: 4,
                    child: Icon(
                      Icons.add,
                      size: 18,
                      color: const Color(0xFFbfdee9),
                    ),
                  ),
                ],
              ),
              // ====================== Section 3 ======================
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFbfdee9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TasksList(onUpdateTaskCount: _loadTaskCount), 
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationButtom(currentIndex: 0),
    );
  }
}
