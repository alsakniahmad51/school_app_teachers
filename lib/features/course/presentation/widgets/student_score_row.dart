import 'package:flutter/material.dart';

import 'test_details_models.dart';

class StudentScoreRow extends StatefulWidget {
  const StudentScoreRow({
    super.key,
    required this.item,
    required this.onScoreChanged,
    required this.onNoteChanged,
    required this.onToggleNote,
  });

  final StudentMarkItem item;
  final ValueChanged<int?> onScoreChanged;
  final ValueChanged<String> onNoteChanged;
  final VoidCallback onToggleNote;

  @override
  State<StudentScoreRow> createState() => _StudentScoreRowState();
}

class _StudentScoreRowState extends State<StudentScoreRow> {
  late final TextEditingController _scoreController;
  late final FocusNode _scoreFocusNode;
  bool _isEditingScore = false;

  @override
  void initState() {
    super.initState();
    _scoreController = TextEditingController(
      text: _scoreAsText(widget.item.score),
    );
    _scoreFocusNode = FocusNode();
    _scoreFocusNode.addListener(() {
      if (!_scoreFocusNode.hasFocus && _isEditingScore) {
        _commitScore();
      }
    });
  }

  @override
  void didUpdateWidget(covariant StudentScoreRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isEditingScore && oldWidget.item.score != widget.item.score) {
      _scoreController.text = _scoreAsText(widget.item.score);
    }
  }

  @override
  void dispose() {
    _scoreController.dispose();
    _scoreFocusNode.dispose();
    super.dispose();
  }

  String _scoreAsText(int? score) => score == null ? '' : score.toString();

  Color _scoreColor(StudentMarkItem item) {
    final score = item.score;
    if (score == null) {
      return const Color(0xff000f0b);
    }
    if (score >= 70) {
      return const Color(0xff00a63e);
    }
    if (score >= 50) {
      return const Color(0xffd97706);
    }
    return const Color(0xffdc2626);
  }

  Color _statusColor(StudentResultStatus status) {
    switch (status) {
      case StudentResultStatus.passed:
        return const Color(0xff00a63e);
      case StudentResultStatus.failed:
        return const Color(0xffdc2626);
      case StudentResultStatus.pending:
        return const Color(0xff47524f);
    }
  }

  String _statusLabel(StudentResultStatus status) {
    switch (status) {
      case StudentResultStatus.passed:
        return 'ناجح';
      case StudentResultStatus.failed:
        return 'راسب';
      case StudentResultStatus.pending:
        return 'قيد الإدخال';
    }
  }

  void _startEditingScore() {
    setState(() {
      _isEditingScore = true;
      _scoreController.text = _scoreAsText(widget.item.score);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _scoreFocusNode.requestFocus();
      }
    });
  }

  void _commitScore() {
    final raw = _scoreController.text.trim();
    int? value;

    if (raw.isNotEmpty) {
      final parsed = int.tryParse(raw);
      if (parsed != null) {
        value = parsed.clamp(0, widget.item.maxScore);
      }
    }

    widget.onScoreChanged(value);
    if (mounted) {
      setState(() {
        _isEditingScore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              SizedBox(
                width: 32,
                child: Text(
                  item.id.toString().padLeft(2, '0'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xff000f0b),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    height: 1.45,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    item.studentName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Color(0xff000f0b),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                child: GestureDetector(
                  onTap: _startEditingScore,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff000f0b),
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: _isEditingScore
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${item.maxScore}/',
                                  style: const TextStyle(
                                    color: Color(0xff47524f),
                                    fontSize: 10,
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                  child: TextField(
                                    controller: _scoreController,
                                    focusNode: _scoreFocusNode,
                                    autofocus: true,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (_) => _commitScore(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xff000f0b),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      height: 1.15,
                                    ),
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                      hintText: '--',
                                      hintStyle: TextStyle(
                                        color: Color(0xff000f0b),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${item.maxScore}/',
                                  style: const TextStyle(
                                    color: Color(0xff47524f),
                                    fontSize: 10,
                                    height: 1.2,
                                  ),
                                ),
                                Text(
                                  item.score?.toString() ?? '--',
                                  style: TextStyle(
                                    color: _scoreColor(item),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    height: 1.15,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                child: Center(
                  child: Text(
                    _statusLabel(item.status),
                    style: TextStyle(
                      color: _statusColor(item.status),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 54,
                child: Center(
                  child: GestureDetector(
                    onTap: widget.onToggleNote,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: item.noteExpanded
                            ? const Color(0xfffae5e5)
                            : const Color(0xfff0f7f5),
                        border: Border.all(
                          color: item.noteExpanded
                              ? const Color(0xffdc2626)
                              : const Color(0xff007353),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        item.noteExpanded ? Icons.remove : Icons.add,
                        size: 16,
                        color: item.noteExpanded
                            ? const Color(0xffdc2626)
                            : const Color(0xff007353),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (item.noteExpanded)
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 8,
              end: 14,
              bottom: 8,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: widget.onToggleNote,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xfffae5e5),
                      border: Border.all(
                        color: const Color(0xffdc2626),
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.remove,
                      size: 16,
                      color: Color(0xffdc2626),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff000f0b),
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      initialValue: item.note,
                      onChanged: widget.onNoteChanged,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xff47524f),
                        fontSize: 11,
                        height: 1.35,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: 'أضف ملاحظة',
                        hintStyle: TextStyle(
                          color: Color(0xff47524f),
                          fontSize: 11,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
