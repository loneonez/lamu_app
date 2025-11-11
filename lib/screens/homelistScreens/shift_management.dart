import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ShiftmanagementScreen extends StatefulWidget {
  const ShiftmanagementScreen({super.key});

  @override
  State<ShiftmanagementScreen> createState() => _ShiftmanagementScreen();
}

class _ShiftmanagementScreen extends State<ShiftmanagementScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('シフトカレンダー')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              locale: 'ja_JP', // 日本語化
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: focusedDay,
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              onDaySelected: (selected, focused) {
                setState(() {
                  selectedDay = selected;
                  focusedDay = focused;
                });
              },
              calendarFormat: CalendarFormat.month, // ← 月単位表示
              availableCalendarFormats: const {CalendarFormat.month: '月表示のみ'},
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
