// [2025-12-26] تم تعديل تصميم وتخطيط SpecialOffer ليطابق الواجهة التصميمية البانرية الأفقية كما ظهرت في الصورة تماماً.
// تم إضافة FittedBox لجعل البانر متجاوباً تلقائياً على الشاشات الصغيرة جداً دون حدوث أي قص (Overflow).

import 'package:credora/core/utils/size_config.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SpecialOffer extends StatefulWidget {
  final String offername;
  final String typeoffer;
  final String imageUrl;
  final bool AndroidDevice;
  final bool ComputerDevice;

  const SpecialOffer({
    super.key,
    required this.imageUrl,
    required this.offername,
    required this.typeoffer,
    required this.AndroidDevice,
    required this.ComputerDevice,
  });

  @override
  State<SpecialOffer> createState() => _SpecialOfferState();
}

class _SpecialOfferState extends State<SpecialOffer> {
  // تم تحديد ارتفاع ثابت للبانر لضمان استقرار التصميم
  static const double fixedHeight = 88.0;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return GestureDetector(
      onTap: () {},
      // استخدام FittedBox لضمان التجاوب الآمن على الشاشات الصغيرة جداً
      child: FittedBox(
        fit: BoxFit.contain,
        alignment: Alignment.centerLeft,
        child: SizedBox(
          // استخدام عرض تقريبي ثابت للبانر ليعمل بشكل مثالي مع الـ FittedBox
          width: 360.0,
          height: fixedHeight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: AppColors.surface,
              gradient: LinearGradient(
                colors: [
                  AppColors.surface,
                  AppColors.primary.withValues(alpha: 0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.25),
              ),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.transparentBlack08,
                  blurRadius: 12,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                // أيقونات الأجهزة بشكل مبسط يسار الصورة أو داخل الحاوية البانرية
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.surfaceSoft,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.imageUrl),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 4,
                        left: 4,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: AppColors.transparentBlack97,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child:
                              widget.AndroidDevice && widget.ComputerDevice
                                  ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        width: 12,
                                        height: 12,
                                        "lib/images/android.png",
                                        color: AppColors.onPrimary,
                                      ),
                                      const SizedBox(width: 2),
                                      Image.asset(
                                        width: 12,
                                        height: 12,
                                        "lib/images/monitor.png",
                                        color: AppColors.onPrimary,
                                      ),
                                    ],
                                  )
                                  : widget.AndroidDevice
                                  ? Image.asset(
                                    width: 12,
                                    height: 12,
                                    "lib/images/android.png",
                                    color: AppColors.onPrimary,
                                  )
                                  : widget.ComputerDevice
                                  ? Image.asset(
                                    width: 12,
                                    height: 12,
                                    "lib/images/monitor.png",
                                    color: AppColors.onPrimary,
                                  )
                                  : const SizedBox(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.offername,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: AppColors.text,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.typeoffer,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryStrong,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            "Click to Complete",
                            style: TextStyle(
                              color: AppColors.primaryStrong,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
