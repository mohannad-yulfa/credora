// [2026-09-13] تم تحديث كلاس OfferWall ليطابق تماماً التصميم الظاهر في الصورة (أيقونة المتجر في المنتصف، زر السهم الدائري في الزاوية اليمنى السفلى، وشارة الحريق في الزاوية اليمنى العليا).
// تم إضافة FittedBox لجعل الـ Card متجاوباً (Responsive) على الشاشات الصغيرة جداً مع الحفاظ على أبعاد ثابتة على الشاشات الأكبر.

import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OfferWall extends StatefulWidget {
  final String imageUrl;
  final VoidCallback? onTap;

  const OfferWall({super.key, required this.imageUrl, this.onTap});

  @override
  State<OfferWall> createState() => _OfferWallState();
}

class _OfferWallState extends State<OfferWall>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  // تم تعريف الأبعاد الثابتة للـ Card كما طلبت
  static const double fixedWidth = 160.0;
  static const double fixedHeight = 140.0;

  @override
  Widget build(BuildContext context) {
    // مبادئ التصميم المتجاوب:
    // 1. FittedBox: سيقوم بتصغير محتوى الـ SizedBox بالكامل كصورة واحدة إذا كان عرض الشاشة أصغر من fixedWidth،
    //    مما يمنع الـ Overflow ويحافظ على سلامة التصميم.
    // 2. SizedBox: يفرض قياسات ثابتة للـ Card، والتي سيتم احترامها على الشاشات التي تتسع لها.

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap ?? () {},
      child: AnimatedScale(
        scale:
            _isPressed ? 0.97 : 1.0, // تم تقليل نسبة الـ Scale لتكون أكثر نعومة
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        // تغليف المحتوى بـ FittedBox لضمان التجاوب على الشاشات الصغيرة
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.center,
          child: SizedBox(
            width: fixedWidth,
            height: fixedHeight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  width: 1.5, // تم زيادة سمك الحدود قليلاً لتظهر بوضوح
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // صورة الخلفية
                    Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            color: AppColors.surfaceSoft,
                            child: const Icon(
                              Icons.broken_image_rounded,
                              color: AppColors.textMuted,
                              size: 32,
                            ),
                          ),
                    ),
                    // تدرج لوني أسود مطابق لتصميم الصورة يعطي عمقا وعتمة سفلية
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.3, 1.0],
                        ),
                      ),
                    ),

                    // شارة الحريق في الزاوية اليمنى العليا مطابقة للصورة
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 28, // تم تكبير الشارة قليلاً لتتناسب مع الـ Card
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.transparentBlack97,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.local_fire_department_rounded,
                            color: Color(0xFFFF9800),
                            size: 16,
                          ),
                        ),
                      ),
                    ),

                    // أيقونة المتجر في منتصف الكارد العلوي
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 24),
                        child: Icon(
                          Icons.storefront_rounded,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ),

                    // النصوص وزر السهم الدائري في الأسفل مطابقة تماما للصورة
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Offer Wall",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15, // حجم خط مناسب للأبعاد الثابتة
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Container(
                            width: 24, // تم تكبير الزر قليلاً لسهولة الضغط عليه
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF5722),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 12,
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
