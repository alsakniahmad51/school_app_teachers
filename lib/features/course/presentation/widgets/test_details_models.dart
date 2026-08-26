import 'package:flutter/material.dart';

enum StudentResultStatus { passed, failed, pending }

@immutable
class StudentMarkItem {
  const StudentMarkItem({
    required this.id,
    required this.studentName,
    required this.maxScore,
    this.score,
    this.note = '',
    this.noteExpanded = false,
    this.statusOverride,
  });

  final int id;
  final String studentName;
  final int maxScore;
  final int? score;
  final String note;
  final bool noteExpanded;
  final StudentResultStatus? statusOverride;

  StudentResultStatus get status {
    if (score == null) {
      return statusOverride ?? StudentResultStatus.pending;
    }
    return score! >= 50
        ? StudentResultStatus.passed
        : StudentResultStatus.failed;
  }

  StudentMarkItem copyWith({
    int? id,
    String? studentName,
    int? maxScore,
    int? score,
    bool clearScore = false,
    String? note,
    bool? noteExpanded,
    StudentResultStatus? statusOverride,
    bool clearStatusOverride = false,
  }) {
    return StudentMarkItem(
      id: id ?? this.id,
      studentName: studentName ?? this.studentName,
      maxScore: maxScore ?? this.maxScore,
      score: clearScore ? null : (score ?? this.score),
      note: note ?? this.note,
      noteExpanded: noteExpanded ?? this.noteExpanded,
      statusOverride: clearStatusOverride
          ? null
          : (statusOverride ?? this.statusOverride),
    );
  }
}
