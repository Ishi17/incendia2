import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
        backgroundColor: Color(0xFF002B5B),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFFFF6B00).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.schedule,
                            color: Color(0xFFFF6B00),
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          'Weekly Class Schedule',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF002B5B),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildScheduleTable(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleTable() {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    final periods = [
      '8:00 - 9:00',
      '9:00 - 10:00',
      '10:15 - 11:15',
      '11:15 - 12:15',
      '1:00 - 2:00',
      '2:00 - 3:00',
    ];
    final schedule = [
      ['Math', 'English', 'Physics', 'Chemistry', 'Biology'],
      ['History', 'Math', 'English', 'Computer', 'PE'],
      ['Physics', 'Chemistry', 'Math', 'English', 'Art'],
      ['Biology', 'History', 'Math', 'Physics', 'English'],
      ['Computer', 'PE', 'Chemistry', 'Math', 'English'],
      ['Art', 'Math', 'English', 'Biology', 'History'],
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Color(0xFF002B5B)),
        headingTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        columns: [
          const DataColumn(label: Text('Time')),
          ...days.map((d) => DataColumn(label: Text(d))).toList(),
        ],
        rows: List.generate(periods.length, (i) {
          return DataRow(
            cells: [
              DataCell(
                Text(
                  periods[i],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              ...List.generate(
                days.length,
                (j) => DataCell(Text(schedule[i][j])),
              ),
            ],
          );
        }),
      ),
    );
  }
}
