import 'package:flutter/material.dart';

import 'student_score_row.dart';
import 'test_details_models.dart';

class StudentScoresTable extends StatelessWidget {
  const StudentScoresTable({
    super.key,
    required this.items,
    required this.onScoreChanged,
    required this.onNoteChanged,
    required this.onToggleNote,
  });

  final List<StudentMarkItem> items;
  final void Function(int studentId, int? value) onScoreChanged;
  final void Function(int studentId, String value) onNoteChanged;
  final ValueChanged<int> onToggleNote;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        border: Border.all(color: const Color(0xffe0e0e0), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xfff0f7f5),
              border: Border(
                bottom: BorderSide(color: Color(0xffe0e0e0), width: 1),
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: const Row(
              children: [
                SizedBox(
                  width: 32,
                  child: Center(
                    child: Text(
                      '#',
                      style: TextStyle(
                        color: Color(0xff000f0b),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'الطالب',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xff000f0b),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Center(
                    child: Text(
                      'العلامة',
                      style: TextStyle(
                        color: Color(0xff000f0b),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Center(
                    child: Text(
                      'الحالة',
                      style: TextStyle(
                        color: Color(0xff000f0b),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 54,
                  child: Center(
                    child: Text(
                      'ملاحظات',
                      style: TextStyle(
                        color: Color(0xff000f0b),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0)
              const Divider(height: 1, thickness: 1, color: Color(0xffe0e0e0)),
            StudentScoreRow(
              key: ValueKey(items[i].id),
              item: items[i],
              onScoreChanged: (value) => onScoreChanged(items[i].id, value),
              onNoteChanged: (value) => onNoteChanged(items[i].id, value),
              onToggleNote: () => onToggleNote(items[i].id),
            ),
          ],
        ],
      ),
    );
  }
}
