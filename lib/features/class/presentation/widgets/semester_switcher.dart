import 'package:flutter/material.dart';

class SemesterSwitcher extends StatefulWidget {
  const SemesterSwitcher({super.key});

  @override
  State<SemesterSwitcher> createState() => _SemesterSwitcherState();
}

class _SemesterSwitcherState extends State<SemesterSwitcher> {
  String selectedSemester = 'الفصل الأول';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _SemesterTab(
              label: 'الفصل الثاني',
              selected: selectedSemester == 'الفصل الثاني',
              onTap: () => setState(() => selectedSemester = 'الفصل الثاني'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _SemesterTab(
              label: 'الفصل الأول',
              selected: selectedSemester == 'الفصل الأول',
              onTap: () => setState(() => selectedSemester = 'الفصل الأول'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SemesterTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SemesterTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),

        decoration: BoxDecoration(
          color: selected ? const Color(0xFF007353) : Colors.white,
          border: Border.all(color: const Color(0xFFACACAC), width: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : const Color(0xFF000F0B),
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
