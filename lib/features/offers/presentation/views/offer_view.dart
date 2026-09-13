// [2026-03-01] تم تعديل دالة showOfferDetails لتتوافق مع تصميم مودال تفاصيل العروض الجديد والمحدث.
// تم تثبيت أحجام العناصر على الشاشات العادية مع تصغيرها فقط للشاشات الصغيرة.

import 'package:credora/core/utils/size_config.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Offer extends StatefulWidget {
  final String imageUrl;
  final String offername;
  final String typeoffer;
  final int numberofpoints;
  final String deviceType;
  final bool AndroidDevice;
  final bool ComputerDevice;

  const Offer({
    required this.typeoffer,
    super.key,
    required this.imageUrl,
    required this.offername,
    this.numberofpoints = 0,
    required this.deviceType,
    required this.AndroidDevice,
    required this.ComputerDevice,
  });

  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  static const double fixedWidth = 155.0;
  static const double fixedHeight = 236.0;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return GestureDetector(
      onTap: () {
        showOfferDetails(
          context,
          nameoffer: widget.offername,
          typeoffer: widget.typeoffer,
          numberofpoint: widget.numberofpoints,
          imageUrl: widget.imageUrl,
        );
      },
      child: FittedBox(
        fit: BoxFit.contain,
        alignment: Alignment.center,
        child: SizedBox(
          width: fixedWidth,
          height: fixedHeight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.surface,
              border: Border.all(
                color: AppColors.border.withValues(alpha: 0.8),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.transparentBlack80,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 108.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                    color: AppColors.surfaceSoft,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.imageUrl),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8.0,
                        left: 8.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                            vertical: 4.0,
                          ),
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
                                        width: 12.0,
                                        height: 12.0,
                                        "lib/images/android.png",
                                        color: AppColors.onPrimary,
                                      ),
                                      const SizedBox(width: 3.0),
                                      Image.asset(
                                        width: 12.0,
                                        height: 12.0,
                                        "lib/images/monitor.png",
                                        color: AppColors.onPrimary,
                                      ),
                                    ],
                                  )
                                  : widget.AndroidDevice
                                  ? Image.asset(
                                    width: 12.0,
                                    height: 12.0,
                                    "lib/images/android.png",
                                    color: AppColors.onPrimary,
                                  )
                                  : widget.ComputerDevice
                                  ? Image.asset(
                                    width: 12.0,
                                    height: 12.0,
                                    "lib/images/monitor.png",
                                    color: AppColors.onPrimary,
                                  )
                                  : const SizedBox.shrink(),
                        ),
                      ),

                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 3.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "HOT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 6.0),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.offername,
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w900,
                      color: AppColors.text,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 2.0),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.typeoffer,
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.bolt_rounded,
                          color: AppColors.primaryStrong,
                          size: 14.0,
                        ),
                        const SizedBox(width: 2.0),
                        const Text(
                          "Reward",
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "+${widget.numberofpoints}",
                          style: const TextStyle(
                            color: AppColors.primaryStrong,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
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

// ============================================================================
// OFFER DETAILS MODAL
// ============================================================================

void showOfferDetails(
  BuildContext context, {
  String nameoffer = "Noname",
  String typeoffer = "notype",
  int numberofpoint = 300,
  String imageUrl = "",
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  double responsiveSize(double normal, double small) {
    if (screenWidth < 360) {
      return small;
    }

    return normal;
  }

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.88,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            // ============================================================
            // HANDLE BAR
            // ============================================================
            SizedBox(height: responsiveSize(12, 9)),

            Container(
              width: 40,
              height: responsiveSize(4, 3),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            SizedBox(height: responsiveSize(12, 9)),

            // ============================================================
            // SCROLLABLE CONTENT
            // ============================================================
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: responsiveSize(20, 14),
                  vertical: responsiveSize(10, 8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ======================================================
                    // TOP HEADER CARD
                    // ======================================================
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: responsiveSize(24, 18),
                        horizontal: responsiveSize(16, 12),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withValues(alpha: 0.12),
                            AppColors.primary.withValues(alpha: 0.02),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(
                          responsiveSize(24, 19),
                        ),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: responsiveSize(10, 8),
                              vertical: responsiveSize(4, 3),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(
                                responsiveSize(10, 8),
                              ),
                            ),
                            child: Text(
                              typeoffer,
                              style: TextStyle(
                                color: AppColors.primaryStrong,
                                fontSize: responsiveSize(11, 9),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),

                          SizedBox(height: responsiveSize(8, 6)),

                          Text(
                            nameoffer,
                            style: TextStyle(
                              fontSize: responsiveSize(18, 16),
                              fontWeight: FontWeight.w900,
                              color: AppColors.text,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: responsiveSize(16, 12)),

                    // ======================================================
                    // TOTAL REWARD BANNER
                    // ======================================================
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: responsiveSize(20, 14),
                        vertical: responsiveSize(16, 12),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF05A28),
                        borderRadius: BorderRadius.circular(
                          responsiveSize(20, 16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFFF05A28,
                            ).withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: responsiveSize(32, 28),
                            height: responsiveSize(32, 28),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.local_fire_department_rounded,
                                color: Colors.white,
                                size: responsiveSize(18, 15),
                              ),
                            ),
                          ),

                          SizedBox(width: responsiveSize(12, 9)),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Reward",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: responsiveSize(11, 9),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Guaranteed Payout",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: responsiveSize(14, 12),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: responsiveSize(8, 5)),

                          Flexible(
                            child: Text(
                              "+$numberofpoint PTS",
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: responsiveSize(16, 13),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: responsiveSize(24, 18)),

                    // ======================================================
                    // HOW TO COMPLETE
                    // ======================================================
                    Text(
                      "How to Complete",
                      style: TextStyle(
                        fontSize: responsiveSize(16, 14),
                        fontWeight: FontWeight.w900,
                        color: AppColors.text,
                      ),
                    ),

                    SizedBox(height: responsiveSize(12, 9)),

                    _buildStepCard(
                      context,
                      icon: Icons.launch_rounded,
                      title: "Launch Offer",
                      subtitle:
                          "Open the offer safely through our secured gateway.",
                    ),

                    SizedBox(height: responsiveSize(10, 8)),

                    _buildStepCard(
                      context,
                      icon: Icons.task_alt_rounded,
                      title: "Meet Requirements",
                      subtitle:
                          "Follow milestones and finish tasks accurately.",
                    ),

                    SizedBox(height: responsiveSize(10, 8)),

                    _buildStepCard(
                      context,
                      icon: Icons.card_giftcard_rounded,
                      title: "Claim Reward",
                      subtitle:
                          "Points will be added automatically upon verification.",
                    ),

                    SizedBox(height: responsiveSize(24, 18)),

                    // ======================================================
                    // REWARD MILESTONES
                    // ======================================================
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(responsiveSize(16, 12)),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSoft,
                        borderRadius: BorderRadius.circular(
                          responsiveSize(22, 17),
                        ),
                        border: Border.all(
                          color: AppColors.border.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.military_tech_rounded,
                                color: const Color(0xFFF05A28),
                                size: responsiveSize(20, 17),
                              ),

                              SizedBox(width: responsiveSize(8, 6)),

                              Expanded(
                                child: Text(
                                  "Reward Milestones",
                                  style: TextStyle(
                                    fontSize: responsiveSize(15, 13),
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.text,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: responsiveSize(16, 12)),

                          _buildMilestoneRow(
                            context,
                            "Reach Height Level 150",
                            "+39 PTS",
                          ),

                          _buildMilestoneRow(
                            context,
                            "Reach Height Level 400",
                            "+85 PTS",
                          ),

                          _buildMilestoneRow(
                            context,
                            "Reach Height Level 600",
                            "+1053 PTS",
                          ),

                          _buildMilestoneRow(
                            context,
                            "Reach Height Level 900",
                            "+2756 PTS",
                          ),

                          _buildMilestoneRow(
                            context,
                            "Reach Height Level 1200",
                            "+4330 PTS",
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: responsiveSize(30, 22)),
                  ],
                ),
              ),
            ),

            // ============================================================
            // FIXED BOTTOM START OFFER BUTTON
            // ============================================================
            Container(
              padding: EdgeInsets.all(responsiveSize(20, 14)),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: responsiveSize(52, 46),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF05A28),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        responsiveSize(16, 13),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_arrow_rounded,
                        size: responsiveSize(22, 18),
                      ),

                      SizedBox(width: responsiveSize(4, 3)),

                      Flexible(
                        child: Text(
                          'START OFFER (+$numberofpoint PTS)',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: responsiveSize(14, 11),
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

// ============================================================================
// STEP CARD
// ============================================================================

Widget _buildStepCard(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String subtitle,
}) {
  final screenWidth = MediaQuery.of(context).size.width;

  double size(double normal, double small) {
    if (screenWidth < 360) {
      return small;
    }

    return normal;
  }

  return Container(
    padding: EdgeInsets.all(size(12, 9)),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(size(16, 13)),
      border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
    ),
    child: Row(
      children: [
        Container(
          width: size(38, 32),
          height: size(38, 32),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(size(12, 10)),
          ),
          child: Center(
            child: Icon(
              icon,
              color: const Color(0xFFF05A28),
              size: size(18, 15),
            ),
          ),
        ),

        SizedBox(width: size(12, 9)),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: size(13, 11),
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),

              SizedBox(height: size(2, 1)),

              Text(
                subtitle,
                style: TextStyle(
                  fontSize: size(11, 9),
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// MILESTONE ROW
// ============================================================================

Widget _buildMilestoneRow(
  BuildContext context,
  String milestoneTitle,
  String points,
) {
  final screenWidth = MediaQuery.of(context).size.width;

  double size(double normal, double small) {
    if (screenWidth < 360) {
      return small;
    }

    return normal;
  }

  return Padding(
    padding: EdgeInsets.symmetric(vertical: size(8, 6)),
    child: Row(
      children: [
        Icon(
          Icons.check_circle_outline_rounded,
          color: Colors.grey.shade400,
          size: size(18, 15),
        ),

        SizedBox(width: size(10, 7)),

        Expanded(
          child: Text(
            milestoneTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: size(12, 10),
              fontWeight: FontWeight.w700,
              color: AppColors.text,
            ),
          ),
        ),

        SizedBox(width: size(6, 4)),

        Container(
          padding: EdgeInsets.symmetric(
            horizontal: size(10, 7),
            vertical: size(4, 3),
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(size(8, 6)),
          ),
          child: Text(
            points,
            style: TextStyle(
              color: const Color(0xFF2E7D32),
              fontSize: size(11, 9),
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    ),
  );
}
