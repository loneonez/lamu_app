import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ShiftManagement extends StatefulWidget {
  const ShiftManagement({super.key});

  @override
  State<ShiftManagement> createState() => _ShiftManagementState();
}

class _ShiftManagementState extends State<ShiftManagement> {
  // 選択中の日付を保持する
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('シフト表')),
      body: TableCalendar(
        firstDay: DateTime.utc(2010, 1, 1),
        lastDay: DateTime.utc(2030, 1, 1),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
      ),
    );
  }
}
