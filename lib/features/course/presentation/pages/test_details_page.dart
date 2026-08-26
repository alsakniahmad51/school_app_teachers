import 'package:flutter/material.dart';

import '../widgets/student_scores_table.dart';
import '../widgets/test_details_header.dart';
import '../widgets/test_details_models.dart';

class TestDetailsPage extends StatefulWidget {
  const TestDetailsPage({
    super.key,
    this.courseTitle = 'الفقه والشريعة',
    this.testTitle = 'فحص نهائي',
    this.initialStudents,
    this.onPublish,
  });

  final String courseTitle;
  final String testTitle;
  final List<StudentMarkItem>? initialStudents;
  final ValueChanged<List<StudentMarkItem>>? onPublish;

  @override
  State<TestDetailsPage> createState() => _TestDetailsPageState();
}

class _TestDetailsPageState extends State<TestDetailsPage> {
  late List<StudentMarkItem> _students;

  static const List<StudentMarkItem> _mockStudents = [
    StudentMarkItem(
      id: 1,
      studentName: 'أحمد علي الأحمد',
      maxScore: 100,
      score: 68,
      noteExpanded: true,
      note: '',
    ),
    StudentMarkItem(
      id: 2,
      studentName: 'أحمد علي الأحمد',
      maxScore: 100,
      score: null,
      statusOverride: StudentResultStatus.failed,
    ),
    StudentMarkItem(
      id: 3,
      studentName: 'أحمد علي الأحمد',
      maxScore: 100,
      score: 80,
    ),
    StudentMarkItem(
      id: 4,
      studentName: 'أحمد علي الأحمد',
      maxScore: 100,
      score: 24,
    ),
    StudentMarkItem(
      id: 5,
      studentName: 'أحمد علي الأحمد',
      maxScore: 100,
      score: 39,
    ),
    StudentMarkItem(
      id: 6,
      studentName: 'أحمد علي الأحمد',
      maxScore: 100,
      score: 60,
    ),
    StudentMarkItem(
      id: 7,
      studentName: 'أحمد علي الأحمد',
      maxScore: 100,
      score: 50,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _students = List<StudentMarkItem>.from(
      widget.initialStudents ?? _mockStudents,
    );
  }

  void _updateStudent(
    int studentId,
    StudentMarkItem Function(StudentMarkItem) updater,
  ) {
    setState(() {
      _students = _students
          .map(
            (student) => student.id == studentId ? updater(student) : student,
          )
          .toList(growable: false);
    });
  }

  void _onScoreChanged(int studentId, int? value) {
    _updateStudent(
      studentId,
      (student) => student.copyWith(
        score: value,
        clearScore: value == null,
        clearStatusOverride: true,
      ),
    );
  }

  void _onNoteChanged(int studentId, String value) {
    _updateStudent(studentId, (student) => student.copyWith(note: value));
  }

  void _toggleNote(int studentId) {
    _updateStudent(
      studentId,
      (student) => student.copyWith(noteExpanded: !student.noteExpanded),
    );
  }

  void _publishMarks() {
    widget.onPublish?.call(_students);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تجهيز العلامات للنشر بنجاح')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xfff7f7f7),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 412),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Color(0xffe0e0e0), width: 1),
                      ),
                    ),
                    child: TestDetailsHeader(
                      courseTitle: widget.courseTitle,
                      testTitle: widget.testTitle,
                      onBack: () => Navigator.of(context).maybePop(),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                      child: StudentScoresTable(
                        items: _students,
                        onScoreChanged: _onScoreChanged,
                        onNoteChanged: _onNoteChanged,
                        onToggleNote: _toggleNote,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(color: Color(0xffe0e0e0), width: 1),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: FilledButton.icon(
                        onPressed: _publishMarks,
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xff007353),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.send_outlined, size: 20),
                        label: const Text(
                          'نشر العلامات للطلاب',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
