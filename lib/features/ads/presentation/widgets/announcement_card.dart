import 'package:flutter/material.dart';

class AnnouncementCardData {
  final String title;
  final String description;
  final String date;
  final String time;
  final String author;
  final bool isUnread;

  const AnnouncementCardData({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.author,
    required this.isUnread,
  });
}

class AnnouncementCard extends StatelessWidget {
  final AnnouncementCardData data;

  const AnnouncementCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = data.isUnread
        ? const Color(0xFFF0F7F5)
        : Colors.white;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: const Color(0xFF007353), width: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.title,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF000F0B),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.description,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF47524F),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _MetaItem(
                label: data.author,
                icon: null,
                labelColor: const Color(0xFF007353),
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF007353),
                  height: 1.5,
                ),
              ),
              const SizedBox(width: 8),
              _MetaItem(
                label: data.date,
                icon: Icons.calendar_today_outlined,
                labelColor: const Color(0xFF47524F),
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF47524F),
                  height: 1.5,
                ),
              ),
              const SizedBox(width: 8),
              _MetaItem(
                label: data.time,
                icon: Icons.access_time_outlined,
                labelColor: const Color(0xFF47524F),
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF47524F),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color labelColor;
  final TextStyle textStyle;

  const _MetaItem({
    required this.label,
    required this.icon,
    required this.labelColor,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      Text(label, textDirection: TextDirection.rtl, style: textStyle),
    ];

    if (icon != null) {
      children.add(const SizedBox(width: 2));
      children.add(Icon(icon, size: 12, color: labelColor));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.rtl,
      children: children,
    );
  }
}
