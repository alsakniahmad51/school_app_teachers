import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AttachmentFileItem extends StatelessWidget {
  final String title;
  final String extension;
  final bool isPrimary;
  final bool isDownloaded;
  final bool isDownloading;
  final bool isDeleting;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const AttachmentFileItem({
    super.key,
    required this.title,
    required this.extension,
    this.isPrimary = false,
    this.isDownloaded = false,
    this.isDownloading = false,
    this.isDeleting = false,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            isDownloaded
                ? SvgPicture.asset(
                    "assets/icon/file_icon.svg",
                    width: 24,
                    height: 24,
                  )
                : Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isPrimary
                          ? const Color(0xFF007353)
                          : const Color(0xFFF0F7F5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: isDownloading
                        ? SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: isPrimary
                                  ? Colors.white
                                  : const Color(0xFF007353),
                            ),
                          )
                        : Icon(
                            Icons.download_rounded,
                            size: 18,
                            color: isPrimary
                                ? Colors.white
                                : const Color(0xFF007353),
                          ),
                  ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                textDirection: TextDirection.rtl,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF000F0B),
                ),
              ),
            ),
            IconButton(
              onPressed: isDeleting ? null : onDelete,
              icon: isDeleting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.red,
                      ),
                    )
                  : const Icon(Icons.delete, size: 24, color: Colors.red),
              tooltip: 'حذف الملف',
            ),
          ],
        ),
      ),
    );
  }
}
