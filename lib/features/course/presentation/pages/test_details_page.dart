import 'package:flutter/material.dart';
import 'package:excel/excel.dart' hide Border;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/features/course/domain/entity/bulk_exam.dart';
import 'package:teachers_app/features/course/domain/entity/bulk_exam_student.dart';
import 'package:teachers_app/features/course/presentation/manager/bulk_exam_cubit/bulk_exam_cubit.dart';

import '../widgets/student_scores_table.dart';
import '../widgets/test_details_header.dart';
import '../widgets/test_details_models.dart';

class TestDetailsPage extends StatefulWidget {
  const TestDetailsPage({
    super.key,
    this.courseTitle = 'الفقه والشريعة',
    this.testTitle = 'فحص نهائي',
    this.subjectId,
    this.examDate = '',
    this.initialStudents,
    this.onPublish,
  });

  final String courseTitle;
  final String testTitle;
  final int? subjectId;
  final String examDate;
  final List<StudentMarkItem>? initialStudents;
  final ValueChanged<List<StudentMarkItem>>? onPublish;

  @override
  State<TestDetailsPage> createState() => _TestDetailsPageState();
}

class _TestDetailsPageState extends State<TestDetailsPage> {
  late List<StudentMarkItem> _students;

  @override
  void initState() {
    super.initState();
    _students = List<StudentMarkItem>.from(widget.initialStudents ?? const []);
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
    if (widget.subjectId == null) {
      _showMessage('بيانات المادة غير متوفرة');
      return;
    }

    final students = _students
        .where((student) => student.score != null)
        .map(
          (student) => BulkExamStudent(
            studentId: student.id,
            mark: student.score!,
            note: student.note,
          ),
        )
        .toList();

    if (students.isEmpty) {
      _showMessage('أضف بيانات الطلاب أولاً');
      return;
    }
    final invalidStudentIds = students
        .where((student) => student.studentId <= 0)
        .map((student) => student.studentId)
        .toList();
    if (invalidStudentIds.isNotEmpty) {
      _showMessage('معرفات الطلاب غير صحيحة: ${invalidStudentIds.join(', ')}');
      return;
    }
    if (widget.testTitle.trim().isEmpty || widget.examDate.trim().isEmpty) {
      _showMessage('نوع الاختبار أو تاريخه غير متوفر');
      return;
    }

    context.read<BulkExamCubit>().addBulkExam(
      BulkExam(
        subjectId: widget.subjectId!,
        examType: widget.testTitle.trim(),
        date: widget.examDate.trim(),
        students: students,
      ),
    );
  }

  Future<void> _pickExcelFile() async {
    final result = await FilePicker.pickFiles();
    if (!mounted || result.isEmpty) return;

    final bytes = await result.single.readAsBytes();

    try {
      final workbook = Excel.decodeBytes(bytes);
      if (workbook.tables.isEmpty) {
        _showMessage('ملف Excel فارغ');
        return;
      }
      final rows = workbook.tables.values.first.rows;
      final students = _parseExcelRows(rows);
      if (students.isEmpty) {
        _showMessage('لم يتم العثور على بيانات صالحة في الملف');
        return;
      }
      setState(() => _students = students);
    } catch (_) {
      _showMessage('تعذر قراءة ملف Excel');
    }
  }

  List<StudentMarkItem> _parseExcelRows(List<List<Data?>> rows) {
    final students = <StudentMarkItem>[];
    for (final row in rows) {
      if (row.length < 2) continue;
      final studentId = _toInt(row[0]?.value);
      final mark = _toInt(row[1]?.value);
      if (studentId == null || mark == null) continue;
      final note = row.length > 2 ? '${row[2]?.value ?? ''}' : '';
      students.add(
        StudentMarkItem(
          id: studentId,
          studentName: 'الطالب $studentId',
          maxScore: 100,
          score: mark,
          note: note,
        ),
      );
    }
    return students;
  }

  int? _toInt(Object? value) {
    if (value is num) return value.toInt();
    return int.tryParse('$value'.trim());
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BulkExamCubit, BulkExamState>(
      listener: (context, state) {
        if (state is BulkExamSuccess) {
          _showMessage(
            state.message.isEmpty ? 'تم نشر العلامات بنجاح' : state.message,
          );
        } else if (state is BulkExamFailure) {
          _showMessage(state.message);
        }
      },
      child: Directionality(
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
                          bottom: BorderSide(
                            color: Color(0xffe0e0e0),
                            width: 1,
                          ),
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
                        child: Column(
                          children: [
                            StudentScoresTable(
                              items: _students,
                              onScoreChanged: _onScoreChanged,
                              onNoteChanged: _onNoteChanged,
                              onToggleNote: _toggleNote,
                            ),
                            const SizedBox(height: 16),
                            OutlinedButton.icon(
                              onPressed: _pickExcelFile,
                              icon: const Icon(Icons.upload_file_outlined),
                              label: const Text('اختيار ملف Excel'),
                            ),
                          ],
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
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: BlocBuilder<BulkExamCubit, BulkExamState>(
                              builder: (context, state) => FilledButton.icon(
                                onPressed: state is BulkExamLoading
                                    ? null
                                    : _publishMarks,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
