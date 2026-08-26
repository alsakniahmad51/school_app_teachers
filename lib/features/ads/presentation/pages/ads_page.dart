import 'package:flutter/material.dart';

import '../widgets/announcement_card.dart';

class AdsPage extends StatelessWidget {
  const AdsPage({super.key});

  static const List<AnnouncementCardData> _mockAnnouncements = [
    AnnouncementCardData(
      title: 'حفل نهاية العام — 15 يونيو 2026',
      description:
          'يسرنا أن نعلن أن حفل التخرج السنوي وتوزيع الجوائز سيُقام في 15 يونيو 2026 الساعة 17:00 في القاعة الرئيسية. الجميع',
      date: '2025/12/30',
      time: '12:30 PM',
      author: 'بواسطة الإدارة العامة',
      isUnread: true,
    ),
    AnnouncementCardData(
      title: 'حفل نهاية العام — 15 يونيو 2026',
      description:
          'يسرنا أن نعلن أن حفل التخرج السنوي وتوزيع الجوائز سيُقام في 15 يونيو 2026 الساعة 17:00 في القاعة الرئيسية. الجميع',
      date: '2025/12/30',
      time: '12:30 PM',
      author: 'بواسطة الإدارة العامة',
      isUnread: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 412),
              child: Container(
                width: 412,
                height: MediaQuery.of(context).size.height,
                color: const Color(0xFFF7F7F7),
                child: Column(
                  children: [
                    const _AdsHeader(),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                        itemCount: _mockAnnouncements.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          return AnnouncementCard(
                            data: _mockAnnouncements[index],
                          );
                        },
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

class _AdsHeader extends StatelessWidget {
  const _AdsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            icon: const Icon(Icons.chevron_left_rounded, size: 26),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 32, height: 32),
            splashRadius: 20,
            color: const Color(0xFF000F0B),
          ),
          const Expanded(
            child: Text(
              'الإعلانات',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000F0B),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
