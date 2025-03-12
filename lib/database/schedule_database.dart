import 'package:myapp/database/database_helper.dart';
import 'package:myapp/database/schedule_model.dart';

class ScheduleDatabase {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<int> insertSchedule(Schedule schedule) async {
    final db = await dbHelper.database;
    return await db.insert('schedules', schedule.toMap());
  }

  Future<List<Schedule>> getAllSchedules() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> schedules = await db.query('schedules');
    return schedules.map((e) => Schedule.fromMap(e)).toList();
  }

  Future<int> updateSchedule(Schedule schedule) async {
    final db = await dbHelper.database;
    return await db.update(
      'schedules',
      schedule.toMap(),
      where: 'id = ?',
      whereArgs: [schedule.id],
    );
  }

  Future<int> deleteSchedule(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'schedules',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
